import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        return android;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8Tcea7CVHzjM8eiqWnXGNHxp-EzxNWAk',
    appId: '1:892495297652:android:73165e5bdec855535f2521',
    messagingSenderId: '892495297652',
    projectId: 'alisveris-b63ad',
    storageBucket: 'alisveris-b63ad.appspot.com',
  );
}