import 'package:aurora/aurora/presentation/aurora.dart';
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
  bool _showUnavailability = false;

  RoomStatus _roomStatus = RoomStatus.available;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
      ),
    );
  }
}
