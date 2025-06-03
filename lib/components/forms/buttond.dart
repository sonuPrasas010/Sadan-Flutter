
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color color, textColor;

  const Button({
    Key? key,
    required this.text,
    required this.press,
    this.color = const Color(0xFF277da8),
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(30 * 1.5),
        ),
        child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(
              // primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            ),
            child: Text(
              text,
            )),
      ),
    );
  }
}
