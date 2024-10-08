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
    apiKey: 'AIzaSyDesOUOzJDlsLSH2S8QY2KXvggO0xnD8jI',
    appId: '1:50109702108:web:2d916c3d48add30c8cf919',
    messagingSenderId: '50109702108',
    projectId: 'exchange-book-b33bc',
    authDomain: 'exchange-book-b33bc.firebaseapp.com',
    databaseURL: 'https://exchange-book-b33bc-default-rtdb.firebaseio.com',
    storageBucket: 'exchange-book-b33bc.appspot.com',
    measurementId: 'G-7MNB5TM3TT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHX6rUkTlcB0cnWV2mrno-rd7geMbEvH4',
    appId: '1:50109702108:android:ae754d1adb2d52e88cf919',
    messagingSenderId: '50109702108',
    projectId: 'exchange-book-b33bc',
    databaseURL: 'https://exchange-book-b33bc-default-rtdb.firebaseio.com',
    storageBucket: 'exchange-book-b33bc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALiiISMGpJJfc7nATaCnOqlehXa_0nJUo',
    appId: '1:50109702108:ios:e3152cd89efd328b8cf919',
    messagingSenderId: '50109702108',
    projectId: 'exchange-book-b33bc',
    databaseURL: 'https://exchange-book-b33bc-default-rtdb.firebaseio.com',
    storageBucket: 'exchange-book-b33bc.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALiiISMGpJJfc7nATaCnOqlehXa_0nJUo',
    appId: '1:50109702108:ios:7dd5913310cc7f308cf919',
    messagingSenderId: '50109702108',
    projectId: 'exchange-book-b33bc',
    databaseURL: 'https://exchange-book-b33bc-default-rtdb.firebaseio.com',
    storageBucket: 'exchange-book-b33bc.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
