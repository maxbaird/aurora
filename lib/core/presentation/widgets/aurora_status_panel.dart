import 'package:aurora/core/presentation/colors.dart';
import 'package:aurora/core/presentation/widgets/aurora_add_button.dart';
import 'package:aurora/core/presentation/widgets/aurora_schedule_meeting_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        const _Timer(),
        AuroraScheduleMeetingButton(
            label: 'Schedule Meeting',
            onTap: () {
              print('Schedule test');
            }),
      ],
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
      width: 200.0,
      height: 200.0,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
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
        debugPrint('Countdown Changed $timeStamp');
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
