import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_button.dart';
import 'widgets/how_it_works_page_item.dart';

class HowItWorksScreen extends StatefulWidget {
  const HowItWorksScreen({Key? key}) : super(key: key);

  @override
  _HowItWorksScreenState createState() => _HowItWorksScreenState();
}

class _HowItWorksScreenState extends State<HowItWorksScreen> {
  PageController pageController = PageController();
  int index = 0;
  late List<Widget> pagesList = [
    HowItWorksPageItem(
      imgPath: 'assets/png/onboarding1.png',
      title: 'on_boarding_title1',
      subtitle: 'on_boarding_subtitle1',
    ),
    HowItWorksPageItem(
      imgPath: 'assets/png/onboarding2.png',
      title: 'on_boarding_title2',
      subtitle: 'on_boarding_subtitle2',
    ),
    HowItWorksPageItem(
      imgPath: 'assets/png/onboarding3.png',
      title: 'on_boarding_title3',
      subtitle: 'on_boarding_subtitle3',
    ),
    HowItWorksPageItem(
      imgPath: 'assets/png/onboarding4.png',
      title: 'on_boarding_title4',
      subtitle: 'on_boarding_subtitle4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leadingWidth: 68,
        leading: LeadingButton(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32),
          child: Text(
            'how_it_works'.tr,
            textAlign: TextAlign.center,
            style: AppStyle.baseStyle.copyWith(color: AppColor.black40, fontSize: 24, fontWeight: FontWeight.w600),

          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                children: pagesList,
                onPageChanged: (index) {
                  this.index = index;
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, bottom: 0, top: 32),
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
                  index == 3
                      ? Container(
                          width: 40,
                        )
                      : CircleButton(
                          onPressed: () async {
                            if (index == 3) {
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
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
