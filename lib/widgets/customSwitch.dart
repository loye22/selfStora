// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class customSwitch extends StatelessWidget {
//   final String label;
//   final String subLabel;
//   final bool value;
//   final ValueChanged<bool>? onChanged;
//   final TextStyle labelStyle;
//   final Color switchColor;
//
//   customSwitch({
//     required this.label,
//     required this.subLabel,
//     required this.value,
//     required this.onChanged,
//     this.labelStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     this.switchColor = Colors.blue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: labelStyle,
//               ),
//               SizedBox(height: 5),
//               Text(
//                 subLabel,
//                 style: TextStyle( color: Colors.grey),
//               ),
//             ],
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: switchColor,
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class customSwitch extends StatelessWidget {
  final String label;
  final String subLabel;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final TextStyle labelStyle;
  final Color switchColor;

  customSwitch({
    required this.label,
    required this.subLabel,
    required this.value,
    required this.onChanged,
    this.labelStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.switchColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: labelStyle,
                ),
                SizedBox(height: 5),
                Text(
                  subLabel,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: switchColor,
          ),
        ],
      ),
    );
  }
}
