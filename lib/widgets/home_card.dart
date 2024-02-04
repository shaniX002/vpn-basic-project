import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

// card to represent status in home screen
class HomeCard extends StatelessWidget {
  final String title, subtile;
  final Widget icon;

  const HomeCard(
      {super.key,
      required this.title,
      required this.subtile,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mq.width * .45,
      child: Column(
        children: [
          // icon
          icon,
          // adding some space
          SizedBox(
            height: 6,
          ),
          // title
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          // adding some space
          SizedBox(
            height: 6,
          ),
          //subtitle
          Text(
            subtile,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).lightText),
          )
        ],
      ),
    );
  }
}
