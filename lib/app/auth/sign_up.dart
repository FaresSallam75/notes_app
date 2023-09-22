import 'package:app_note_api/component/crud.dart';
import 'package:app_note_api/component/custom_text_form.dart';
import 'package:app_note_api/component/valid.dart';
import 'package:app_note_api/constant/link_api.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Crud crud = Crud();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  bool isLooding = false;

  signUp() async {
    if (formState.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      var response = await crud.postRequest(linkSignup, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLooding = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("success");
      } else {
        print("SignUp Failed ");
      }
    } else {
      print("Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: isLooding == true
          ? Center(child: CircularProgressIndicator())
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
                          myController: username,
                          hint: "Enter Your Username",
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        CustTextform(
                          valid: (val) {
                            return validInput(val!, 5, 40);
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
                          onPressed: () async {
                            await signUp();
                          },
                          child: Text("SignUp"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Text(
                            "Login ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("signin");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
