import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchAdDialog extends StatelessWidget {
  final VoidCallback onComplete;

  const WatchAdDialog({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Change Theme.'),
      content: const Text('Watch an Ad to change your App Theme.'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          textStyle: TextStyle(
            color: Colors.teal,
          ),

          child: Text('Watch Ad'),
          onPressed: (){

          Get.back();
          onComplete();

          }
        
        ),
      ],
    );
  }
}
