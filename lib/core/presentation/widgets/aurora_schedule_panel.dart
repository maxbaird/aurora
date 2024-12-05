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
      color: Colors.grey.withOpacity(0.1),
      width: screenWidth * 0.33,
      child: Column(
        children: [
          for (var schedule in scheduleInformation) ...[
            _MeetingInfo(scheduleInformation: schedule)
          ]
        ],
      ),
    );
  }
}

class _MeetingInfo extends StatelessWidget {
  const _MeetingInfo({
    super.key,
    required this.scheduleInformation,
  });

  final ScheduleInformation scheduleInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  '${scheduleInformation.from.hour}:${scheduleInformation.from.minute}',
                  style: const TextStyle(color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.grey,
                  size: 14.0,
                ),
              ),
              Text(
                  '${scheduleInformation.to.hour}:${scheduleInformation.to.minute}',
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text(scheduleInformation.meetingTitle,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700)),
          Text(
            scheduleInformation.hostName,
            style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
