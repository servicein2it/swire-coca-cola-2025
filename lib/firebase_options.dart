// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// ค่า configuration สำหรับแต่ละแพลตฟอร์ม
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

  // ค่า configuration สำหรับ web platform
  static const FirebaseOptions web = FirebaseOptions(
  apiKey: "AIzaSyAYsPbYAOFRelOGZPywaX_OD_mPdsECAKA",
  authDomain: "swire-coca-cola.firebaseapp.com",
  projectId: "swire-coca-cola",
  storageBucket: "swire-coca-cola.firebasestorage.app",
  messagingSenderId: "504053208911",
  appId: "1:504053208911:web:6520c0b2fffdc0e3ded73a",
  measurementId: "G-5JNLK7N1EE"
  );


}