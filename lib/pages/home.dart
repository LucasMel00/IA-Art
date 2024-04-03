// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 220,
                  padding: EdgeInsets.only(left: 20, top: 50),
                  decoration: BoxDecoration(
                    color: Color(0xFF2a2b31),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          "https://raw.githubusercontent.com/LucasMel00/IA_Art_aoo/main/images/lucas.jpeg",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Lucas Melo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: Image.network(
                              "https://raw.githubusercontent.com/LucasMel00/IA_Art_aoo/main/images/4.JPG",
                              width: 150,
                              height: 200,
                              fit: BoxFit.cover)),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Play &\nWin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Feito por Lucas Melo",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 123, 115, 115),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Categorias",
                style: TextStyle(
                  color: const Color.fromARGB(255, 29, 29, 29),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF2a2b31),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 20,
                            offset: Offset(5, 10),
                            spreadRadius: 0.1,
                            blurStyle: BlurStyle.normal),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.art_track,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          "IA Art",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
