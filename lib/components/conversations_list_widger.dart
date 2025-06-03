import 'package:flutter/material.dart';

class ConversationListWidget extends StatelessWidget {
  final String imageUrl;
  final String senderName;
  final String messageText;
  final String dateText;

  ConversationListWidget(
      this.imageUrl, this.senderName, this.messageText, this.dateText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 10),
      // decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("images/man.png")),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
              ),
              Text(
                messageText,
              ),
            ],
          ),
          Spacer(),
          Text(
            dateText,
          ),
        ],
      ),
    );
  }
}
