import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controller/location_controller.dart';
import 'package:vpn_basic_project/controller/native_ad_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';




class LocationScreen extends StatelessWidget{

LocationScreen({super.key});

 final _controller =LocationController();
  final _adController =NativeAdController();

  @override
  Widget build(BuildContext context){
     
     _adController.ad =  AdHelper.loadNativeAd(adController: _adController);
     if(_controller.vpnList.isEmpty)  _controller.getVpnData(); 




     return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('VPN Locations (${_controller.vpnList.length})',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
       
        ),

      bottomNavigationBar: _adController.ad != null && _adController.adLoaded.isTrue
    ? SizedBox(
        height: 85,
        child: SafeArea(
          child: AdWidget(
            ad: _adController.ad!,
          ),
        ),
      )
    : null,


        //refresh button

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              top: 15,
              right: 15,
            ),
            child: FloatingActionButton(
              onPressed: () {
                _controller.getVpnData(); 
              },
              backgroundColor: Colors.teal,
              child: Icon(
                CupertinoIcons.refresh,
                color: Colors.white,
              ),
            ),
),

       
           body: _controller.isLoading.value
           ? _LoadingWidget()
           : _controller.vpnList.isEmpty
           ? _noVPNFound()
           : _vpnData(),
           ),
    
     );


  }

  _vpnData() => ListView.builder(

    itemCount: _controller.vpnList.length ,
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.only(
      top: mq.height * .015,
      bottom: mq.height * .1,
      left: mq.width * .04,
      right: mq.width * .04,

    ),
    itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnList[i])
  );

  _LoadingWidget() => SizedBox(
    width: double.infinity,
    height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            LottieBuilder.asset('assets/animation/loading.json',
                width: mq.width * .7),
          Text(
            'Loading locations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
           ), ),
        ],
      ),
    );

  _noVPNFound () => Center(
      child: Text(
        'Failed to Load VPNs.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
}

/*
class LocationScreen extends StatelessWidget {
  final LocationController _controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
       body: _controller.isLoading.value
            ? loadingWidget()
            : _controller.vpnList.isEmpty
                ? noVPNFound()
                : vpnData(),
      );
  }

  Widget loadingWidget() =>   SizedBox( 
     width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            LottieBuilder.asset('assets/animation/loading.json',
                width: mq.width * .7),
          Text(
            'Loading locations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
           ), ),
        ],
      ),
    );

  noVPNFound() => Center(
      child: Text(
        'VPN Not Found.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );


  vpnData() => ListView.builder(
      itemCount: _controller.vpnList.length,
      itemBuilder: (c, i) {
        final vpn = _controller.vpnList[i];
        return ListTile(
          title: Text(vpn.hostname),
          subtitle: Text(vpn.ip),
          // Add more VPN details as needed
        );
      },
    );
  }
*/