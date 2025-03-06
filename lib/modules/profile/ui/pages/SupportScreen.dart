

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/MoreItem.dart';
import 'package:my_shelf_project/modules/profile/ui/widgets/ProfileTitle.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
              Icons.support_agent_rounded,
              color: Colors.black,
          ),
        ),
        title: ProfileTitle(title: 'Guide and Support'),
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
            child: MoreItem(value: 'Getting started guide'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Help Center'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Contact Developers'),
          ),
          GestureDetector(
            onTap: (){},
            child: MoreItem(value: 'Buy me a Burger'),
          ),
        ],
      ),
    );
  }
}
