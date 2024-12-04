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
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: kAuroraWhite.withOpacity(0.6),
        ),
        child: Ink(
          height: 40.0,
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
      ),
    );
  }
}
