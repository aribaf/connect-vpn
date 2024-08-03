import 'package:get/get.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';


class LocationController extends GetxController{
  List<Vpn> vpnList =Pref.vpnList;

  final RxBool isLoading = false.obs;

  Future<void> getVpnData()async{
    isLoading.value=true;
    vpnList.clear();
    vpnList = await APIs.getVPNServers();
    isLoading.value =false;


  }
}
/*class LocationController extends GetxController {
  List<Vpn> vpnList = [];
  RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    try {
      vpnList = await APIs.getVPNServers();
    } catch (e) {
      // Handle error, such as showing a snackbar or logging the error
      print('Error fetching VPN data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}


*/