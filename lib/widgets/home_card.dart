import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class HomeCard extends StatelessWidget{

  final String title, subtitle;
  final Widget icon;

  const HomeCard({
    super.key, 
    required this.title, 
    required this.subtitle, 
    required this.icon});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: mq.width *.45,
      child: Column(
        children: [

        icon,

        SizedBox(height: 6 ),
        Text(
          title, 
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(height: 6 ),
        Text(subtitle,
        style: TextStyle(
          color: Theme.of(context).lightText,
          fontSize: 13,
          fontWeight: FontWeight.w500),
          )
      ],));
  }
}