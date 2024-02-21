import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class sitePage extends StatefulWidget {
  static const routeName = '/sitePage';

  const sitePage({super.key});

  @override
  State<sitePage> createState() => _sitePageState();
}

class _sitePageState extends State<sitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("sitepage"),),
    );
  }
}
