// File generated for fidequiz-c4410
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
    apiKey: 'AIzaSyDemoKeyReplaceWithYourOwnIfAvailable',
    appId: '1:100000000000:web:fidequizwebid',
    messagingSenderId: '100000000000',
    projectId: 'fidequiz-c4410',
    authDomain: 'fidequiz-c4410.firebaseapp.com',
    storageBucket: 'fidequiz-c4410.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyReplaceWithYourOwnIfAvailable',
    appId: '1:100000000000:android:fidequizandroidid',
    messagingSenderId: '100000000000',
    projectId: 'fidequiz-c4410',
    storageBucket: 'fidequiz-c4410.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyReplaceWithYourOwnIfAvailable',
    appId: '1:100000000000:ios:fidequiziosid',
    messagingSenderId: '100000000000',
    projectId: 'fidequiz-c4410',
    storageBucket: 'fidequiz-c4410.appspot.com',
    iosBundleId: 'com.quizcatolico.app',
  );
}
