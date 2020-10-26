import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mubrm_tag/router/app_module.dart';
import 'package:provider/provider.dart';

Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

   Provider.debugCheckInvalidValueType = null;

   runApp(ModularApp(module: AppModule()));
}

