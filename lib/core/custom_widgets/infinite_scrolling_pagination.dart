import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class InfiniteScrollingPagination extends StatelessWidget {
  final Function() onPagination;
  final Widget child;
  final bool isCallLoading;

  InfiniteScrollingPagination({
    Key? key,
    required this.onPagination,
    required this.child,
    this.isCallLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isCallLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            scrollInfo is ScrollUpdateNotification) {
          onPagination();
          return false;
        }
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: child),
          Container(
            color: AppColor.white,
            height: isCallLoading ? 90 : 0,
            padding: EdgeInsets.only(bottom: 32),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.green),
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
