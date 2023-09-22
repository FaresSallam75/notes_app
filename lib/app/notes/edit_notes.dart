import 'package:app_note_api/component/bottem_sheet.dart';
import 'package:app_note_api/component/crud.dart';
import 'package:app_note_api/component/custom_text_form.dart';
import 'package:app_note_api/component/valid.dart';
import 'package:app_note_api/constant/link_api.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLooding = false;
  //File? file;
  var response;
  Crud crud = Crud();
  ShowBottomSheet bottomSheet = ShowBottomSheet();

  editNotes() async {
    if (formState.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      if (bottomSheet.file == null) {
        response = await crud.postRequest(
          linkEditNote,
          {
            "title": title.text,
            "content": content.text,
            "id": widget.notes['notes_id'].toString(),
            "imagename": widget.notes['note_image'].toString(),
          },
        );
      } else {
        response = await crud.postRequestWithFile(
            linkEditNote,
            {
              "title": title.text,
              "content": content.text,
              "imagename": widget.notes['note_image'].toString(),
              "id": widget.notes['notes_id'].toString(),
            },
            bottomSheet.file!);
      }
      isLooding = false;
      setState(() {});

      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      }
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['note_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Notes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLooding == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formState,
                child: ListView(
                  children: [
                    CustTextform(
                        hint: "Enter Title",
                        myController: title,
                        valid: (val) {
                          return validInput(val!, 3, 50);
                        }),
                    CustTextform(
                        hint: "Enter Content",
                        myController: content,
                        valid: (val) {
                          return validInput(val!, 5, 200);
                        }),
                    Container(
                      height: 5,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () async {
                        await bottomSheet.showBottomSheet(context);
                        setState(() {});
                      },
                      child: Text(
                        "Choose Image",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () async {
                        await editNotes();
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
