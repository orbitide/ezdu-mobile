import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initPushNotifications();

  runApp(const MyApp());
}
