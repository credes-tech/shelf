import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/service/permission_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/media_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/media_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/MediaItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/SubCategoryDivider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/SubCategoryToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/UserAccount.dart';
import 'package:open_filex/open_filex.dart';

class MediaScreen extends ConsumerStatefulWidget {
  const MediaScreen({super.key});

  @override
  ConsumerState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends ConsumerState<MediaScreen> {
  final List<String> source = ['All Files', 'Recently Added'];
  int selectedSource = 0;
  bool isSubCategoryActive = false;
  bool isPinActive = false;
  bool isMultiSelectActive = false;
  List<MediaModel> selectedMedia = [];

  final String emptyHeading = "No media found!";
  final String emptyDescription = "Tap Add New button to save your files";

  @override
  Widget build(BuildContext context) {
    final mediaList = ref.watch(mediaProvider);
    final List<MediaModel> pinnedMedia = getPinnedMedia(mediaList);
    final List<MediaModel> recentMedia = getRecentlyAddedMedia(mediaList);
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
                HomeTitle(title: 'Media'),
                SubCategoryToggler(isSubCategoryActive: isSubCategoryActive)
              ]),
        ),
        titleSpacing: 0.0,
        actions: [
          if (isMultiSelectActive)
            IconButton(
                onPressed: deleteMediaFiles,
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
                      "${pinnedMedia.length}",
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
                  activeColor: AppColors.onboardDarkBlue,
                  inactiveColor: AppColors.onboardLightBlue,
                  onSelected: (index) {
                    setState(() {
                      selectedSource = index;
                    });
                  },
                ),
              SizedBox(
                height: 10,
              ),
              mediaList.isEmpty
                  ? HomeCard(
                      title: emptyHeading,
                      description: emptyDescription,
                      icon: Icons.perm_media_rounded,
                      iconColor: AppColors.onboardDarkBlue)
                  : isSubCategoryActive
                      ? Expanded(
                          child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubCategoryDivider(
                                  subCategoryTitle: source[selectedSource]),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.medium),
                                itemCount: getSelectedSourceLength(
                                    source[selectedSource], mediaList),
                                itemBuilder: (context, index) {
                                  final selectedMediaList =
                                      getSelectedSourceItems(
                                          source[selectedSource], mediaList);
                                  final media = selectedMediaList[index];
                                  return GestureDetector(
                                      onTap: () => openFile(media.filePath),
                                      onDoubleTap: () =>
                                          togglePinMedia(media.filename),
                                      child: MediaItem(
                                        media: media,
                                        isPinActive: true,
                                        isSelected: false,
                                      ));
                                },
                              ),
                            ],
                          ),
                        ))
                      : Expanded(
                          child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (pinnedMedia.isNotEmpty)
                                SubCategoryDivider(subCategoryTitle: 'Pinned'),
                              if (pinnedMedia.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.medium,
                                      vertical: AppSpacing.xSmall),
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: pinnedMedia.length,
                                        itemBuilder: (context, index) {
                                          final media = pinnedMedia[index];
                                          return GestureDetector(
                                            onTap: () =>
                                                openFile(media.filePath),
                                            child: MediaItem(
                                              media: media,
                                              isPinActive: false,
                                              isSelected: false,
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              if (recentMedia.isNotEmpty)
                                SubCategoryDivider(
                                    subCategoryTitle: 'Recently Added'),
                              if (recentMedia.isNotEmpty)
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSpacing.medium),
                                  itemCount: recentMedia.length,
                                  itemBuilder: (context, index) {
                                    final media = recentMedia[index];
                                    return GestureDetector(
                                        onTap: () => openFile(media.filePath),
                                        onDoubleTap: () =>
                                            togglePinMedia(media.filename),
                                        child: MediaItem(
                                            media: media,
                                            isPinActive: false,
                                            isSelected: false));
                                  },
                                ),
                              SubCategoryDivider(subCategoryTitle: 'All Files'),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.medium),
                                itemCount: mediaList.length,
                                itemBuilder: (context, index) {
                                  final media = mediaList[index];
                                  return GestureDetector(
                                      onLongPress: () => !isMultiSelectActive
                                          ? manageMultipleFiles(media)
                                          : null,
                                      onTap: () => isMultiSelectActive
                                          ? selectedMedia.contains(media)
                                              ? removeFile(media)
                                              : addFile(media)
                                          : openFile(media.filePath),
                                      onDoubleTap: () =>
                                          togglePinMedia(media.filename),
                                      child: MediaItem(
                                          media: media,
                                          isPinActive: true,
                                          isSelected:
                                              selectedMedia.contains(media)));
                                },
                              ),
                            ],
                          ),
                        )),
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
                  onPressed: onTapMediaBtn,
                  backgroundColor: AppColors.onboardLightBlue,
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(Icons.add_circle_rounded, size: 30, color: AppColors.navBarBlue),
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
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          splashColor: AppColors.onboardDarkBlue,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            print("$text clicked");
          },
          child:
              HomeMenuItem(icon: icon, iconColor: iconColor, itemValue: text),
        ),
      ),
    );
  }

  onTapMediaBtn() async {
    bool isGranted = await PermissionService.requestMediaPermission();
    if (isGranted == true) {
      await ref.read(mediaProvider.notifier).pickAndSaveMedia();
    } else {
      print("Permission denied");
    }
  }

  List<MediaModel> getPinnedMedia(List<MediaModel> mediaList) {
    return mediaList.where((media) => media.isPinned).toList();
  }

  List<MediaModel> getRecentlyAddedMedia(List<MediaModel> mediaList) {
    int minute = 2;
    DateTime now = DateTime.now();
    DateTime threshold = now.subtract(Duration(minutes: minute));
    return mediaList.where((media) => media.date.isAfter(threshold)).toList();
  }

  int getSelectedSourceLength(String source, List<MediaModel> mediaList) {
    print(source);
    switch (source) {
      case "All Files":
        return mediaList.length;
      case "Recently Added":
        return getRecentlyAddedMedia(mediaList).length;
    }
    return mediaList.length;
  }

  List<MediaModel> getSelectedSourceItems(
      String source, List<MediaModel> mediaList) {
    switch (source) {
      case "All Files":
        return mediaList;
      case "Recently Added":
        return getRecentlyAddedMedia(mediaList);
    }
    return mediaList;
  }

  togglePinMedia(String filename) {
    ref.read(mediaProvider.notifier).togglePin(filename);
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

  pinController() {
    bool pinStatus = ref.read(mediaProvider.notifier).togglePinnedFilter();
    setState(() {
      isPinActive = pinStatus;
    });
  }

  openFile(String filePath) async {
    await OpenFilex.open(filePath);
  }

  manageMultipleFiles(MediaModel mediaFile) {
    setState(() {
      isMultiSelectActive = true;
    });
    addFile(mediaFile);
  }

  addFile(MediaModel mediaFile) {
    setState(() {
      selectedMedia = List.from(selectedMedia)..add(mediaFile);
    });
  }

  removeFile(MediaModel mediaFile) {
    if (selectedMedia.length == 1) {
      clearSelection();
    } else {
      setState(() {
        selectedMedia = List.from(selectedMedia)..remove(mediaFile);
      });
    }
  }

  void clearSelection() {
    setState(() {
      isMultiSelectActive = false;
      selectedMedia.clear();
    });
  }

  void deleteMediaFiles() async {
    await ref.read(mediaProvider.notifier).deleteMedia(selectedMedia);
    clearSelection();
  }
}
