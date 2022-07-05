import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/ui/auth/widgets/guest_view.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_close_button.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';
import 'package:usta_bor_android/ui/main/select_site/select_site.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GuestView(
        showSpacer: true,
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 64),
        child: CircleCloseButton(
          onPressed: () async {
            if(LocalSource.getInstance.siteId == -1){
              Get.offAll(() => SelectSiteScreen());
            }
            else {
              print("CLOSE--------");
              Get.offAll(() => MainPage());
            }
          },
        ),
      ),
    );
  }
}
