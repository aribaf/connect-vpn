import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {

const NetworkTestScreen({super.key});


@override
Widget build (BuildContext context) {

  final ipData =IPDetails.fromJson({}).obs;

  APIs.getIPDetails(ipData: ipData);

  return Scaffold(
    appBar: AppBar (title: Text (
      'Network Test Screen'
    )),

         //refresh button

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              top: 15,
              right: 15,
            ),
            child: FloatingActionButton(
              onPressed: () {
                ipData.value = IPDetails.fromJson({});
                APIs.getIPDetails(ipData: ipData);
              },
              //backgroundColor: Colors.teal,
              child: Icon(
                CupertinoIcons.refresh,
                color: Colors.white,
              ),
            ),
          ),


    body: Obx(
        () => ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: mq.width * .04,
          right: mq.width * .04,
          top: mq.height * .015,
          bottom: mq.height * .1,
        ),
        children: [
      //ip
          NetworkCard(data: NetworkData(
            title: 'IP Address' ,
            subtitle: ipData.value.query,
            icon: Icon(CupertinoIcons.location_solid,
            color: Colors.grey[800] ,) ,
          ),  ),
      //isp
           NetworkCard(data: NetworkData(
            title: 'Internet Provider' ,
            subtitle: ipData.value.isp,
            icon: Icon(Icons.network_cell_sharp,
            color: Colors.grey[800] ,) ,
          ),  ),
      //location
      
           NetworkCard(data: NetworkData(
            title: 'Location' ,
            subtitle: ipData.value.country.isEmpty ? 'Fetching...' : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
            icon: Icon(CupertinoIcons.location,
            color: Colors.grey[800] ,) ,
          ),  ),
      
      //pin code    
           NetworkCard(data: NetworkData(
            title: 'Pin-code' ,
            subtitle: ipData.value.zip,
            icon: Icon(CupertinoIcons.map_pin,
            color: Colors.grey[800] ,) ,
          ),  ),
      
      
      
        //timezone
      
        
           NetworkCard(data: NetworkData(
            title: 'Timezone' ,
            subtitle: ipData.value.timezone,
            icon: Icon(CupertinoIcons.time,
            color: Colors.grey[800] ,) ,
          ),  ),
        ],
      ),
    )  ,
    );
  }

}