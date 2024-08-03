import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final bool startTimer;

  const CountdownTimer({Key? key, required this.startTimer}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration duration = Duration();
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
      timer = null;
      duration = Duration();
    });
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startTimer && timer == null) {
      startTimer();
    } else if (!widget.startTimer && timer != null) {
      stopTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String twoDigit(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final hours = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));

    return Text(
      '$hours:$minutes:$seconds',
       style: TextStyle(fontSize: 22),
    );
  }
}
