import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loginscreen/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:loginscreen/notes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textcontroller = TextEditingController();
  var passswordcontroller = TextEditingController();
  var simpleDateFormat = DateFormat("dd/MMM/yyyy");
  String selectedDate = DateTime.now.toString();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var list = <NotesModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  getValues() {
    _firebaseFirestore.collection("notes").get().then((value) {
      print("value $value");
      list.clear();
      for (int i = 0; i < value.docs.length; i++) {
        var note = value.docs[i].data() as Map<String, dynamic>;
        var notesModel = NotesModel.fromJson(note);
        notesModel.id = value.docs[i].id;
        list.add(notesModel);
        setState(() {});
        print("note ${notesModel.toJson()}");
      }
    });
  }

  void _showDialogFunction() {
    selectedDate = simpleDateFormat.format(DateTime.now());
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Notes"),
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                  ),
                  TextFormField(
                    controller: descriptionController,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var returnValue = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025));
                      print("returnValue $returnValue");
                      selectedDate = simpleDateFormat
                          .format(returnValue ?? DateTime.now());
                    },
                    child: Text("pick date $selectedDate"),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    //   if (formKey.currentState?.validate() == true) {
                    var notes = NotesModel(
                        title: titleController.text.toString(),
                        description: descriptionController.text.toString());
                    _firebaseFirestore
                        .collection("notes")
                        .add(notes.toJson())
                        .then((value) {
                      Navigator.of(context).pop();

                      getValues();
                    }).onError((error, stackTrace) {
                      print("error $error");
                    });
                    //  }
                  },
                  child: Text("Add Notes"))
            ],
          );
        });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(" logout"), centerTitle: true, actions: [
          ElevatedButton(
              onPressed: () {
                firebaseAuth.signOut().then((value) => Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => logInScreen()),
                        (route) => false));
              },
              child: Text("Logout")),
        ]),
        body: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    print("list[index].id ${list[index].id}");
                    _firebaseFirestore
                        .collection("notes")
                        .doc(list[index].id ?? "")
                        .delete()
                        .then((value) => getValues());
                  },
                  onDoubleTap: () {
                    var titleController = TextEditingController();
                    var descriptionController = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("update notes"),
                            content: Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                  ),
                                  TextFormField(
                                    controller: descriptionController,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    var notes = NotesModel(
                                        title: titleController.text.toString(),
                                        description: descriptionController.text
                                            .toString());
                                    _firebaseFirestore
                                        .collection("notes")
                                        .doc(list[index].id)
                                        .set(notes.toJson())
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      getValues();
                                    }).onError((error, stackTrace) {
                                      print("showerror $error");
                                    });
                                  },
                                  child: Text("update notes"))
                            ],
                          );
                        });
                  },
                  child: Text("${list[index].title ?? ""}"));
            }),
        floatingActionButton: FloatingActionButton(onPressed: () {
          _showDialogFunction();
        }));
  }
}
