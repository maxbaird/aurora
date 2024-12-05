import '../../core/presentation/widgets/aurora_schedule_panel.dart';
import '../../core/presentation/widgets/aurora_status_panel.dart';
import 'package:flutter/material.dart';

class Aurora extends StatelessWidget {
  const Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuroraStatusPanel(
          roomStatus: RoomStatus.available,
          roomName: 'Conference Room',
          meetingName: 'Weekly Meeting',
          hostName: 'Max Baird',
        ),
        AuroraSchedulePanel(scheduleInformation: [
          ScheduleInformation(
            from: DateTime(2024, 12, 5, 10, 15),
            to: DateTime(2024, 12, 5, 11, 15),
            meetingTitle: 'Project Planning',
            hostName: 'Rebecka Dunn',
          ),
          ScheduleInformation(
            from: DateTime(2024, 12, 5, 13),
            to: DateTime(2024, 12, 5, 15),
            meetingTitle: 'Next Step Session',
            hostName: 'Alice Larsson',
          ),
          ScheduleInformation(
            from: DateTime(2024, 12, 6, 8),
            to: DateTime(2024, 12, 6, 11),
            meetingTitle: 'Workflow Workshop',
            hostName: 'William Svensson',
          ),
        ]),
      ],
    );
  }
}
