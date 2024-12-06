import 'package:aurora/aurora/presentation/aurora.dart';
import 'package:aurora/aurora/presentation/flows/schedule_meeting/schedule_meeting_1.dart';
import 'package:aurora/core/presentation/widgets/aurora_status_panel.dart';
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

class _Aurora extends StatefulWidget {
  const _Aurora({super.key});

  @override
  State<_Aurora> createState() => _AuroraState();
}

class _AuroraState extends State<_Aurora> {
  bool _showUnavailability = false;

  RoomStatus _roomStatus = RoomStatus.available;

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
      body: Aurora(roomStatus: _roomStatus),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime? result = await showDatePicker(
            context: context,
            barrierDismissible: false,
            firstDate: DateTime(2000),
            lastDate: DateTime(2024, 12, 31),
          );

          if (!context.mounted) {
            return;
          }

          final TimeOfDay? time = await showTimePicker(
            context: context,
            barrierDismissible: false,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
            orientation: Orientation.landscape,
            builder: (BuildContext context, Widget? child) {
              // We just wrap these environmental changes around the
              // child in this builder so that we can apply the
              // options selected above. In regular usage, this is
              // rarely necessary, because the default values are
              // usually used as-is.
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

          if (!context.mounted) {
            return;
          }

          final _meetingtitleAndEmployeeId = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScheduleMeeting1()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
