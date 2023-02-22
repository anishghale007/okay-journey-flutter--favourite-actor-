import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Center(
          child: Container(
            height: 300,
            width: 300,
            child: Image.asset(
              'assets/images/no_data.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 200),
      ],
    );
  }
}
