import 'package:coinedone_screening/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({Key? key, required this.title, required this.duration})
      : super(key: key);
  final String title;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Center(
            child: SvgPicture.asset(title.contains("Phone")
                ? ImageConstants.phone
                : ImageConstants.laptop),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Text(
                  duration,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.blue),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
