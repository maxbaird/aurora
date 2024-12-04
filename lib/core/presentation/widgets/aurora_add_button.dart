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
        width: 200.0,
        height: 200.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kAuroraCyan,
        ),
        child: const Icon(
          Icons.add,
          size: 128.0,
          color: kAuroraWhite,
        ),
      ),
    );
  }
}
