import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfstorage/pages/discountPage.dart';
import 'package:selfstorage/pages/homePage.dart';
import 'package:selfstorage/pages/mapScreen.dart';
import 'package:selfstorage/pages/rootPage.dart';
import 'package:selfstorage/pages/loginPage.dart';
import 'package:selfstorage/pages/sitePage.dart';
import 'package:selfstorage/pages/subscriptionPage.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyDADuka9RJf0g7_xsWOreV71phJX92oN98",
        authDomain: "selfstorage-de099.firebaseapp.com",
        projectId: "selfstorage-de099",
        storageBucket: "selfstorage-de099.appspot.com",
        messagingSenderId: "32695980573",
        appId: "1:32695980573:web:9d2c02212bcb5ae8d92cf4",
        measurementId: "G-PL7XTYN00E"
    ),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Self Storage",

      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'louie' , focusColor: Color.fromRGBO(20, 53, 96,1  )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)  {
          if (snapshot.hasData) {
            return rootPage();
          } else {
            return loginPage();
          }
        },
      ),
      routes: {
        rootPage.routeName: (ctx) => rootPage(),
        loginPage.routeName: (ctx) => loginPage(),
        homePage.routeName: (ctx) => homePage(),
        sitePage.routeName: (ctx) => sitePage(),
        subscriptionPage.routeName: (ctx) => subscriptionPage(),
        discountPage.routeName: (ctx) => discountPage(),
        mapPage.routeName: (ctx) => mapPage(),



      },
    );


  }


}