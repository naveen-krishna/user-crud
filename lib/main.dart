import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_listing/core/di/injection_container.dart';
import 'package:product_listing/feature/home/presentation/view/user_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  injectionContainer();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: const UserListPage(),
    );
  }
}
