import 'package:aurora/core/presentation/colors.dart';
import 'package:aurora/core/presentation/widgets/aurora_add_button.dart';
import 'package:aurora/core/presentation/widgets/aurora_schedule_meeting_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

enum RoomStatus {
  booked(Colors.red, 'BOOKED'),
  available(Color.fromRGBO(76, 175, 80, 0.8), 'AVAILABLE');

  final Color color;
  final String value;
  const RoomStatus(this.color, this.value);
}

class AuroraStatusPanel extends StatelessWidget {
  const AuroraStatusPanel({
    super.key,
    required this.roomStatus,
    required this.roomName,
    this.meetingName,
    this.hostName,
  });

  final RoomStatus roomStatus;
  final String roomName;
  final String? meetingName;
  final String? hostName;

  Widget get _body => switch (roomStatus) {
        RoomStatus.available => const _Available(),
        RoomStatus.booked => _Booked(
            meetingName: meetingName ?? 'Unknown',
            hostName: hostName ?? 'Unknown',
          ),
      };

  String get _available =>
      roomStatus == RoomStatus.available ? 'Available' : '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: roomStatus.color,
      width: screenWidth * 0.66,
      child: Column(
        children: [
          _RoomInfo(
            roomName: roomName,
            available: _available,
            roomStatus: roomStatus,
          ),
          _body,
        ],
      ),
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
              fontSize: 18.0,
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'BOOKED',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: kAuroraWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: _Timer(),
                ),
                const SizedBox(height: 5.0),
                Text(meetingName,
                    style: const TextStyle(
                        color: kAuroraWhite, fontWeight: FontWeight.bold)),
                Text(hostName, style: const TextStyle(color: kAuroraWhite)),
              ],
            ),
          ),
          AuroraScheduleMeetingButton(
              label: 'Schedule Meeting',
              onTap: () {
                print('Schedule test');
              }),
        ],
      ),
    );
  }
}

class _RoomInfo extends StatelessWidget {
  const _RoomInfo({
    super.key,
    required this.roomName,
    required this.available,
    required this.roomStatus,
  });

  final String roomName;
  final String available;
  final RoomStatus roomStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  roomName,
                  style: const TextStyle(fontSize: 18.0, color: kAuroraWhite),
                ),
                roomStatus == RoomStatus.booked
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            available,
                            style: const TextStyle(
                                fontSize: 16.0, color: kAuroraWhite),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer({super.key});

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 60 * 60 * 2,
      initialDuration: 0,
      controller: CountDownController(),
      width: 100.0,
      height: 100.0,
      ringColor: kAuroraWhite,
      ringGradient: null,
      fillColor: Colors.amber,
      fillGradient: null,
      backgroundColor: Colors.black,
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        // debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (_, duration) {
        if (duration.inSeconds == 0) {
          return "Start";
        } else {
          return _printDuration(duration);
        }
      },
    );
  }
}
