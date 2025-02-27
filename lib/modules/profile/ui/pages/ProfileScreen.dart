import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/UserAccount.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileItem.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileSubHeading.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileTitle.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/StorageItem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xSmall),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
        ),
        title: ProfileTitle(title: 'Karl marx'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_rounded,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.medium),
            child: IconButton(
              onPressed: () {
                context.push("/home/profile/settings");
              },
              icon: Icon(
                Icons.settings_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {},
            child:
                ProfileItem(icon: Icons.move_to_inbox_rounded, value: 'Inbox'),
          ),
          GestureDetector(
            onTap: () {},
            child: ProfileItem(icon: Icons.lock_rounded, value: 'Access Vault'),
          ),
          GestureDetector(
            onTap: () {},
            child: ProfileItem(
                icon: Icons.label_important_rounded,
                value: 'Filters and Labels'),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileSubHeading(title: "Manage Categories"),
          SizedBox(
            height: 20,
          ),
          StorageItem(
            icon: Icons.move_to_inbox_rounded,
            value: 'Audio',
            color: AppColors.onboardDarkOrange,
            size: '38 MB',
          ),
          StorageItem(
            icon: Icons.perm_media_rounded,
            value: 'Media',
            color: AppColors.onboardDarkBlue,
            size: '100 MB',
          ),
          StorageItem(
            icon: Icons.file_open_rounded,
            value: 'Files',
            color: AppColors.onboardDarkPink,
            size: '15 MB',
          ),
          StorageItem(
            icon: Icons.edit_note_rounded,
            value: 'Notes',
            color: AppColors.onboardDarkYellow ,
            size: '5 MB',
          ),
        ],
      ),
    );
  }
}
