import 'package:app_note_api/constant/link_api.dart';
import 'package:app_note_api/model/note_model.dart';
import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final void Function()? ontab;
  final NoteModel noteModel;

  const CardNote({
    super.key,
    required this.ontab,
    required this.noteModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImageRoot/${noteModel.noteImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${noteModel.notesTitle}"),
                subtitle: Text("${noteModel.noteContent}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
