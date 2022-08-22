import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';


import 'global.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final GlobalKey<FormState> companyDetails = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Global.name != null) {
      nameController.text = Global.name.toString();
      gstController.text = Global.gst.toString();
      emailController.text = Global.email.toString();
      numberController.text = Global.number.toString();
    }
  }

  final ImagePicker _picker = ImagePicker();

  dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              if (companyDetails.currentState!.validate()) {
                companyDetails.currentState!.save();

                if (image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text(
                        "Select image First...",
                      ),
                      action: SnackBarAction(
                        onPressed: () {
                          addImage();
                        },
                        label: "ADD",
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    Global.image = image;
                  });
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: (image != null) ? FileImage(image!) : null,
                    child: (image != null)
                        ? const Text("")
                        : const Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addImage();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: companyDetails,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Company Name...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.name = val;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Company Name",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "GST No...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.gst = val;
                        },
                        controller: gstController,
                        decoration: const InputDecoration(
                          hintText: "GST Number",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Phone Number...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.number = val;
                        },
                        keyboardType: TextInputType.phone,
                        controller: numberController,
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Company Email...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          Global.email = val;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addImage() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "When You go to pick Image ?",
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              XFile? pickerFile =
              await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                image = File(pickerFile!.path);
                Navigator.of(context).pop();
              });
            },
            child: const Text("gallery"),
          ),
          OutlinedButton(
            onPressed: () async {
              XFile? pickerFile =
              await _picker.pickImage(source: ImageSource.camera);
              setState(() {
                image = File(pickerFile!.path);
                Navigator.of(context).pop();
              });
            },
            child: const Text("Camera"),
          ),
        ],
      ),
    );
  }
}
