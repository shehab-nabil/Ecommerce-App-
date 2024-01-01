import 'package:flutter/material.dart';
import 'package:tut/app/DI.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await initAppModule();
  runApp(MyApp());
}
