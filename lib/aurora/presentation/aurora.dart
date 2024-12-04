import 'package:aurora/core/presentation/widgets/aurora_status_panel.dart';
import 'package:flutter/material.dart';

class Aurora extends StatelessWidget {
  const Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const AuroraStatusPanel(
          roomStatus: RoomStatus.booked,
          meetingName: 'Weekly',
          hostName: 'Max Baird',
        ),
        Container(
          color: Colors.blue,
          width: screenWidth * 0.33,
        )
      ],
    );
  }
}
