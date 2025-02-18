// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';

class NotesScreen extends ConsumerStatefulWidget {
  final String heading;
  final String description;
  const NotesScreen({
    super.key,
    required this.heading,
    required this.description,
  });

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  String heading = "None";
  String description = "None";
  late QuillController _controller;

  @override
  void initState() {
    heading = widget.heading;
    description = widget.description;
    _controller = QuillController(
        document: _buildDocument(heading, description),
        selection: TextSelection.collapsed(offset: 0));
    super.initState();
  }

  Document _buildDocument(String heading, String description) {
    final delta = Delta()
      ..insert(heading, {'header': 2})
      ..insert('\n\n')
      ..insert(description)
      ..insert('\n');
    return Document.fromDelta(delta);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Texts'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: QuillEditor.basic(
                    controller: _controller,
                    configurations: const QuillEditorConfigurations(
                      autoFocus: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
