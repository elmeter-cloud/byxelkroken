import 'package:byxelkroken/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_scaffold.dart';
import 'services/krok_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Byxelkroken Prototype',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProfile>(create: (context) => UserProfile(),),
          Provider<KrokService>(create: (context) => KrokService()),
        ],
        child: HomeScaffold(),
      ),
    );
  }
}
