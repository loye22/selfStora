import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class subscriptionPage extends StatefulWidget {
  static const routeName = '/subscriptionPage';

  const subscriptionPage({super.key});

  @override
  State<subscriptionPage> createState() => _subscriptionPageState();
}

class _subscriptionPageState extends State<subscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("subscriptionPage"),),
    );
  }
}
