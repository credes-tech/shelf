import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/modules/home/domain/models/text_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/text_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';

class NotesScreen extends ConsumerStatefulWidget {
  final int index;
  const NotesScreen({
    super.key,
    required this.index,
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
    super.initState();
    getText();
  }

  void getText() async {
    TextModel text =
        await ref.read(textProvider.notifier).findNoteByIndex(widget.index);
    setState(() {
      heading = text.heading;
      description = text.description;
      _controller = QuillController(
          document: _buildDocument(heading, description),
          selection: TextSelection.collapsed(offset: 0));
    });
  }

  Document _buildDocument(String heading, String description) {
    final delta = Delta()
      ..insert(heading, {'header': 2})
      ..insert(description);
    return Document.fromDelta(delta);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          // print(
          //     " controller *************************************** ${_controller.document}");
          String updatedHeading = _controller.document
              .toPlainText()
              .split('\n')[0]; // Assuming first line is heading
          print(updatedHeading);
          String updatedDescription = _controller.document
              .toPlainText()
              .substring(updatedHeading.length); // Rest as description
          print(updatedDescription);

          // Update the text in the provider (save it in the state)
          ref
              .read(textProvider.notifier)
              .updateText(widget.index, updatedHeading, updatedDescription);

          // Allow the pop action (navigate back)
        },
        child: Scaffold(
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
        ));
  }
}
