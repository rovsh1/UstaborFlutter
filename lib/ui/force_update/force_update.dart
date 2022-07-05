import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/app_color.dart';


class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("cant_use".tr,style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,),
            SizedBox(height: 30),
            GestureDetector(
                onTap: () async{
                  final newVersion = await NewVersion(
                    iOSId: 'com.rideauction.Ustabor',
                    androidId: 'su.keysoft.ustabor',
                  );
                  final status = await newVersion.getVersionStatus();
                  if (await canLaunch(status!.appStoreLink)) {
                    await launch(status.appStoreLink);
                  } else {
                    throw 'Could not launch appStoreLink';
                  }

                },
                child: Container(
                  width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("update_button".tr,style: TextStyle(color: Colors.white,fontSize: 20),))))
        ],
        ),
      ),
    );
  }
}
