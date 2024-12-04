import 'package:aurora/core/presentation/colors.dart';
import 'package:aurora/core/presentation/widgets/aurora_add_button.dart';
import 'package:aurora/core/presentation/widgets/aurora_schedule_meeting_button.dart';
import 'package:flutter/material.dart';

enum RoomStatus {
  booked(Colors.red),
  available(Colors.green);

  final Color color;
  const RoomStatus(this.color);
}

class AuroraStatusPanel extends StatelessWidget {
  const AuroraStatusPanel({
    super.key,
    required this.roomStatus,
    this.meetingName,
    this.hostName,
  });

  final RoomStatus roomStatus;
  final String? meetingName;
  final String? hostName;

  Widget get _body => switch (roomStatus) {
        RoomStatus.available => const _Available(),
        RoomStatus.booked => _Booked(
            meetingName: meetingName ?? 'Unknown',
            hostName: hostName ?? 'Unknown',
          ),
      };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: roomStatus.color,
      width: screenWidth * 0.66,
      child: _body,
    );
  }
}

class _Available extends StatelessWidget {
  const _Available({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuroraAddButton(onTap: () {
          print('Tapped');
        }),
        const Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: Text(
            'Book Now',
            style: TextStyle(
              fontSize: 48.0,
              color: kAuroraWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _Booked extends StatelessWidget {
  const _Booked({
    super.key,
    required this.meetingName,
    required this.hostName,
  });

  final String meetingName;
  final String hostName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'BOOKED',
          style: const TextStyle(
            fontSize: 48.0,
            color: kAuroraWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(meetingName),
        Text(hostName),
        AuroraScheduleMeetingButton(
            label: 'Schedule Meeting',
            onTap: () {
              print('Schedule test');
            }),
      ],
    );
  }
}
