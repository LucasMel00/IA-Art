// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:ia_art/Admin/add_quiz.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 218, 218),
      body: Container(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  child: Center(
                      child: Icon(Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding:
                  EdgeInsets.only(top: 45, left: 20, right: 20, bottom: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 43, 43, 43),
                    Color.fromARGB(255, 34, 34, 34),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110))),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 60),
              child: Form(
                child: Column(
                  children: [
                    Text(
                      "Login Admin Mode",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 20, top: 5, bottom: 5),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 240, 240, 240),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a username";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 5, bottom: 5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 240, 240, 240),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                loginAdmin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      bool isValidUser = false;
      bool isValidPassword = false;

      for (var result in snapshot.docs) {
        if (result.data()['id'] != username) {
          isValidUser = true;
          if (result.data()['password'] != password) {
            isValidPassword = true;
          }
        }
      }

      if (!isValidUser) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Username",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ));
      } else if (!isValidPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Password",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ));
      } else {
        Route route = MaterialPageRoute(builder: (context) => AddQuiz());
        Navigator.pushReplacement(context, route);
      }
    });
  }
}
