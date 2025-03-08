import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/service/permission_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/file_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/file_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/FileCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/SubCategoryDivider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/SubCategoryToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/UserAccount.dart';
import 'package:open_filex/open_filex.dart';

class FileScreen extends ConsumerStatefulWidget {
  const FileScreen({super.key});

  @override
  ConsumerState<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends ConsumerState<FileScreen> {
  final List<String> source = ['All Files', 'Recently Added'];
  int selectedSource = 0;
  bool isSubCategoryActive = false;
  bool isPinActive = false;
  bool isMultiSelectActive = false;
  List<FileModel> selectedFiles = [];

  final String emptyHeading = "No documents found!";
  final String emptyDescription = "Tap Add New button to save your files";

  @override
  Widget build(BuildContext context) {
    final fileList = ref.watch(fileProvider);
    final List<FileModel> pinnedFiles = getPinnedFiles(fileList);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xSmall),
          child: UserAccount(),
        ),
        title: GestureDetector(
          onTap: toggleSubCategory,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeTitle(title: 'Documents'),
                SubCategoryToggler(isSubCategoryActive: isSubCategoryActive)
              ]),
        ),
        titleSpacing: 0.0,
        actions: [
          if (isMultiSelectActive)
            IconButton(
                onPressed: deleteDocFiles,
                icon: Icon(
                  Icons.delete_rounded,
                  color: Colors.black,
                )),
          if (isMultiSelectActive)
            IconButton(
                onPressed: clearSelection,
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                )),
          if (!isSubCategoryActive && !isMultiSelectActive)
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                )),
          if (!isSubCategoryActive && !isMultiSelectActive)
            Stack(
              children: [
                IconButton(
                  onPressed: () => pinController(),
                  icon: Icon(
                    isPinActive
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: Text(
                      "${pinnedFiles.length}",
                      style: AppTextStyles.pinCaption,
                    ))
              ],
            ),
          if (!isSubCategoryActive && !isMultiSelectActive)
            Padding(
              padding: EdgeInsets.only(
                  right: AppSpacing.medium, left: AppSpacing.small),
              child: PopupMenuButton<String>(
                icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
                color: AppColors.onboardLightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 1,
                onSelected: (value) {
                  print("Selected: $value");
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  _buildPopupMenuItem(
                      "List View", Icons.list_rounded, Colors.black),
                  _buildPopupMenuItem(
                      "Grid View", Icons.grid_view_rounded, Colors.black),
                ],
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSubCategoryActive)
                HomePillBar(
                  source: source,
                  selectedSource: selectedSource,
                  activeColor: AppColors.onboardDarkPink,
                  inactiveColor: AppColors.onboardLightPink,
                  onSelected: (index) {
                    setState(() {
                      selectedSource = index; // Update selected pill
                    });
                  },
                ),
              SizedBox(
                height: 10,
              ),
              fileList.isEmpty
                  ? HomeCard(
                      title: emptyHeading,
                      description: emptyDescription,
                      icon: Icons.picture_as_pdf_rounded,
                      iconColor: AppColors.onboardDarkPink)
                  : isSubCategoryActive
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: getSelectedSourceLength(
                                  source[selectedSource], fileList),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final selectedFileList =
                                getSelectedSourceItems(
                                    source[selectedSource], fileList);
                                final file = selectedFileList[index];
                                return GestureDetector(
                                    onTap: () {
                                      context.push(
                                        '/home/file/view',
                                        extra: {
                                          'filePath': file.filePath,
                                          'fileName': file.filename,
                                        },
                                      );
                                    },
                                    onDoubleTap: () =>
                                        togglePinFile(file.filename),
                                    child: FileCard(file: file));
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: fileList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final file = fileList[index];
                                return GestureDetector(
                                  onTap: () async {
                                    await OpenFilex.open(file.filePath);
                                  },
                                  onDoubleTap: () =>
                                      togglePinFile(file.filename),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 0.8,
                                          child: FileCard(file: file)),
                                      if (file.isPinned)
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 10,
                                              child: Icon(
                                                Icons.stars_rounded,
                                                size: 20,
                                                color:
                                                    AppColors.onboardDarkPink,
                                              ),
                                            ))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: AppSpacing.large, bottom: 25),
              child: SizedBox(
                width: 55,
                height: 55,
                child: FloatingActionButton(
                  onPressed: onTapFileBtn,
                  backgroundColor: AppColors.onboardLightPink,
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(Icons.add_circle_rounded,
                      size: 25, color: AppColors.navBarPink),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, Color iconColor) {
    return PopupMenuItem<String>(
      value: text,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          splashColor: AppColors.onboardLightPink,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            print("$text clicked");
          },
          child:
              HomeMenuItem(icon: icon, iconColor: iconColor, itemValue: text),
        ),
      ),
    );
  }

  List<FileModel> getPinnedFiles(List<FileModel> fileList) {
    return fileList.where((file) => file.isPinned).toList();
  }

  pinController() {
    bool pinStatus = ref.read(fileProvider.notifier).togglePinnedFilter();
    setState(() {
      isPinActive = pinStatus;
    });
  }

  void onTapFileBtn() async {
    bool isGranted = await PermissionService.requestFilePermission();
    if (isGranted == true) {
      await ref.read(fileProvider.notifier).pickAndSaveFile();
    } else {
      print("Permission denied");
    }
  }

  List<FileModel> getRecentlyAddedMedia(List<FileModel> fileList) {
    int minute = 2;
    DateTime now = DateTime.now();
    DateTime threshold = now.subtract(Duration(minutes: minute));
    return fileList.where((file) => file.date.isAfter(threshold)).toList();
  }

  int getSelectedSourceLength(String source, List<FileModel> fileList) {
    switch (source) {
      case "All Files":
        return fileList.length;
      case "Recently Added":
        return getRecentlyAddedMedia(fileList).length;
    }
    return fileList.length;
  }

  List<FileModel> getSelectedSourceItems(
      String source, List<FileModel> fileList) {
    switch (source) {
      case "All Files":
        return fileList;
      case "Recently Added":
        return getRecentlyAddedMedia(fileList);
    }
    return fileList;
  }

  void togglePinFile(String fileName) {
    ref.read(fileProvider.notifier).togglePin(fileName);
  }

  toggleSubCategory() {
    if (isPinActive) {
      pinController();
    }
    if (isMultiSelectActive) {
      return;
    }
    setState(() {
      isSubCategoryActive = !isSubCategoryActive;
    });
  }

  void clearSelection() {
    setState(() {
      isMultiSelectActive = false;
      selectedFiles.clear();
    });
  }

  void deleteDocFiles() async {
    await ref.read(fileProvider.notifier).deleteFile(selectedFiles);
    clearSelection();
  }
}
