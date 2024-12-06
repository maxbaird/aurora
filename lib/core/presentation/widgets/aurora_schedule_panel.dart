import 'package:flutter/material.dart';

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

  // @override
  // void didUpdateWidget(covariant AuroraSchedulePanel oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (!listEquals(
  //       widget.scheduleInformation, oldWidget.scheduleInformation)) {
  //     _uniqueDates = List.from(widget.scheduleInformation);
  //     final ids = _uniqueDates.map((e) => e.date).toSet();
  //     _uniqueDates.retainWhere((x) => ids.remove(x.date));
  //     _uniqueDates.sort((a, b) => a.date.isBefore(b.date)
  //         ? -1
  //         : a.date.isAfter(b.date)
  //             ? 1
  //             : 0);
  //   }
  // }

  bool _datesEqual(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.withOpacity(0.1),
      width: screenSize.width * 0.34,
      // height: screenSize.height,
      child: Column(
        children: [
          for (var uniqueDate in _uniqueDates) ...[
            _DateBar(date: uniqueDate.date.toString()),
            for (var schedule in widget.scheduleInformation) ...[
              if (_datesEqual(uniqueDate.date, schedule.date)) ...[
                _MeetingInfo(scheduleInformation: schedule)
              ]
            ]
          ]
          // const _DateBar(date: 'today'),
          // for (var schedule in widget.scheduleInformation) ...[
          //   if (schedule.date
          //           .difference(AuroraSchedulePanel._kCurrentDate)
          //           .inDays ==
          //       0) ...[_MeetingInfo(scheduleInformation: schedule)]
          // ],
          // const _DateBar(date: 'tomorrow, Friday, December 06'),
          // for (var schedule in widget.scheduleInformation) ...[
          //   if (schedule.date
          //           .difference(AuroraSchedulePanel._kCurrentDate)
          //           .inDays >
          //       0) ...[_MeetingInfo(scheduleInformation: schedule)]
          // ],
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
