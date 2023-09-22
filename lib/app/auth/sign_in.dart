import 'package:app_note_api/component/crud.dart';
import 'package:app_note_api/component/custom_text_form.dart';
import 'package:app_note_api/component/valid.dart';
import 'package:app_note_api/constant/link_api.dart';
import 'package:app_note_api/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLooding = false;
  Crud crud = Crud();

  logIn() async {
    if (formState.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isLooding = false;
      setState(() {});
      if (response['status'] == "success" ) {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString("password", response['data']['password']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            title: "Warn",
            body: Text(
              "Email Or Passwors was Wrong , Or Email dowsn't Exist ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            dialogType: DialogType.info)
          ..show();
      }
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: isLooding == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                  key: formState,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/logo2.png",
                          height: 170,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustTextform(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          myController: email,
                          hint: "Enter Your Email",
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        CustTextform(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          myController: password,
                          hint: "Enter Your Password",
                        ),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 15),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: ()  {
                             logIn();
                          },
                          child: Text("Login  "),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("signup");
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
