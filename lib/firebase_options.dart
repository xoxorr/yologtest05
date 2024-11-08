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
    apiKey: 'AIzaSyDnMC94-5mJW3El3xR6DnvU4KFLgWWUYLQ',
    appId: '1:835401542975:web:53442de3e72ac19f79778a',
    messagingSenderId: '835401542975',
    projectId: 'yolog-test05',
    authDomain: 'yolog-test05.firebaseapp.com',
    storageBucket: 'yolog-test05.firebasestorage.app',
    measurementId: 'G-HL38VLV0XS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAIh1q121e_NsUISEj_GcHeN5L8FWx9kQ',
    appId: '1:835401542975:android:8d7d04a41a76d42779778a',
    messagingSenderId: '835401542975',
    projectId: 'yolog-test05',
    storageBucket: 'yolog-test05.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBIjSkTVsGPVmXs1O0YZXOwk9Xe0dGVSk',
    appId: '1:835401542975:ios:7d9b280d2f57d67079778a',
    messagingSenderId: '835401542975',
    projectId: 'yolog-test05',
    storageBucket: 'yolog-test05.firebasestorage.app',
    iosBundleId: 'com.example.yologtest05',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBIjSkTVsGPVmXs1O0YZXOwk9Xe0dGVSk',
    appId: '1:835401542975:ios:7d9b280d2f57d67079778a',
    messagingSenderId: '835401542975',
    projectId: 'yolog-test05',
    storageBucket: 'yolog-test05.firebasestorage.app',
    iosBundleId: 'com.example.yologtest05',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDnMC94-5mJW3El3xR6DnvU4KFLgWWUYLQ',
    appId: '1:835401542975:web:d6d6bfe26a28ad0b79778a',
    messagingSenderId: '835401542975',
    projectId: 'yolog-test05',
    authDomain: 'yolog-test05.firebaseapp.com',
    storageBucket: 'yolog-test05.firebasestorage.app',
    measurementId: 'G-P2VRWJE3QN',
  );
}
