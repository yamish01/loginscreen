// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCovp38s_VOjmb4dSb5V-vAfDOi4QkoV8A',
    appId: '1:951632483081:web:e0603e68debd21d6dff9d8',
    messagingSenderId: '951632483081',
    projectId: 'fir-crud-9dae7',
    authDomain: 'fir-crud-9dae7.firebaseapp.com',
    storageBucket: 'fir-crud-9dae7.appspot.com',
    measurementId: 'G-R9QZ4YJ0GD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBSuBmswXhNqiJ0fNnrPuM55amsFJ4HaA',
    appId: '1:951632483081:android:1ed0e7e4c2793a58dff9d8',
    messagingSenderId: '951632483081',
    projectId: 'fir-crud-9dae7',
    storageBucket: 'fir-crud-9dae7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA51S2OHjzZcljMn8prvZwFM2eTDkkEILI',
    appId: '1:951632483081:ios:08c37d9fc2dfa79adff9d8',
    messagingSenderId: '951632483081',
    projectId: 'fir-crud-9dae7',
    storageBucket: 'fir-crud-9dae7.appspot.com',
    iosBundleId: 'com.example.loginscreen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA51S2OHjzZcljMn8prvZwFM2eTDkkEILI',
    appId: '1:951632483081:ios:9a002d626d3db5d0dff9d8',
    messagingSenderId: '951632483081',
    projectId: 'fir-crud-9dae7',
    storageBucket: 'fir-crud-9dae7.appspot.com',
    iosBundleId: 'com.example.loginscreen.RunnerTests',
  );
}
