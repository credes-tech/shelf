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

class FileScreen extends ConsumerStatefulWidget {
  const FileScreen({super.key});

  @override
  ConsumerState<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends ConsumerState<FileScreen> {
  final List<String> source = ['Files', 'Docs'];

  final String emptyHeading = "No documents found!";
  final String emptyDescription = "Tap Add New button to save your files";

  int selectedSource = 0;

  @override
  Widget build(BuildContext context) {
    final fileList = ref.watch(fileProvider);
    final bool filePinnedNotifier =
        ref.read(fileProvider.notifier).showOnlyPinned;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Documents'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.medium),
            child: PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
              color: AppColors.onboardDarkPink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 1,
              onSelected: (value) {
                print("Selected: $value");
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                _buildPopupMenuItem(
                    "Add File", Icons.file_copy_rounded, Colors.black),
                _buildPopupMenuItem(
                    "Filter Files", Icons.filter_alt_rounded, Colors.black)
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomePillBar(
              source: source,
              selectedSource: selectedSource,
              activeColor: AppColors.onboardDarkPink,
              inactiveColor: AppColors.onboardLightPink),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.medium, vertical: AppSpacing.xSmall),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeToggler(
                      initialValue: filePinnedNotifier,
                      onChanged: (filePinnedNotifier) {
                        ref.read(fileProvider.notifier).togglePinnedFilter();
                      },
                      color: AppColors.onboardDarkPink,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Quick Access", style: AppTextStyles.pinLabelText),
                  ],
                ),
                ElevatedButton(
                  onPressed: onTapFileBtn,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                          left: AppSpacing.medium,
                          right: AppSpacing.xSmall,
                          top: AppSpacing.xSmall,
                          bottom: AppSpacing.xSmall),
                      backgroundColor: AppColors.onboardDarkPink),
                  child: Row(
                    children: [
                      Text("Add New", style: AppTextStyles.homePinned),
                      SizedBox(width: 8),
                      Icon(Icons.add_circle_rounded,
                          size: 30, color: AppColors.onboardLightPink)
                    ],
                  ),
                )
              ],
            ),
          ),
          fileList.isEmpty
              ? HomeCard(
                  title: emptyHeading,
                  description: emptyDescription,
                  icon: Icons.picture_as_pdf_rounded,
                  iconColor: AppColors.onboardDarkPink)
              : Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: fileList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final file = fileList[index];
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
                          onDoubleTap: () => togglePinFile(file.filename),
                          onLongPress: () async {
                            await ref
                                .read(fileProvider.notifier)
                                .deleteFile(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("File deleted")),
                            );
                          },
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
                                        color: AppColors.onboardDarkPink,
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

  void onTapFileBtn() async {
    bool isGranted = await PermissionService.requestFilePermission();
    if (isGranted == true) {
      await ref.read(fileProvider.notifier).pickAndSaveFile();
    } else {
      print("Permission denied");
    }
  }

  void togglePinFile(String fileName) {
    ref.read(fileProvider.notifier).togglePin(fileName);
  }
}
