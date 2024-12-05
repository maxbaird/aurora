import 'package:flutter/material.dart';

class AuroraSchedulePanel extends StatelessWidget {
  const AuroraSchedulePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.33,
    );
  }
}
