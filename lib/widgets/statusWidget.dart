import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfstorage/model/staticVar.dart';

class statusWidget extends StatelessWidget {
  final String status;

  statusWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String text;

    switch (status) {
      case 'occupied':
        icon = Icons.person;
        color = Colors
            .green; // You can choose the appropriate color for occupied status
        text = 'Occupied';
        break;
      case 'unavailable':
        icon = Icons.do_not_disturb;
        color = Colors
            .red; // You can choose the appropriate color for unavailable status
        text = 'Unavailable';
        break;
      case 'available':
        icon = Icons.check;
        color = Colors
            .grey; // You can choose the appropriate color for available status
        text = 'Available';
        break;

      case 'reserved':
        icon = Icons.info;
        color = Color(0xFF86E6D1);
        text = 'reserved';
        break;

      case 'moving out':
        icon = Icons.info;
        color = Color(0xFF6ECAF2);
        text = 'moving out';
        break;
      case 'moved in':
        icon = Icons.info;
        color = Color(0xFF729AF8);
        text = 'moved in';
        break;

      case 'overlocked':
        icon = Icons.info;
        color = Color(0xFFE95362);
        text = 'overlocked';
        break;

      case 'repossessed':
        icon = Icons.info;
        color = Color(0xFFC865B9);
        text = 'repossessed';
        break;

      case 'available':
        icon = Icons.check;
        color = Colors
            .grey; // You can choose the appropriate color for available status
        text = 'Available';
        break;

      default:
        icon = Icons.error;
        color = Colors.black;
        text = '404Error';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: staticVar.golobalWidth(context) * .10,
        height: staticVar.golobalHigth(context) * .06,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(8.0),
            color: color),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            statusWidget(status: 'Occupied'),
            SizedBox(height: 16.0),
            statusWidget(status: 'Unavailable'),
            SizedBox(height: 16.0),
            statusWidget(status: 'Available'),
          ],
        ),
      ),
    ),
  ));
}
