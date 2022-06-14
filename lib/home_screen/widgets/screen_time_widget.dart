import 'package:flutter/material.dart';

class ScreenTimeWidget extends StatelessWidget {
  const ScreenTimeWidget(
      {Key? key,
      required this.title,
      required this.duration,
      required this.color})
      : super(key: key);
  final String title;
  final String duration;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 8),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: color,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(duration),
          ],
        )
      ],
    );
  }
}
