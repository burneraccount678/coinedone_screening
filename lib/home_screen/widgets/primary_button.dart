import 'package:coinedone_screening/constants/text_constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: const Center(
              child: Text(TextConstants.extendFreeTime,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.blue)))),
    );
  }
}
