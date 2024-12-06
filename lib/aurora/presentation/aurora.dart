import '../../core/presentation/widgets/aurora_schedule_panel.dart';
import '../../core/presentation/widgets/aurora_status_panel.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Aurora extends StatelessWidget {
  const Aurora({
    super.key,
    required this.roomStatus,
    required this.scheduleInformation,
  });

  final RoomStatus roomStatus;
  final List<ScheduleInformation> scheduleInformation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuroraStatusPanel(
          roomStatus: roomStatus,
          roomName: 'Conference Room',
          meetingName: 'Weekly Meeting',
          hostName: 'Max Baird',
        ),
        SingleChildScrollView(
          child: AuroraSchedulePanel(scheduleInformation: scheduleInformation),
        ),
      ],
    );
  }
}
