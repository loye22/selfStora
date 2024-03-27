import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class subscriptionItem extends StatelessWidget {
  final bool isCancelled;
  final String allocation;

  subscriptionItem({required this.isCancelled, required this.allocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(

        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: isCancelled ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCancelled ? Icons.cancel : Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 1.0),
            isCancelled ?Expanded(
              child: Text(
               'Canceled',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),

              ),
            ) : SizedBox.shrink(),
            isCancelled ? SizedBox.shrink() :  SizedBox(width: 1.0),
            isCancelled ? SizedBox.shrink() : Expanded(child: Text(allocation,style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),)),
          ],
        ),
      ),
    );
  }
}
