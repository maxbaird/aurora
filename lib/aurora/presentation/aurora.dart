import 'package:flutter/material.dart';

class Aurora extends StatelessWidget {
  const Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          color: Colors.red,
          width: screenWidth * 0.66,
        ),
        Container(
          color: Colors.blue,
          width: screenWidth * 0.33,
        )
      ],
    );
  }
}
