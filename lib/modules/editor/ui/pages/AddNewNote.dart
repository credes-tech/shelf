import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({super.key});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {

  final QuillController _controller = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }




  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'New Note'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.large),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              cursorColor: AppColors.onboardLightYellow,
              cursorWidth: 3,
              cursorRadius: Radius.circular(20),
              decoration: InputDecoration(
                  labelText: "Note Title",
                  labelStyle: AppTextStyles.caption,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.onboardLightYellow, width: 2),
                  ),
              ),
              style: AppTextStyles.noteTitle,
              autofocus: true,
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  // QuillToolbar.simple(
                  //     controller: _controller,
                  //     configurations: const QuillSimpleToolbarConfigurations()),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: _controller,
                      configurations: const QuillEditorConfigurations(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
