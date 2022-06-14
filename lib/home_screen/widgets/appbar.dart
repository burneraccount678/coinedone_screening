import 'package:coinedone_screening/constants/image_constants.dart';
import 'package:coinedone_screening/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(ImageConstants.avatar),
          )),
      title: const Text(
        TextConstants.dummyText,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(
            ImageConstants.setting,
            height: 25,
            width: 25,
          ),
        )
      ],
    );
  }
}
