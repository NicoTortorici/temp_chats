import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String messageText;
  //String imageUrl;
  //String time;
  //bool isMessageRead;

  ChatTile({required this.name, required this.messageText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    //backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            this.messageText,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              // fontWeight: this.isMessageRead
                              //     ? FontWeight.bold
                              //     : FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   widget.time,
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: widget.isMessageRead
            //           ? FontWeight.bold
            //           : FontWeight.normal),
            // ),
          ],
        ),
      ),
    );
  }
}