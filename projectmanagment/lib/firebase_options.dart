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
    apiKey: 'AIzaSyA48lP2Gez3YQJdQAV0dqRAfgd6HUZt6r8',
    appId: '1:1098765453963:web:c365f8a8ee01c4c6e1e28e',
    messagingSenderId: '1098765453963',
    projectId: 'cik-grad-proj',
    authDomain: 'cik-grad-proj.firebaseapp.com',
    storageBucket: 'cik-grad-proj.appspot.com',
    measurementId: 'G-PXTDS0HHLB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU79YsmL_OfUcs4Rji5NL8G03SLdPwMP0',
    appId: '1:1098765453963:android:1d19e3d6d76212dee1e28e',
    messagingSenderId: '1098765453963',
    projectId: 'cik-grad-proj',
    storageBucket: 'cik-grad-proj.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3agUtRs1sbfvY24uJDRQdnoV3rVS48hk',
    appId: '1:1098765453963:ios:2e7b57964a5dd95de1e28e',
    messagingSenderId: '1098765453963',
    projectId: 'cik-grad-proj',
    storageBucket: 'cik-grad-proj.appspot.com',
    iosBundleId: 'com.example.projectmanagment',
  );
}
