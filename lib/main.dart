import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fidequiz/app.dart';
import 'package:fidequiz/firebase_options.dart';
import 'package:fidequiz/services/ad_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Trava orientação em retrato para melhor experiência no celular
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializa o Firebase com as opções do fidequiz-c4410
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  // Inicializa sistema de anúncios
  try {
    AdService().initialize();
  } catch (e) {
    debugPrint('AdService initialization notice: $e');
  }

  runApp(const FideQuizApp());
}
