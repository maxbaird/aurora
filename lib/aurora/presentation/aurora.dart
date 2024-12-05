import 'package:aurora/core/presentation/widgets/aurora_schedule_panel.dart';
import 'package:aurora/core/presentation/widgets/aurora_status_panel.dart';
import 'package:flutter/material.dart';

class Aurora extends StatelessWidget {
  const Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuroraStatusPanel(
          roomStatus: RoomStatus.booked,
          roomName: 'Conference Room',
          meetingName: 'Weekly',
          hostName: 'Max Baird',
        ),
        AuroraSchedulePanel(scheduleInformation: [
          ScheduleInformation(
            from: DateTime(2024, 12, 5, 10, 15),
            to: DateTime(2024, 12, 5, 11, 15),
            meetingTitle: 'Weekly Meeting',
            hostName: 'Ryan',
          ),
        ]),
      ],
    );
  }
}
