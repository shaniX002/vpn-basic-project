import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchAdDialog extends StatelessWidget {
  final VoidCallback onComplete;

  const WatchAdDialog({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'Change Theme',
      ),
      content: Text(
        'Watch an Ads to Change App Theme',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(
            'Watch Ads',
            style: TextStyle(color: Colors.cyan),
          ),
          onPressed: () {
            onComplete();
            Get.back();
          },
        )
      ],
    );
  }
}
