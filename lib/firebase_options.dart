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
    apiKey: 'AIzaSyC_xVBLSjreIMoVtgn36p2HU8OL0w0_gzs',
    appId: '1:299158450075:web:a2a23c3b24a02dc030fb3e',
    messagingSenderId: '299158450075',
    projectId: 'mental-health-tracker-19632',
    authDomain: 'mental-health-tracker-19632.firebaseapp.com',
    storageBucket: 'mental-health-tracker-19632.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBM6tyXsJUUmDXx8DFaEzKFiPk6vUrcOJU',
    appId: '1:299158450075:android:e83370c7b720846630fb3e',
    messagingSenderId: '299158450075',
    projectId: 'mental-health-tracker-19632',
    storageBucket: 'mental-health-tracker-19632.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFwvNHH7qhzDywvDX_qqN0JRhGTH8_WrU',
    appId: '1:299158450075:ios:13ad1a80feb4de1e30fb3e',
    messagingSenderId: '299158450075',
    projectId: 'mental-health-tracker-19632',
    storageBucket: 'mental-health-tracker-19632.appspot.com',
    androidClientId: '299158450075-u7p53vo5a9t8p9potaise3e8u0fcsplk.apps.googleusercontent.com',
    iosClientId: '299158450075-qhpq2g3i6m78o27nr9uvog4taokss0dr.apps.googleusercontent.com',
    iosBundleId: 'com.example.mentalHealthTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFwvNHH7qhzDywvDX_qqN0JRhGTH8_WrU',
    appId: '1:299158450075:ios:96d898f65234449930fb3e',
    messagingSenderId: '299158450075',
    projectId: 'mental-health-tracker-19632',
    storageBucket: 'mental-health-tracker-19632.appspot.com',
    androidClientId: '299158450075-u7p53vo5a9t8p9potaise3e8u0fcsplk.apps.googleusercontent.com',
    iosClientId: '299158450075-rce342j935so8de7tpjm26vd5ps07rms.apps.googleusercontent.com',
    iosBundleId: 'com.example.mentalHealthTracker.RunnerTests',
  );
}
