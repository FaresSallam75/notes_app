import 'package:app_note_api/app/notes/add_notes.dart';
import 'package:app_note_api/app/notes/edit_notes.dart';
import 'package:app_note_api/app/auth/sign_in.dart';
import 'package:app_note_api/app/auth/sign_up.dart';
import 'package:app_note_api/app/auth/success.dart';
import 'package:app_note_api/app/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      initialRoute: sharedPref.getString("id") == null ? "signin" : "home",
      routes: {
        "signin": (context) => LogIn(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "addnotes": (context) => AddNotes(),
        "editnotes": (context) => EditNotes(),
      },
    );
  }
}
