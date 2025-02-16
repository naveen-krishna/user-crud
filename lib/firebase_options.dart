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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCHkn7mlrD9QQQp1y7-oXDqxsQdsuDgm4c',
    appId: '1:160002790040:web:181de022bb65609cb2b6ed',
    messagingSenderId: '160002790040',
    projectId: 'user-crud-465e9',
    authDomain: 'user-crud-465e9.firebaseapp.com',
    storageBucket: 'user-crud-465e9.firebasestorage.app',
    measurementId: 'G-4JBX24MRCW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGBhuharm1KAJmf3-y2lo5pHShxcBODIo',
    appId: '1:160002790040:android:bebd5ebff9f0c38db2b6ed',
    messagingSenderId: '160002790040',
    projectId: 'user-crud-465e9',
    storageBucket: 'user-crud-465e9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUwj8yPvq7NEKAg9mzv_H0btG2ZjINZGY',
    appId: '1:160002790040:ios:3c0dcc8ab64ae27cb2b6ed',
    messagingSenderId: '160002790040',
    projectId: 'user-crud-465e9',
    storageBucket: 'user-crud-465e9.firebasestorage.app',
    iosBundleId: 'com.example.productListing',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHkn7mlrD9QQQp1y7-oXDqxsQdsuDgm4c',
    appId: '1:160002790040:web:9be25cdc0e67ac50b2b6ed',
    messagingSenderId: '160002790040',
    projectId: 'user-crud-465e9',
    authDomain: 'user-crud-465e9.firebaseapp.com',
    storageBucket: 'user-crud-465e9.firebasestorage.app',
    measurementId: 'G-757PYQ4RP8',
  );
}
