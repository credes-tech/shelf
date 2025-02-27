import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileItem.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileSubHeading.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileTitle.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> themes = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xSmall),
          child: Icon(
              Icons.settings_rounded,
              color: Colors.black,
          ),
        ),
        title: ProfileTitle(title: 'Settings'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.medium),
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
            ProfileItem(icon: Icons.loyalty_rounded, value: 'Explore Subscription'),
          ),
          GestureDetector(
            onTap: () {},
            child:
            ProfileItem(icon: Icons.widgets_rounded, value: 'App Widgets'),
          ),
          GestureDetector(
            onTap: () {},
            child:
            ProfileItem(icon: Icons.account_circle_rounded, value: 'Manage Account'),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileSubHeading(title: "Personalization"),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.large, vertical: AppSpacing.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.palette_rounded ,
                  color: Colors.black,
                  size: 25,
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Themes",
                        style: AppTextStyles.profileTextItems,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.large),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: 'Light',
                          onChanged: (String? newTheme) {},
                          items: themes.map<DropdownMenuItem<String>>((String theme) {
                            return DropdownMenuItem<String>(
                              value: theme,
                              child: Text(theme,style: AppTextStyles.profileTextItems),
                            );
                          }).toList(),
                          dropdownColor: Colors.white,
                          underline: SizedBox(), // Remove default underline
                          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.large, vertical: AppSpacing.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.insert_emoticon_rounded ,
                  color: Colors.black,
                  size: 25,
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "App Icon",
                        style: AppTextStyles.profileTextItems,
                      ),
                      Text(
                        "Explore",
                        style: AppTextStyles.profileTextItems,
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileSubHeading(title: "More"),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              context.push('/home/profile/settings/support');
            },
            child:
            ProfileItem(icon: Icons.support_agent_rounded, value: 'Guide and Support'),
          ),
          GestureDetector(
            onTap: () {
              context.push('/home/profile/settings/version');
            },
            child:
            ProfileItem(icon: Icons.info_rounded, value: 'Version and About'),
          ),
          GestureDetector(
            onTap: () {
              context.push('/home/profile/settings/update');
            },
            child:
            ProfileItem(icon: Icons.store_rounded, value: 'App Updates'),
          ),
          GestureDetector(
            onTap: () {},
            child:
            ProfileItem(icon: Icons.logout_rounded, value: 'Logout'),
          ),

        ],
      ),
    );
  }
}
