import '../colors.dart';
import 'package:flutter/material.dart';

class AuroraAddButton extends StatelessWidget {
  const AuroraAddButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Ink(
        width: 150.0,
        height: 150.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF597931),
          ),
          child: const Icon(
            Icons.add,
            size: 70.0,
            color: kAuroraWhite,
          ),
        ),
      ),
    );
  }
}
