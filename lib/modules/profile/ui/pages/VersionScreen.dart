

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/MoreItem.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileTitle.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({super.key});

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
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
            Icons.info_rounded,
            color: Colors.black,
          ),
        ),
        title: ProfileTitle(title: 'Version and About'),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'App Version : 1.0.0'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Last Session : 11 minute ago'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Privacy and Policy'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Terms of Service'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Open Source Licenses'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Permissions'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Delete Account'),
          ),
        ],
      ),
    );
  }
}
