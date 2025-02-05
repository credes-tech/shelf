import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shelf/core/theme/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          // icon: SvgPicture.asset('assets/icon/back_icon.svg'),
          icon: Icon(Icons.arrow_circle_left),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/vector/filter.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text("hii"),
          ],
        ),
      ),
    );
  }
}
