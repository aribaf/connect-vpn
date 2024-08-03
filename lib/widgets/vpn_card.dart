import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';

import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';
import '../models/vpn.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;

  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {

    final controller =Get.find<HomeController>();
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: mq.height * .01,
      ) ,
      color: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          controller.vpn.value = vpn;
          Pref.vpn =vpn;
          Get.back();
          //  MyDialogs.success(msg: 'Connecting VPN Location....');


        if (controller.vpnState.value == VpnEngine.vpnConnected){
          VpnEngine.stopVpn();
          Future.delayed(
            Duration(seconds: 2) ,() => controller.connectToVpn());
          }
        else{
          controller.connectToVpn();
        }

          
        },
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/flags/flags/${vpn.countryShort.toLowerCase()}.png',
                height: 40,
                width: mq.width * .15,
                fit: BoxFit.cover,
              ),
            ),
          ),
        
          // title
          title: Text(
            vpn.countryLong,
            style: TextStyle(
              color: Theme.of(context).lightText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        
          // subtitle
          subtitle: Row(
            children: [
              Icon(
                Icons.speed_sharp,
                color: Colors.black,
                size: 18,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
              (_formatBytes(vpn.speed, 2)),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        
          // trailing
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpn.numVpnSessions.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.people_alt_rounded,
                color: Colors.black,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 Bps";
    const suffixes = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
