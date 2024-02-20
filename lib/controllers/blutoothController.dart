import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BlutoothController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Future<void> scanDevice() async {
    if (!(await Permission.bluetooth.request().isGranted)) {
      var status = await Permission.bluetoothScan.request();
      if (!status.isGranted) {
        print('Bluetooth Scan permission denied');
        return;
      }
    }

    if (!(await Permission.bluetoothConnect.isGranted)) {
      var status = await Permission.bluetoothConnect.request();
      if (!status.isGranted) {
        print('Bluetooth Connect permission get denied');
        return;
      }
    }

    print('Permissions granted. Starting scan...');
    ble.startScan(timeout: Duration(seconds: 5));
    ble.stopScan();
  }

  Stream<List<ScanResult>> get scanResult {
    return ble.scanResults;
  }
}
