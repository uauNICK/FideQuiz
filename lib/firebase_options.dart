// File generated for fidequiz-c4410 with official Firebase credentials
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA2bTtcXxkHXZBdiVXt2nBKat6ZndrbX8o',
    appId: '1:91899540530:web:fcb435abfdbaeb12ebf82b',
    messagingSenderId: '91899540530',
    projectId: 'fidequiz-c4410',
    authDomain: 'fidequiz-c4410.firebaseapp.com',
    storageBucket: 'fidequiz-c4410.firebasestorage.app',
    measurementId: 'G-02ES776NEL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2bTtcXxkHXZBdiVXt2nBKat6ZndrbX8o',
    appId: '1:91899540530:android:fcb435abfdbaeb12ebf82b',
    messagingSenderId: '91899540530',
    projectId: 'fidequiz-c4410',
    storageBucket: 'fidequiz-c4410.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2bTtcXxkHXZBdiVXt2nBKat6ZndrbX8o',
    appId: '1:91899540530:ios:fcb435abfdbaeb12ebf82b',
    messagingSenderId: '91899540530',
    projectId: 'fidequiz-c4410',
    storageBucket: 'fidequiz-c4410.firebasestorage.app',
    iosBundleId: 'com.quizcatolico.app',
  );
}
