import 'package:flutter/material.dart';
import 'package:help_me/views/select_call.dart';

class Scheduling extends StatefulWidget {
  Scheduling({Key key}) : super(key: key);

  @override
  _SchedulingState createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SelectCall(),
    );
  }
}
