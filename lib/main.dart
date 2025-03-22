import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/helper/functions.dart';
import 'package:firstapp/views/home.dart';
import 'package:firstapp/views/signin.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkUserLoggedInStatus() async {
   HelperFunctions.getUserLoggedInDetails(isLoggedin: _isLoggedin).then((value){
    setState(() {
    _isLoggedin = value;
    });
   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedin ?? false) ? Home() : SignIn(),
    );
  }
}