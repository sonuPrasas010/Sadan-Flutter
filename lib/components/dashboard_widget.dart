import 'package:flutter/material.dart';
class DashboardWidget extends StatelessWidget {
  final String totalName;
  final String countNumber;
  DashboardWidget(
    this.totalName,
    this.countNumber,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            totalName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            countNumber,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
