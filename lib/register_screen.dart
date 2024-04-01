import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userController = TextEditingController();

  var passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();

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
                        .createUserWithEmailAndPassword(
                            email: userController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) => Navigator.pop(context))
                        .onError((error, stackTrace) =>
                            Fluttertoast.showToast(msg: error.toString()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
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
