// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA_DoKhiyXZInOc5seXrGvtPARsCKTixyk',
    appId: '1:692051065249:web:9d32028ba24f3d5b7473e0',
    messagingSenderId: '692051065249',
    projectId: 'my-todo-app-6ff52',
    authDomain: 'my-todo-app-6ff52.firebaseapp.com',
    storageBucket: 'my-todo-app-6ff52.appspot.com',
    measurementId: 'G-M9HD1W8ZXR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuQLbXX_t2IoLgK6mCnpDxZ3by0ZV_M1I',
    appId: '1:692051065249:android:542ee671f1134bfe7473e0',
    messagingSenderId: '692051065249',
    projectId: 'my-todo-app-6ff52',
    storageBucket: 'my-todo-app-6ff52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZ82lzwZ_HBW-yWs9aPB6ibY_XGSNA45Y',
    appId: '1:692051065249:ios:7bfbf3c5bcf1e0847473e0',
    messagingSenderId: '692051065249',
    projectId: 'my-todo-app-6ff52',
    storageBucket: 'my-todo-app-6ff52.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZ82lzwZ_HBW-yWs9aPB6ibY_XGSNA45Y',
    appId: '1:692051065249:ios:7bfbf3c5bcf1e0847473e0',
    messagingSenderId: '692051065249',
    projectId: 'my-todo-app-6ff52',
    storageBucket: 'my-todo-app-6ff52.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA_DoKhiyXZInOc5seXrGvtPARsCKTixyk',
    appId: '1:692051065249:web:38111151698433577473e0',
    messagingSenderId: '692051065249',
    projectId: 'my-todo-app-6ff52',
    authDomain: 'my-todo-app-6ff52.firebaseapp.com',
    storageBucket: 'my-todo-app-6ff52.appspot.com',
    measurementId: 'G-5P920TWMT8',
  );

}