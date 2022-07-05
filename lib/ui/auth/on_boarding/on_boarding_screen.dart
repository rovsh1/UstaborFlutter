import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_button.dart';
import 'package:get/get.dart';
import '../auth_screen.dart';
import 'widgets/on_boarding_page_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  int index = 0;

  List<Widget> pagesList = [
    OnBoardingPageItem(
      imgPath: 'assets/png/onboarding1.png',
      title: 'on_boarding_title1',
      subtitle: 'on_boarding_subtitle1',
    ),
    OnBoardingPageItem(
      imgPath: 'assets/png/onboarding2.png',
      title: 'on_boarding_title2',
      subtitle: 'on_boarding_subtitle2',
    ),
    OnBoardingPageItem(
      imgPath: 'assets/png/onboarding3.png',
      title: 'on_boarding_title3',
      subtitle: 'on_boarding_subtitle3',
    ),
    OnBoardingPageItem(
      imgPath: 'assets/png/onboarding4.png',
      title: 'on_boarding_title4',
      subtitle: 'on_boarding_subtitle4',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 32, top: 54),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  await LocalSource.getInstance.setOnBoarding(false);
                  Get.off(AuthScreen());
                },
                child: Text(
                  'skip'.tr,
                  style: AppStyle.baseStyle.copyWith(
                    color: AppColor.black40.withOpacity(.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColor.grey100),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: PageView(
              controller: pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                this.index = index;
                setState(() {});
              },
              children: pagesList,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                index == 0
                    ? Container(width: 40)
                    : CircleButton(
                        onPressed: () {
                          pageController.animateToPage(
                            --index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        isRight: false,
                      ),
                Spacer(),
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    width: index == i ? 30 : 12,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: index >= i ? AppColor.greenGradient : null,
                      color: AppColor.grey20,
                    ),
                  ),
                Spacer(),
                CircleButton(
                  onPressed: () async {
                    if (index == 3) {
                      await LocalSource.getInstance.setOnBoarding(false);
                      Get.off(AuthScreen());
                    } else {
                      pageController.animateToPage(
                        ++index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  isRight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
