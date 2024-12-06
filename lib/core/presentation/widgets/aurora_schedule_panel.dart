import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class AuroraSchedulePanel extends StatefulWidget {
  const AuroraSchedulePanel({
    super.key,
    required this.scheduleInformation,
  });

  final List<ScheduleInformation> scheduleInformation;

  @override
  State<AuroraSchedulePanel> createState() => _AuroraSchedulePanelState();
}

class _AuroraSchedulePanelState extends State<AuroraSchedulePanel> {
  late List<ScheduleInformation> _uniqueDates;

  @override
  void initState() {
    super.initState();

    _uniqueDates = List.from(widget.scheduleInformation);
    final ids = _uniqueDates.map((e) => e.date).toSet();
    _uniqueDates.retainWhere((x) => ids.remove(x.date));
    _uniqueDates.sort((a, b) => a.date.isBefore(b.date)
        ? -1
        : a.date.isAfter(b.date)
            ? 1
            : 0);
  }

  bool _datesEqual(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.withOpacity(0.1),
      width: screenSize.width * 0.34,
      child: Column(
        children: [
          for (var uniqueDate in _uniqueDates) ...[
            _DateBar(
              date: DateFormat('EEEE, MMMM dd, yyyy').format(uniqueDate.date),
            ),
            for (var schedule in widget.scheduleInformation) ...[
              if (_datesEqual(uniqueDate.date, schedule.date)) ...[
                _MeetingInfo(scheduleInformation: schedule)
              ]
            ]
          ]
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
    required this.scheduleInformation,
  });

  final ScheduleInformation scheduleInformation;

  String _padDigit(int minute) {
    return minute.toString().length == 1 ? '0$minute' : minute.toString();
  }

  String get _fromMinute => _padDigit(scheduleInformation.from.minute);
  String get _toMinute => _padDigit(scheduleInformation.to.minute);
  String get _fromHour => _padDigit(scheduleInformation.from.hour);
  String get _toHour => _padDigit(scheduleInformation.to.hour);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('$_fromHour:$_fromMinute',
                  style: const TextStyle(color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.grey,
                  size: 14.0,
                ),
              ),
              Text('$_toHour:$_toMinute',
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
