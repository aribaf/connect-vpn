import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import '../models/vpn.dart';
import '../services/vpn_engine.dart';


class HomeController extends GetxController{


  final Rx<Vpn>vpn = Pref.vpn.obs;

    final vpnState = VpnEngine.vpnDisconnected.obs;



 Future<void> connectToVpn() async {
    if(vpn.value.openVPNConfigDataBase64.isEmpty) {

    MyDialogs.info(msg: 'Select a Loaction by clicking\'Change Location\'');
    return;
    }
    if (vpnState.value == VpnEngine.vpnDisconnected) {

     // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}' );

   final data = Base64Decoder()
   .convert(vpn.value.openVPNConfigDataBase64);

   final config =Utf8Decoder().convert(data);
   final vpnConfig = VpnConfig(
    country: vpn.value.countryLong, 
                              username: 'vpn',
                              password: 'vpn', 
                              config: config);

 // log('\n After: $config' );
      /// Start if stage is disconnected
      /// 
     AdHelper.showInterstitialAd(onComplete: () async {
      await VpnEngine.startVpn(vpnConfig);
     });
     // print("Starting VPN with config: ${vpnConfig.config}");
     // VpnEngine.startVpn(vpnConfig);

    } else {

     await VpnEngine.stopVpn();
    }
  }
 

Color get getButtonColor{


  switch ( vpnState.value ){

    case VpnEngine.vpnDisconnected: 
    return Colors.teal;

    case VpnEngine.vpnConnected: 
    return Colors.teal;

    default:
    return Colors.teal;
  }

}


String get getButtonText {
  switch (vpnState.value){
    case VpnEngine.vpnDisconnected:
    return 'Tap to Connect';

    case VpnEngine.vpnConnected:
    return 'Disconnect';

    default:
    return 'Connecting';
  }
}


  }

