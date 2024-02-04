import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;
  NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: mq.height * .01),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            // leading
            leading: Icon(
              data.icon.icon,
              color: data.icon.color,
              size: data.icon.size ?? 28,
            ),

            //title
            title: Text(data.title),

            // subtitle
            subtitle: Text(data.subtitle)),
      ),
    );
  }
}
