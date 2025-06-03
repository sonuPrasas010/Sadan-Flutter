import 'package:flutter/material.dart';

class VehicleDetailWidget extends StatelessWidget {
  VehicleDetailWidget(this.iconName, this.titleName, this.subtitleName);
  final IconData iconName;
  final String titleName;
  final String subtitleName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconName,
        color: Colors.orange,
      ),
      title: Text(
        titleName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitleName),
    );
  }
}
