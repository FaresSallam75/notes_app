import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustTextform extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController? myController;
  const CustTextform(
      {super.key,
      required this.hint,
      required this.myController,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: valid,
        controller: myController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(color: Colors.redAccent, width: 3),
            )),
      ),
    );
  }
}
