import 'package:app_note_api/component/bottem_sheet.dart';
import 'package:app_note_api/component/crud.dart';
import 'package:app_note_api/component/custom_text_form.dart';
import 'package:app_note_api/component/valid.dart';
import 'package:app_note_api/constant/link_api.dart';
import 'package:app_note_api/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLooding = false;
  //File? file;
  Crud crud = Crud();
  ShowBottomSheet showBottom = ShowBottomSheet();

  addNotes() async {
    if (showBottom.file == null)
      return AwesomeDialog(
          context: context,
          title: "Error",
          body: Text("Please Add Image"),
          dialogType: DialogType.info)
        ..show();
    if (formState.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      var response = await crud.postRequestWithFile(
          linkAddNote,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPref.getString("id"),
          },
          showBottom.file!);
      isLooding = false;
      setState(() {});

      if (response['status'] == "success") {
        // Navigator.of(context).pushReplacementNamed("home");
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Notes",
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
                      height: 13,
                    ),
                    MaterialButton(
                      color: showBottom.file == null
                          ? Colors.blue
                          : Colors.redAccent,
                      textColor: Colors.white,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () async {
                        await showBottom.showBottomSheet(context);
                        setState(() {});
                      },
                      child: Text(
                        "Please Choose Image",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 13,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () async {
                        await addNotes();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
