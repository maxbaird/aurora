import 'package:flutter/material.dart';

class ScheduleInformation {
  const ScheduleInformation({
    required this.from,
    required this.to,
    required this.meetingTitle,
    required this.hostName,
  });

  final DateTime from;
  final DateTime to;
  final String meetingTitle;
  final String hostName;
}

class AuroraSchedulePanel extends StatelessWidget {
  const AuroraSchedulePanel({
    super.key,
    required this.scheduleInformation,
  });

  final List<ScheduleInformation> scheduleInformation;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.33,
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
