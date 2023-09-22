import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowBottomSheet {
  File? file;

  uploadImage(context, ImageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource);
    file = File(xFile!.path);
    Navigator.of(context).pop();
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.shade400,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Choose Image",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  uploadImage(context, ImageSource.gallery);
                 // setState(() {});
                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Gallery",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () async {
                  await uploadImage(context, ImageSource.camera);
                // setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "From Camera",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
