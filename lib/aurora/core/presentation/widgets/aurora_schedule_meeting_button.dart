import 'package:flutter/material.dart';

import '../colors.dart';

class AuroraScheduleMeetingButton extends StatelessWidget {
  const AuroraScheduleMeetingButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(80.0),
      onTap: onTap,
      child: Ink(
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: kAuroraCyan.withOpacity(0.6),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: kAuroraWhite),
            Text(label,
                style: const TextStyle(
                  color: kAuroraWhite,
                  fontWeight: FontWeight.w500,
                )),
          ],
        )),
      ),
    );
  }
}
