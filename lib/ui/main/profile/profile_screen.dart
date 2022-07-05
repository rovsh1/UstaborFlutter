import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/ui/main/profile/widgets/unauthenticated_view.dart';
import 'widgets/authenticated.dart';

class ProfileScreen extends GetView<ProfileController> {
  // const ProfileScreen({Key? key}) : super(key: key);
  ProfileController controller = Get.find<ProfileController>();


  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppColor.white,
        child: LocalSource.getInstance.hasAccount ? Authenticated() : UnauthenticatedView());
  }
}
