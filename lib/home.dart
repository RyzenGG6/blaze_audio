import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:circular_image/circular_image.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          'Blaze ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
    image:
          AssetImage('assets/Blaze_logo.jpg'),
fit: BoxFit.cover,
        ),),
        child: SafeArea(

            //margin: EdgeInsets.only(bottom: 10),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                     // margin: EdgeInsets.only(top:350, right: 50),
                      child: ElevatedButton(
                          onPressed: () async {
                            bool hasPermission = await checkpermission();
                            if (hasPermission == true) {
                              Navigator.pushNamed(context, 'main');
                            }
                            ;
                          },
                          child: Text('Next')),
                    ),
                  ),

              ],

          ),
        ),
      ),
    );
  }

  Future<bool> checkpermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (deviceInfo.version.sdkInt > 31) {
      openAppSettings();
      var status = await Permission.storage.request();

      if (status == PermissionStatus.denied) {
        return false;
      }
      return true;
    } else {
      var status = await Permission.storage.request();
      if (status == PermissionStatus.denied) {
        return false;
      }
      return true;
    }
  }
}
