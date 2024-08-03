import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class APIs {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> vpnList = [];

    try {
      final response = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      final csvString = response.body.split("#")[1].replaceAll('*', '');
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

     for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
     }

      log(vpnList.first.hostname);
    } on Exception catch (e) {
        MyDialogs.error(msg: e.toString());
      log('\n getVPNServersE: $e');
    }
    vpnList.shuffle();

    if(vpnList.isNotEmpty) Pref.vpnList = vpnList;
  
    return vpnList;
  }


static Future<void> getIPDetails({required Rx<IPDetails> ipData} ) async {
   

    try {
      final response = await get(Uri.parse('http://ip-api.com/json/'));
      final data =jsonDecode(response.body);
      log(data.toString());
      ipData.value = IPDetails.fromJson(data);
    }
      catch (e) {
        MyDialogs.error(msg: e.toString());
      log('\n getIPDetailsE: $e');
      }

  }

}
