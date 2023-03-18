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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBVsbrQlGTSF0EMbgSEZetWliJ9EGsAIjs',
    appId: '1:619484753745:web:1a18101e73221b112b2d70',
    messagingSenderId: '619484753745',
    projectId: 'mydevice-84f74',
    authDomain: 'mydevice-84f74.firebaseapp.com',
    storageBucket: 'mydevice-84f74.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnGcGsem6y9CtXhAUYjO_SaOVmAeRxYsI',
    appId: '1:619484753745:android:4e7286cecba164da2b2d70',
    messagingSenderId: '619484753745',
    projectId: 'mydevice-84f74',
    storageBucket: 'mydevice-84f74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDbcNBCMVXB4HMNbbNTHnwELeHSJ2ZdFg',
    appId: '1:619484753745:ios:91b6c8eea656e4fb2b2d70',
    messagingSenderId: '619484753745',
    projectId: 'mydevice-84f74',
    storageBucket: 'mydevice-84f74.appspot.com',
    iosClientId: '619484753745-0fp88hgeeeln3hv2mqs19itsd3nc60oo.apps.googleusercontent.com',
    iosBundleId: 'com.example.myDevice',
  );
}
