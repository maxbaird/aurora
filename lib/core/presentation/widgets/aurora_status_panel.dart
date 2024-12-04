import 'package:aurora/core/presentation/colors.dart';
import 'package:aurora/core/presentation/widgets/aurora_add_button.dart';
import 'package:flutter/material.dart';

enum RoomStatus {
  booked(Colors.red),
  available(Colors.green);

  final Color color;
  const RoomStatus(this.color);
}

class AuroraStatusPanel extends StatelessWidget {
  const AuroraStatusPanel({super.key, required this.roomStatus});

  final RoomStatus roomStatus;

  Widget get _body => switch (roomStatus) {
        RoomStatus.available => const _Available(),
        RoomStatus.booked => const _Booked(),
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
        AuroraAddButton(onTap: () {}),
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
  const _Booked({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
