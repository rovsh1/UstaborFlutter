import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class CustomBottomNavBarItem extends StatelessWidget {
  const CustomBottomNavBarItem({
    Key? key,
    required this.isActive,
    required this.activeIcon,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final bool isActive;
  final String activeIcon;
  final String icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: AppColor.green.withOpacity(.1),
      highlightColor: AppColor.green.withOpacity(.1),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
                color: isActive ? AppColor.green : Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                )),
          ),
          SizedBox(height: 10,),
          SvgPicture.asset(
            isActive ? activeIcon : icon,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 4,),
        ],
      ),
    );
  }
}
