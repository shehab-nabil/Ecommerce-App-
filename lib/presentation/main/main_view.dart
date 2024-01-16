import 'package:flutter/material.dart';
import 'package:tut/presentation/resource/routes_manager.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginRoute);
              },
              child: const Text('back')),
          const Text('mainView'),
        ],
      )),
    );
  }
}
