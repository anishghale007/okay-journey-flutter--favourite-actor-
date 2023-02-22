import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final VoidCallback onPress;
  final Widget content;

  ImageContainer({required this.onPress, required this.content,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(15),
          strokeWidth: 1.0,
          dashPattern: [5, 5],
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
