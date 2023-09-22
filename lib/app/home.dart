import 'package:app_note_api/app/notes/edit_notes.dart';
import 'package:app_note_api/component/card_note.dart';
import 'package:app_note_api/component/crud.dart';
import 'package:app_note_api/constant/link_api.dart';
import 'package:app_note_api/main.dart';
import 'package:app_note_api/model/note_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response = await postRequest(
      linkViewNote,
      {
        "id": sharedPref.getString("id"),
      },
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("signin", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == "fail") {
                    return Center(
                      child: Text(
                        "No Notes For This User",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) async {
                          var response = await postRequest(linkDeleteNote, {
                            "id": snapshot.data['data'][index]['notes_id']
                                .toString(),
                            "imagename": snapshot.data['data'][index]
                                    ['note_image']
                                .toString()
                          });
                          if (response['status'] == "success") {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "home", (route) => false);
                          } else {
                            print("ERROR");
                          }
                        },
                        key: UniqueKey(),
                        child: CardNote(
                          ontab: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => EditNotes(
                                      notes: snapshot.data['data'][index],
                                    )),
                              ),
                            );
                          },
                          noteModel:
                              NoteModel.fromJson(snapshot.data['data'][index]),
                        ),
                      );
                    },
                  );
                }

                ///////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////
                ///
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Looding ..."),
                  );
                }
                return Center(
                  child: Text("Looding ..."),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
