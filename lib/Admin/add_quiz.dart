import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

final ImagePicker _picker = ImagePicker();
File? selectedImage;

Future getImage() async {
  var image = await _picker.pickImage(source: ImageSource.gallery);

  selectedImage = File(image!.path);
}

class _AddQuizState extends State<AddQuiz> {
  TextEditingController falseAnswerController = TextEditingController();
  TextEditingController trueAnswerController = TextEditingController();

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
      body: Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          children: [
            Column(
              children: [
                // Placeholder for photo upload
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('Upload Photo'),
                  ),
                ),
                // Placeholder for text input 1
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Resposta Falsa',
                  ),
                ),
                // Placeholder for text input 2
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Resposta Verdadeira',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
