import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:loginscreen/homePage.dart';

import 'package:loginscreen/register_screen.dart';

class logInScreen extends StatefulWidget {
  const logInScreen({super.key});

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  var userController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "log In",
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              WidgetUserText("User Name"),
              SizedBox(
                width: 300,
                height: 90,
                child: TextFormField(
                    controller: userController,
                    maxLength: 24,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "User Name",
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30))),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return "enter UserName";
                      } else {
                        return null;
                      }
                    }),
              ),
              WidgetUserText("Password"),
              SizedBox(
                  width: 300,
                  height: 90,
                  child: TextFormField(
                      controller: passwordController,
                      maxLength: 12,
                      obscureText: true,
                      obscuringCharacter: "#",
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30))),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      })),
              ElevatedButton(
                  onPressed: () {
                    firebaseAuth
                        .signInWithEmailAndPassword(
                            email: userController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false))
                        .onError((error, stackTrace) => null);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Text("SignUp"))
                ],
              )
            ],
          )),
    );
  }
}

WidgetUserText(String first) {
  return Center(
    child: Text(
      first,
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
  );
}
