import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAYsPbYAOFRelOGZPywaX_OD_mPdsECAKA",
            authDomain: "swire-coca-cola.firebaseapp.com",
            projectId: "swire-coca-cola",
            storageBucket: "swire-coca-cola.firebasestorage.app",
            messagingSenderId: "504053208911",
            appId: "1:504053208911:web:6520c0b2fffdc0e3ded73a",
            measurementId: "G-5JNLK7N1EE"));
  } else {
    await Firebase.initializeApp();
  }
}
