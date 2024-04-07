// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ia_art/service/database.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  TextEditingController Answer1Controller = TextEditingController();
  TextEditingController Answer2Controller = TextEditingController();
  TextEditingController TrueAnswerController = TextEditingController();
  String? value;
  final List<String> quizitems = [
    'Quiz IA ART',
    'Quiz Art History',
  ];

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);

    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null &&
        TrueAnswerController.text.isNotEmpty &&
        Answer1Controller.text.isNotEmpty &&
        Answer2Controller.text.isNotEmpty) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("quizImages")
          .child("$addId.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> AddQuiz = {
        "quizId": addId,
        "Image": downloadUrl,
        "quizAnswer1": Answer1Controller.text.trim(),
        "quizAnswer2": Answer2Controller.text.trim(),
        "quizAnswerTrue": TrueAnswerController.text.trim()
      };

      await DatabaseMethods()
          .addQuizCategory(AddQuiz, value!)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Quiz Added Successfully"),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Quiz",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            height: 150,
                            width: 150,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 240, 240),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Color.fromARGB(255, 203, 197, 238),
                              ),
                            ),
                          ),
                  ),
                  // Placeholder for text input 1
                  TextField(
                    controller: Answer1Controller, // Add this line
                    decoration: InputDecoration(
                      labelText: 'Resposta 1',
                    ),
                  ),
                  // Placeholder for text input 2
                  TextField(
                    controller: Answer2Controller, // Add this line
                    decoration: InputDecoration(
                      labelText: 'Resposta 2',
                    ),
                  ),
                  TextField(
                    controller: TrueAnswerController, // Add this line
                    decoration: InputDecoration(
                      labelText: 'Resposta Verdadeira',
                    ),
                  ),
                  // Placeholder for dropdown
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        items: quizitems
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                        dropdownColor: Color.fromARGB(255, 240, 240, 240),
                        hint: Text("Select Quiz"),
                        iconSize: 20,
                        value: value,
                      ))),

                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadItem();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 203, 197, 238),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} // Add this line
