import 'package:flutter/material.dart';

class FileNotFoundWidget extends StatelessWidget {
  const FileNotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'images/empty_box.png',
          ),
          Text(
            'OOPS !! File Not Found!',
            // textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
