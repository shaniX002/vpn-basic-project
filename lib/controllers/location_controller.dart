import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import '../models/Vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;

  final RxBool isloading = false.obs;

  Future<void> getVpnData() async {
    isloading.value = true;
    vpnList.clear();
    vpnList = await APIs.getVPNServers();
    isloading.value = false;
  }
}
