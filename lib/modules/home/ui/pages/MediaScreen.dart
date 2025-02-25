import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/service/permission_service.dart';
import 'package:my_shelf_project/core/service/share_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/core/utils/FileValidator.dart';
import 'package:my_shelf_project/modules/home/domain/models/media_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/media_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/VideoThumbnail.dart';

class MediaScreen extends ConsumerStatefulWidget {
  const MediaScreen({super.key});

  @override
  ConsumerState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends ConsumerState<MediaScreen> {
  final List<String> source = ['Photo', 'Video', 'GIF'];
  int selectedSource = 0;
  bool isSubCategoryActive = false;
  bool isPinActive = false;

  final String emptyHeading = "No media found!";
  final String emptyDescription = "Tap Add New button to save your files";

  @override
  Widget build(BuildContext context) {
    final mediaList = ref.watch(mediaProvider);
    final List<MediaModel> pinnedMedia = getPinnedMedia(mediaList);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xSmall),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_rounded),
            color: Colors.black,
            iconSize: 30,
          ),
        ),
        title: GestureDetector(
          onTap: toggleSubCategory,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeTitle(title: 'Media'),
                Icon(
                  isSubCategoryActive
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 25,
                  color: Colors.black,
                )
              ]),
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () => pinController(),
              icon: Icon(
                isPinActive ? Icons.star_rounded : Icons.star_border_rounded,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list_rounded,
                color: Colors.black,
              )),
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.medium),
            child: PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
              color: AppColors.onboardDarkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 1,
              onSelected: (value) {
                print("Selected: $value");
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                _buildPopupMenuItem(
                    "Add Media", Icons.perm_media_rounded, Colors.black),
                _buildPopupMenuItem(
                    "Filter Media", Icons.filter_alt_rounded, Colors.black)
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSubCategoryActive)
            HomePillBar(
                source: source,
                selectedSource: selectedSource,
                activeColor: AppColors.onboardDarkBlue,
                inactiveColor: AppColors.onboardLightBlue),
          SizedBox(
            height: 10,
          ),
          mediaList.isEmpty
              ? HomeCard(
                  title: emptyHeading,
                  description: emptyDescription,
                  icon: Icons.perm_media_rounded,
                  iconColor: AppColors.onboardDarkBlue)
              : Expanded(
                  child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      pinnedMedia.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.medium,
                                  vertical: AppSpacing.xSmall),
                              child: SizedBox(
                                height: 180,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pinnedMedia.length <= 5 ? pinnedMedia.length : 6,
                                    itemBuilder: (context, index) {
                                      final media = pinnedMedia[index];
                                      return Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.2,
                                            child: Container(
                                              width: 150,
                                              margin: EdgeInsets.only(right: AppSpacing.xxSmall),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.black12),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: FileValidator.getMediaFileType(media.fileType) == "video"
                                                  ? VideoThumbnail(videoPath: media.filePath)
                                                  : Image.file(File(media.filePath), fit: BoxFit.cover),
                                            ),
                                          ),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                onPressed: () => ShareService.shareFile(media.filePath),
                                                icon: CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                        Icons.ios_share_rounded,
                                                        color: AppColors.onboardDarkBlue,
                                                        size: 18),),
                                                color: AppColors.onboardDarkBlue,
                                              ),)
                                        ],
                                      );
                                    }),
                              ),
                            )
                          : SizedBox(),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium),
                        itemCount: mediaList.length,
                        itemBuilder: (context, index) {
                          final media = mediaList[index];
                          return GestureDetector(
                              onLongPress: () async {
                                await ref.read(mediaProvider.notifier).deleteMedia(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Media deleted")),
                                );
                              },
                              onTap: () {
                                context.push(
                                  '/home/media/view',
                                  extra: {
                                    'filePath': media.filePath,
                                    'fileType': FileValidator.getMediaFileType(
                                        media.fileType),
                                  },
                                );
                              },
                              onDoubleTap: () => togglePinMedia(media.filename),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(color: Colors.black12)),
                                      clipBehavior: Clip.hardEdge,
                                      child: FileValidator.getMediaFileType(media.fileType) == "video"
                                          ? VideoThumbnail(videoPath: media.filePath)
                                          : Image.file(File(media.filePath), fit: BoxFit.cover),
                                    ),
                                  ),
                                  if (media.isPinned)
                                    Positioned(
                                        top: -1,
                                        right: -1,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 10,
                                          child: Icon(
                                            Icons.stars_rounded,
                                            size: 16,
                                            color: AppColors.onboardDarkBlue,
                                          ),
                                        ))
                                ],
                              ));
                        },
                      ),
                    ],
                  ),
                )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onTapMediaBtn, // Keep the original function
        backgroundColor: AppColors.onboardDarkBlue, // Use the same color
        label: Row(
          children: [
            Text("Add New", style: AppTextStyles.homePinned), // Keep the text
            SizedBox(width: 8),
            Icon(Icons.add_circle_rounded, size: 30, color: AppColors.onboardLightBlue) // Keep the icon
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, Color iconColor) {
    return PopupMenuItem<String>(
      value: text,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          splashColor: AppColors.onboardLightBlue,
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

  void onTapMediaBtn() async {
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

  void togglePinMedia(String filename) {
    ref.read(mediaProvider.notifier).togglePin(filename);
  }

  toggleSubCategory() {
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
}
