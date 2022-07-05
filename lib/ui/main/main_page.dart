import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/ui/main/application_sheet/application_sheet.dart';
import 'package:usta_bor_android/ui/main/catalog/catalog_screen.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_screen.dart';
import 'package:usta_bor_android/ui/main/prices/prices_screen.dart';
import 'package:usta_bor_android/ui/main/profile/profile_screen.dart';
import 'package:usta_bor_android/ui/main/widgets/custom_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/main/widgets/custom_floating_button.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<MainController>(
        builder: (value) {
          return IndexedStack(
            children: [
              CatalogScreen(),
              PricesScreen(),
              MyApplicationScreen(),
              ProfileScreen()
            ],
            index: value.index,
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          Get.bottomSheet(
            ApplicationSheet(),
            ignoreSafeArea: false,
            enableDrag: false,
            isScrollControlled: true,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
