
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/Network_test_screen.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/widgets/countdowntimer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import 'package:vpn_basic_project/widgets/watch_ad.dart';
import '../helpers/pref.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONNECT VPN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(CupertinoIcons.bars),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(WatchAdDialog(onComplete: (){
                 AdHelper.showRewardedAd(onComplete: () {
                  Get.changeThemeMode(
                  Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              Pref.isDarkMode = !Pref.isDarkMode;
          } );
                
              },));
         
            },
            icon: Icon(
              Icons.brightness_2_outlined,
              size: 24,
            ),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 8),
            onPressed: () => Get.to(() => NetworkTestScreen()),
            icon: Icon(
              Icons.info_outlined,
              size: 24,
            ),
          ),
        ],
      ),
      bottomNavigationBar: changeLocation(context),
 body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05, width: double.maxFinite),
          
          Obx(()=> vpnButton()),
          
          Obx(
            ()=> Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty ? 'Location' : _controller.vpn.value.countryLong,
                  subtitle: 'Free',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: _controller.vpn.value.countryLong.isEmpty ? Icon(
                      Icons.vpn_lock_rounded,
                      size: 30,
                      color: Colors.teal
                    ): null  ,
                    backgroundImage: _controller.vpn.value.countryShort.isEmpty 
                    ? null
                    : AssetImage('assets/flags/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png')   ,

                  ),
                ),
                HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty? '100 ms' 
                  : _controller.vpn.value.ping + ' ms',
                  subtitle: 'Ping',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: Icon(
                      Icons.equalizer_outlined,
                      size: 30,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          
           StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) => 
              
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                subtitle: 'Download',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: Icon(
                    Icons.file_download_sharp,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
              ),
              HomeCard(
                title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                subtitle: 'Upload',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: Icon(
                    Icons.file_upload_rounded,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
              
         
            ),
          
          
          
          
        ],
      ),
    );
  }

  Widget vpnButton() => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.getButtonColor.withOpacity(.1),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.3),
                  ),
                  child: Container(
                    width: mq.height * .1,
                    height: mq.height * .1,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Colors.teal[400],
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.power_settings_new_rounded,
size: 30,
color: Colors.white,
),
],
),
),
),
),
),
),
Obx(() => Container(
margin: EdgeInsets.only(
top: mq.height * .015,
bottom: mq.height * .02,
),
padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
decoration: BoxDecoration(
color: Colors.teal,
borderRadius: BorderRadius.circular(15),
),
child: Text(
_controller.vpnState.value ==
VpnEngine.vpnDisconnected
? 'Not Connected'
: _controller.vpnState
.replaceAll('', '')
.toUpperCase(),
style: TextStyle(
fontSize: 12.5,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
)),
Obx(() => CountdownTimer(
startTimer: _controller.vpnState.value ==
VpnEngine.vpnConnected,
)),
],
);

Widget changeLocation(BuildContext context) => SafeArea(
child: Semantics(
button: true,
child: InkWell(
onTap: () => Get.to(() => LocationScreen()),
child: Container(
color: Theme.of(context).bottomav,
padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
height: 60,
child: Row(
children: [
Icon(
CupertinoIcons.map_pin_ellipse,
color: Colors.white,
size: 28,
),
SizedBox(
width: 15,
),
Text(
' Choose Location',
style: TextStyle(
color: Colors.white,
fontSize: 19,
fontWeight: FontWeight.bold,
),
),
Spacer(),
CircleAvatar(
backgroundColor: Colors.teal,
child: Icon(
Icons.arrow_circle_right_outlined,
color: Colors.white,
size: 30,
),
),
],
),
),
),
),
);
}