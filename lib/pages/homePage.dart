import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class homePage extends StatefulWidget {
  static const routeName = '/homePage';

  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("homePagexxxx"),),
    );
  }
}
