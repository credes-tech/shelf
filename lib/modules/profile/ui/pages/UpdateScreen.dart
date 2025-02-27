

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/MoreItem.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileSubHeading.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileTitle.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
            Icons.store_rounded,
            color: Colors.black,
          ),
        ),
        title: ProfileTitle(title: 'App Updates'),
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
            child: MoreItem(value: 'No Updates Available'),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileSubHeading(title: "Current Version"),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: '11.0.0'),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileSubHeading(title: "Previous Version"),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: '10.0.0'),
          ),

        ],
      ),
    );
  }
}
