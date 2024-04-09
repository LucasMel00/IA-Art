import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ia_art/pages/home.dart';
import 'package:ia_art/service/database.dart';

class Question extends StatefulWidget {
  String category;
  Question({required this.category});
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool show = false;
  int score = 0; // Variável para rastrear a pontuação

  getOnTheLoad() async {
    QuizStream = await DatabaseMethods().getCategoryQuiz(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Stream? QuizStream;
  PageController controller = PageController();
  int currentPageIndex = 0;

  Widget allQuiz() {
    return StreamBuilder(
        stream: QuizStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
                  controller: controller,
                  itemCount: snapshot.data.size,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 234, 238),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 40,
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: MediaQuery.of(context).size.height *
                                      0.4, // Ajuste a altura conforme necessário
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit
                                      .cover, // Ajuste para cobrir toda a área
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  show = true;
                                  if (ds["quizAnswerTrue"] ==
                                      ds["quizAnswer1"]) {
                                    setState(() {
                                      score++;
                                    });
                                  }
                                  setState(() {});
                                  Future.delayed(Duration(milliseconds: 1000),
                                      () {
                                    if (currentPageIndex ==
                                        snapshot.data.size - 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FinalScreen(score: score),
                                        ),
                                      );
                                    } else {
                                      controller.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                      setState(() {
                                        show = false;
                                      });
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: show &&
                                              ds["quizAnswerTrue"] ==
                                                  ds["quizAnswer1"]
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 96, 96, 96),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    ds["quizAnswer1"],
                                    style: TextStyle(
                                      color: show &&
                                              ds["quizAnswerTrue"] ==
                                                  ds["quizAnswer1"]
                                          ? Colors.black
                                          : const Color.fromARGB(
                                              255, 85, 85, 85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                onTap: () {
                                  show = true;
                                  if (ds["quizAnswerTrue"] ==
                                      ds["quizAnswer2"]) {
                                    setState(() {
                                      score++;
                                    });
                                  }
                                  setState(() {});
                                  Future.delayed(Duration(milliseconds: 1000),
                                      () {
                                    if (currentPageIndex ==
                                        snapshot.data.size - 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FinalScreen(score: score),
                                        ),
                                      );
                                    } else {
                                      controller.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                      setState(() {
                                        show = false;
                                      });
                                    }
                                  });
                                },
                                child: show
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ds["quizAnswerTrue"] ==
                                                      ds["quizAnswer2"]
                                                  ? Colors.green
                                                  : Colors.red,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(ds["quizAnswer2"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 96, 96, 96),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(ds["quizAnswer2"],
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 85, 85, 85),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 95, 102, 141),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40))),
                        child: Center(
                            child: Icon(Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ),
                  SizedBox(width: 100),
                  Text(widget.category,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Expanded(child: allQuiz()),
            ],
          ),
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  final int score;

  const FinalScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado do Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parabéns, você concluiu o quiz!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sua pontuação final foi de: $score acertos',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}
