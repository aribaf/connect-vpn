import 'package:flutter/material.dart';
 import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;

  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: mq.height * .01,
      ) ,
      color: Colors.teal[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
        

          
        },
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        
          leading: Icon(data.icon.icon,
          color: data.icon.color,
          size: data.icon.size ?? 28,
          ),
        
          // title
          title: Text(
            data.title
          ),
        
          // subtitle
          subtitle: Text(data.subtitle)
        
         
        ),
      ),
    );
  }
}
