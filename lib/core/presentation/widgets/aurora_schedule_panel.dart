import 'package:flutter/material.dart';

import '../../../main.dart';

class AuroraSchedulePanel extends StatelessWidget {
  const AuroraSchedulePanel({
    super.key,
    required this.scheduleInformation,
  });

  final List<ScheduleInformation> scheduleInformation;

  static final DateTime _kCurrentDate = DateTime(2024, 12, 5);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.withOpacity(0.1),
      width: screenSize.width * 0.34,
      height: screenSize.height,
      child: Column(
        children: [
          const _DateBar(date: 'today'),
          for (var schedule in scheduleInformation) ...[
            if (schedule.date.difference(_kCurrentDate).inDays == 0) ...[
              _MeetingInfo(scheduleInformation: schedule)
            ]
          ],
          const _DateBar(date: 'tomorrow, Friday, December 06'),
          for (var schedule in scheduleInformation) ...[
            if (schedule.date.difference(_kCurrentDate).inDays > 0) ...[
              _MeetingInfo(scheduleInformation: schedule)
            ]
          ],
        ]
            .map((e) =>
                Padding(padding: const EdgeInsets.only(bottom: 10.0), child: e))
            .toList(),
      ),
    );
  }
}

class _DateBar extends StatelessWidget {
  const _DateBar({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            Text(
              date.toUpperCase(),
              style:
                  const TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
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

  String _padMinute(int minute) {
    return minute == 0 ? '00' : minute.toString();
  }

  String get _fromMinute => _padMinute(scheduleInformation.from.minute);

  String get _toMinute => _padMinute(scheduleInformation.to.minute);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${scheduleInformation.from.hour}:$_fromMinute',
                  style: const TextStyle(color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.grey,
                  size: 14.0,
                ),
              ),
              Text('${scheduleInformation.to.hour}:$_toMinute',
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
