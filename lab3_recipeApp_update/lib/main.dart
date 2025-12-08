import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.grey[50],
      cardTheme: const CardThemeData(
        elevation: 4,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );

    final dark = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.black,
      cardTheme: const CardThemeData(
        elevation: 4,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

    );

    return MaterialApp(
      title: 'Meals App',
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      home: const CategoriesScreen(),
    );
  }
}
