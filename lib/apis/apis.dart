import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/my_dialog.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import '../models/Vpn.dart';
import '../models/ip_details.dart';

class APIs {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> vpnList = [];
    try {
      final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};
        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }
    } catch (e) {
      MyDialogs.error(msg: 'Please sure you connect to internet');
      log('\ngetVPNServersE: $e');
    }
    vpnList.shuffle();
    if (vpnList.isNotEmpty) Pref.vpnList = vpnList;
    return vpnList;
  }

  static Future<void> getIPDetails({required Rx<IpDetails> ipData}) async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ipData.value = IpDetails.fromJson(data);
    } catch (e) {
      MyDialogs.error(msg: 'Please sure you connect to internet');
      log('\getIPDetailsE: $e');
    }
  }
}




// for understanding pupose
// ** CSV Data **
// Name,   Country,   Ping
// Test,   JP,        12
// Test1   US,        5
// Test2   IN         10

//*** List Data ***
// [Name, Country, Ping], [Test, JP, 12], [Test1, US, 5], [Test2, IN, 10]

//*** Json Data ***
// {"Name": "Test", "Country", "JP", "Ping", "10"}