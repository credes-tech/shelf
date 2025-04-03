import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/link_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/link_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/SubCategoryToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/UserAccount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class LinkScreen extends ConsumerStatefulWidget {
  const LinkScreen({super.key});

  @override
  ConsumerState<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends ConsumerState<LinkScreen> {
  final List<String> source = ['All Links', 'Recently Added'];
  int selectedSource = 0;
  bool isSubCategoryActive = false;
  bool isPinActive = false;
  bool isMultiSelectActive = false;
  bool urlError = false;
  List<LinkModel> selectedLinks = [];
  final _addLinkformKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();

  final String emptyHeading = "No Links found!";
  final String emptyDescription = "Tap Add New button to Add new links";

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final linkList = ref.watch(linkProvider);
    final List<LinkModel> pinnedLinks = getPinnedLinks(linkList);
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
                HomeTitle(title: 'Links'),
                SubCategoryToggler(isSubCategoryActive: isSubCategoryActive)
              ]),
        ),
        titleSpacing: 0.0,
        actions: [
          if (isMultiSelectActive)
            IconButton(
                onPressed: deleteLinks,
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
                      "${pinnedLinks.length}",
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
                color: AppColors.onboardLightGreen,
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
                  activeColor: AppColors.onboardDarkGreen,
                  inactiveColor: AppColors.onboardLightGreen,
                  onSelected: (index) {
                    setState(() {
                      selectedSource = index; // Update selected pill
                    });
                  },
                ),
              SizedBox(
                height: 10,
              ),
              linkList.isEmpty
                  ? HomeCard(
                      title: emptyHeading,
                      description: emptyDescription,
                      icon: Icons.add_link,
                      iconColor: AppColors.onboardDarkGreen)
                  : isSubCategoryActive
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: getSelectedSourceLength(
                                  source[selectedSource], linkList),
                              itemBuilder: (context, index) {
                                final selectedLinkList = getSelectedSourceItems(
                                    source[selectedSource], linkList);
                                final link = selectedLinkList[index];
                                return GestureDetector(
                                  onTap: () => openLink(linkList[index]),
                                  onDoubleTap: () => togglePinLink(link.url),
                                  child: linkCard(linkList, index),
                                );
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: linkList.length,
                              itemBuilder: (context, index) {
                                final link = linkList[index];
                                return GestureDetector(
                                  key: ValueKey(link.url),
                                  onTap: () => isMultiSelectActive
                                      ? selectedLinks.contains(link)
                                          ? removeLink(link)
                                          : addLink(link)
                                      : openLink(linkList[index]),
                                  onDoubleTap: () => !isMultiSelectActive
                                      ? togglePinLink(link.url)
                                      : {},
                                  onLongPress: () => !isMultiSelectActive
                                      ? manageMultipleLinks(link)
                                      : null,
                                  child: Stack(
                                    children: [
                                      linkCard(linkList, index),
                                      if (link.isPinned)
                                        Positioned(
                                            top: 12,
                                            right: 20,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 10,
                                              child: Icon(
                                                Icons.stars_rounded,
                                                size: 27,
                                                color:
                                                    AppColors.onboardDarkGreen,
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
                  onPressed: onTapLinkBtn,
                  backgroundColor: AppColors.onboardLightGreen,
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(Icons.add_circle_rounded,
                      size: 25, color: AppColors.onboardDarkGreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openLink(LinkModel link) async {
    if (!isMultiSelectActive) {
      final Uri url = Uri.parse(link.url);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  Widget linkCard(linkList, index) {
    String title = linkList[index].title ?? "";
    String description = linkList[index].description ?? "";
    String thumbnail = linkList[index].thumbnail ?? "";
    print("thumbnail is here $thumbnail");
    title = title.length > 20 ? "${title.substring(0, 20)}..." : title;
    description =
        description.length > 35 ? "${description.substring(0, 35)}..." : title;

    return Container(
      width: double.maxFinite,
      height: 70,
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedLinks.contains(linkList[index])
              ? AppColors.onboardDarkOrange
              : AppColors.onboardDarkGreen,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            if (thumbnail.isNotEmpty)
              Image.network(
                thumbnail,
                width: 20,
                height: 20,
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: TextStyle(color: AppColors.onboardDarkGreen),
                  ),
              ],
            )
          ],
        ),
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
          splashColor: AppColors.onboardLightGreen,
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

  List<LinkModel> getPinnedLinks(List<LinkModel> linkList) {
    return linkList.where((link) => link.isPinned).toList();
  }

  pinController() {
    bool pinStatus = ref.read(linkProvider.notifier).togglePinnedFilter();
    setState(() {
      isPinActive = pinStatus;
    });
  }

  void addLinkBtn() async {
    if (_addLinkformKey.currentState!.validate()) {
      var data = await MetadataFetch.extract(_urlController.text);

      LinkModel link = LinkModel(
        url: _urlController.text,
        date: DateTime.now(),
        title: data != null ? data.title : "",
        description: data != null ? data.description : "",
        // thumbnail: data != null ? data.image : "",
      );
      // link.description = "";

      // print(data);

      ref.read(linkProvider.notifier).addNewLink(link);
      Navigator.pop(context);
    }
  }

  void onTapLinkBtn() async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.onboardDarkGreen,
      builder: (BuildContext context) {
        return Form(
          key: _addLinkformKey,
          child: Container(
            height: 600,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _urlController,
                    validator: (value) {
                      if (value != null &&
                          (value.trim().isEmpty ||
                              !Uri.parse(value).isAbsolute)) {
                        return "Please provide a valid Url.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Link',
                    ),
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: addLinkBtn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.onboardDarkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Add Link'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => _urlController.text = "");
  }

  List<LinkModel> getRecentlyAddedMedia(List<LinkModel> linkList) {
    int minute = 2;
    DateTime now = DateTime.now();
    DateTime threshold = now.subtract(Duration(minutes: minute));
    return linkList.where((link) => link.date.isAfter(threshold)).toList();
  }

  int getSelectedSourceLength(String source, List<LinkModel> linkList) {
    switch (source) {
      case "All Links":
        return linkList.length;
      case "Recently Added":
        return getRecentlyAddedMedia(linkList).length;
    }
    return linkList.length;
  }

  List<LinkModel> getSelectedSourceItems(
      String source, List<LinkModel> linkList) {
    switch (source) {
      case "All Links":
        return linkList;
      case "Recently Added":
        return getRecentlyAddedMedia(linkList);
    }
    return linkList;
  }

  void togglePinLink(String linkName) {
    ref.read(linkProvider.notifier).togglePin(linkName);
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

  // openLink(String linkPath) async {
  //   await OpenLinkx.open(linkPath);
  // }

  manageMultipleLinks(LinkModel docLink) {
    setState(() {
      isMultiSelectActive = true;
    });
    addLink(docLink);
  }

  addLink(LinkModel docLink) {
    if (isPinActive) {
      bool pinStatus = ref.read(linkProvider.notifier).onlyTogglePin();
      setState(() {
        isPinActive = pinStatus;
      });
    }
    setState(() {
      selectedLinks = List.from(selectedLinks)..add(docLink);
    });
  }

  removeLink(LinkModel docLink) {
    if (isPinActive) {
      bool pinStatus = ref.read(linkProvider.notifier).onlyTogglePin();
      setState(() {
        isPinActive = pinStatus;
      });
    }
    if (selectedLinks.length == 1) {
      clearSelection();
    } else {
      setState(() {
        selectedLinks = List.from(selectedLinks)..remove(docLink);
      });
    }
  }

  void clearSelection() {
    setState(() {
      isMultiSelectActive = false;
      selectedLinks.clear();
    });
  }

  void deleteLinks() async {
    await ref.read(linkProvider.notifier).deleteLink(selectedLinks);
    clearSelection();
  }
}
