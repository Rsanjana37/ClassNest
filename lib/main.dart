import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:subjects/pages/Loginpage.dart';
const String geminiAPIkey="AIzaSyCZgAd4zDG-d7b9Zl2-7Nsv-YZsTiIxgMw";
Future main() async {
  Gemini.init(apiKey: geminiAPIkey);
  WidgetsFlutterBinding.ensureInitialized();
  
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCD2bAQ86BmagDbGpNJQtdQ1jw2NOV4iD0",
        appId: "1:982605377831:android:866e5108f3aa3ff904f902",
        messagingSenderId: "982605377831",
        projectId: "subjects-73334",
        storageBucket: "gs://subjects-73334.appspot.com",
      ),
    );
  
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      home: LoginPage(),
      
    );
  }
}