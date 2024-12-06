import 'aurora/presentation/aurora.dart';
import 'aurora/presentation/flows/schedule_meeting/schedule_meeting_1.dart';
import 'core/presentation/widgets/aurora_status_panel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const _Aurora(),
    );
  }
}

class ScheduleInformation {
  const ScheduleInformation({
    required this.date,
    required this.from,
    required this.to,
    required this.meetingTitle,
    required this.hostName,
  });

  final DateTime date;
  final TimeOfDay from;
  final TimeOfDay to;
  final String meetingTitle;
  final String hostName;
}

List<ScheduleInformation> scheduleInformation = [
  ScheduleInformation(
    date: DateTime(2024, 12, 5),
    from: const TimeOfDay(hour: 10, minute: 15),
    to: const TimeOfDay(hour: 11, minute: 15),
    meetingTitle: 'Project Planning',
    hostName: 'Rebecka Dunn',
  ),
  ScheduleInformation(
    date: DateTime(2024, 12, 5),
    from: const TimeOfDay(hour: 5, minute: 1),
    to: const TimeOfDay(hour: 5, minute: 15),
    meetingTitle: 'Next Step Session',
    hostName: 'Alice Larsson',
  ),
  ScheduleInformation(
    date: DateTime(2024, 12, 6),
    from: const TimeOfDay(hour: 6, minute: 8),
    to: const TimeOfDay(hour: 6, minute: 11),
    meetingTitle: 'Workflow Workshop',
    hostName: 'William Svensson',
  ),
];

class _Aurora extends StatefulWidget {
  const _Aurora({super.key});

  @override
  State<_Aurora> createState() => _AuroraState();
}

class _AuroraState extends State<_Aurora> {
  bool _showUnavailability = false;

  RoomStatus _roomStatus = RoomStatus.available;

  Future<TimeOfDay?> _timePicker(String title) {
    return showTimePicker(
      helpText: title,
      context: context,
      barrierDismissible: false,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      orientation: Orientation.landscape,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: false,
              ),
              child: child!,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: Switch(
            activeColor: Colors.red,
            value: _showUnavailability,
            onChanged: (value) {
              setState(() {
                _showUnavailability = value;
                _roomStatus = _showUnavailability
                    ? RoomStatus.booked
                    : RoomStatus.available;
              });
            }),
        backgroundColor: Colors.black,
        title: const Text(
          'Aurora',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Aurora(
        key: UniqueKey(),
        roomStatus: _roomStatus,
        scheduleInformation: scheduleInformation,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime? meetingDate = await showDatePicker(
            context: context,
            barrierDismissible: false,
            firstDate: DateTime(2000),
            lastDate: DateTime(2024, 12, 31),
          );

          if (!context.mounted) {
            return;
          }

          final TimeOfDay? meetingStart =
              await _timePicker('Meeting Start Time');

          final TimeOfDay? meetingEnd = await _timePicker('Meeting End Time');

          if (!context.mounted) {
            return;
          }

          final String? meetingTitleAndEmployeeId = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScheduleMeeting1()),
          );

          if (meetingStart == null ||
              meetingEnd == null ||
              meetingDate == null ||
              meetingTitleAndEmployeeId == null) {
            return;
          }

          List<String> titleAndHost = meetingTitleAndEmployeeId.split(',');

          scheduleInformation.add(
            ScheduleInformation(
              date: meetingDate,
              from: meetingStart,
              to: meetingEnd,
              meetingTitle: titleAndHost.first,
              hostName: titleAndHost.last,
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
