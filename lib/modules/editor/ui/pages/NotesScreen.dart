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

  final TextEditingController _titleController = TextEditingController();
  late QuillController _controller = QuillController(
      document: _buildDocument("None\n"),
      selection: TextSelection.collapsed(offset: 0));

  @override
  void initState() {
    super.initState();
  }

  Document _buildDocument(String description) {
    final delta = Delta()
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
    final text = ref.read(textProvider.notifier).findNoteByIndex(widget.index);
    _controller = QuillController(
        document: _buildDocument(text.description),
        selection: TextSelection.collapsed(offset: 0));
    _titleController.text = text.heading;
    return PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          String updatedHeading = _titleController.text;
          String updatedDescription = _controller.document.toPlainText();
          if (updatedHeading.length == 0 && updatedDescription.length == 0) {
            ref.read(textProvider.notifier).deleteText(widget.index);
          } else {
            ref.read(textProvider.notifier).updateText(widget.index,
                updatedHeading, updatedDescription, text.isPinned);
          }
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
                      child: Column(
                        children: [
                          TextField(
                            controller: _titleController,
                            cursorColor: AppColors.onboardLightYellow,
                            cursorWidth: 3,
                            cursorRadius: Radius.circular(20),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.onboardLightYellow,
                                    width: 2),
                              ),
                            ),
                            autofocus: true,
                          ),
                          QuillEditor.basic(
                              controller: _controller,
                              configurations: const QuillEditorConfigurations(
                                autoFocus: true,
                              ))
                        ],
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
