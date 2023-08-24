import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions(
        apiKey: 'FAKE_API_KEY',
        appId: 'FAKE_APP_ID',
        messagingSenderId: 'FAKE_MESSAGING_SENDER_ID',
        projectId: 'FAKE_PROJECT_ID',
        storageBucket: 'FAKE_STORAGE_BUCKET',
      );
}
