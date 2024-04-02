import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' as io;

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? xfile = null;

  void pickImage() async {
    print("image pick");
    xfile = await picker.pickImage(source: ImageSource.gallery);
    print("xfile $xfile");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload image")),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  final androidInfo = await DeviceInfoPlugin().androidInfo;
                  if (androidInfo.version.sdkInt <= 32) {
                    /// use [Permissions.storage.status]
                    await Permission.storage.onDeniedCallback(() {
                      // Your code
                    }).onGrantedCallback(() {
                      pickImage();
                    }).onPermanentlyDeniedCallback(() {
                      // Your code
                      openAppSettings();
                    }).onRestrictedCallback(() {
                      // Your code
                    }).onLimitedCallback(() {
                      // Your code
                    }).onProvisionalCallback(() {
                      // Your code
                    }).request();
                  } else {
                    /// use [Permissions.photos.status]
                    await Permission.photos.onDeniedCallback(() {
                      // Your code
                    }).onGrantedCallback(() {
                      pickImage();
                    }).onPermanentlyDeniedCallback(() {
                      // Your code
                      openAppSettings();
                    }).onRestrictedCallback(() {
                      // Your code
                    }).onLimitedCallback(() {
                      // Your code
                    }).onProvisionalCallback(() {
                      // Your code
                    }).request();
                  }
                }
              },
              child: Text("select image")),
          xfile != null
              ? Image.file(File(xfile?.path ?? ""))
              : CachedNetworkImage(
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/first-project-cd333.appspot.com/o/insta%20(2).png?alt=media&token=e9490703-1ee7-4214-97ed-40f98ee9968d",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),

          // Image.network(
          //     width: 200,
          //     height: 200,
          // "https://firebasestorage.googleapis.com/v0/b/first-project-cd333.appspot.com/o/insta%20(2).png?alt=media&token=e9490703-1ee7-4214-97ed-40f98ee9968d"),
          ElevatedButton(
              onPressed: () async {
                File file = File(xfile?.path ?? "");
                Reference ref = FirebaseStorage.instance
                    .ref()
                    .child('flutter-tests')
                    .child('/some-image.jpg');
                final MetaData = SettableMetadata(
                  contentType: 'image/jpg',
                  customMetadata: {'picked-file-path': xfile?.path ?? ""},
                );
                UploadTask uploadTask;
                if (kIsWeb) {
                  uploadTask = ref.putData(await file.readAsBytes(), MetaData);
                  uploadTask.then((p0) => print("p0 $p0"));
                } else {
                  uploadTask = ref.putFile(io.File(file.path), MetaData);
                  print("ref.getDownLoadURL(); ${await ref.getDownloadURL()}");
                  uploadTask.then(((p0) => null));
                }
              },
              child: Text("upload Image"))
        ],
      ),
    );
  }
}
