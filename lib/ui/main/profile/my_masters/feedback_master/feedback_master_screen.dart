import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/feedback_master_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackMasterScreen extends GetView<FeedbackMasterController> {

  FeedbackMasterScreen({required this.url});

  var url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackMasterController>(
      builder: (controller) => Scaffold(
       // extendBodyBehindAppBar: true,
          appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leadingWidth: 68,
          leading: LeadingButton(),

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6),
            child: SizedBox(),
            // Text(
            //   "master_rating".tr,
            //   textAlign: TextAlign.center,
            //   style: AppStyle.baseStyle.copyWith(
            //     fontSize: 22,
            //   ),
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ),
        ),
        body:  Column(
          children: [
           // SizedBox(height: 10),
            Expanded(
              child: WebView(
                initialUrl: url.toString(),
                javascriptMode: JavascriptMode.unrestricted,

              ),
            ),
          ],
        )
        // ModalProgressHUD(
        //   inAsyncCall: controller.loading,
        //   color: Colors.transparent,
        //   child: SafeArea(
        //     child: Stack(
        //       children: [
        //         Positioned(
        //           top: 12,
        //           left: 16,
        //           right: 16,
        //           bottom: 88,
        //           child: ListView(
        //             physics: BouncingScrollPhysics(),
        //             children: [
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   ClipRRect(
        //                     borderRadius: BorderRadius.circular(32),
        //                     child: CachedNetworkImage(
        //                       width: 40,
        //                       height: 40,
        //                       imageUrl: master.image ?? '',
        //                       fit: BoxFit.cover,
        //                       placeholder: (_, __) {
        //                         return Container(
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                             color: AppColor.grey100,
        //                           ),
        //                           child: Icon(
        //                             Icons.person,
        //                             color: AppColor.black40.withOpacity(.3),
        //                             size: 16,
        //                           ),
        //                         );
        //                       },
        //                       errorWidget: (_, __, ___) {
        //                         return Container(
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                             color: AppColor.grey100,
        //                           ),
        //                           child: Icon(
        //                             Icons.person,
        //                             color: AppColor.black40.withOpacity(.3),
        //                             size: 16,
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: SizedBox(
        //                       height: 40,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           Padding(
        //                             padding: const EdgeInsets.only(left: 8),
        //                             child: Text(
        //                               "${master.name} ${master.surname}",
        //                               style: AppStyle.baseStyle.copyWith(fontWeight: FontWeight.w600, color: AppColor.black40),
        //                             ),
        //                           ),
        //                           if (master.rating > 0)
        //                             Padding(
        //                               padding: const EdgeInsets.only(left: 4),
        //                               child: Row(
        //                                 crossAxisAlignment: CrossAxisAlignment.start,
        //                                 children: [
        //                                   RatingBar.builder(
        //                                     initialRating: (master.rating ?? 0).toDouble(),
        //                                     minRating: 0,
        //                                     direction: Axis.horizontal,
        //                                     itemSize: 14,
        //                                     allowHalfRating: true,
        //                                     ignoreGestures: true,
        //                                     unratedColor: AppColor.grey50,
        //                                     itemCount: 5,
        //                                     itemPadding: EdgeInsets.only(right: 2),
        //                                     itemBuilder: (context, index) => SvgPicture.asset(
        //                                       "assets/svg/star.svg",
        //                                       color: AppColor.starColor,
        //                                     ),
        //                                     updateOnDrag: false,
        //                                     onRatingUpdate: (rating) {},
        //                                   ),
        //                                   SizedBox(
        //                                     width: 10,
        //                                   ),
        //                                   RichText(
        //                                     text: TextSpan(
        //                                         text: "${master.reviewsCount ?? 0} ",
        //                                         style: AppStyle.baseStyle.copyWith(
        //                                           fontWeight: FontWeight.w600,
        //                                           color: AppColor.black,
        //                                           fontSize: 12,
        //                                         ),
        //                                         children: [
        //                                           TextSpan(
        //                                             text: 'reviews'.tr,
        //                                             style: AppStyle.baseStyle.copyWith(
        //                                               fontWeight: FontWeight.w600,
        //                                               color: AppColor.grey60,
        //                                               fontSize: 10,
        //                                             ),
        //                                           ),
        //                                         ]
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               Text(
        //                 "master_rating".tr,
        //                 style: AppStyle.baseStyle.copyWith(
        //                   color: AppColor.black40,
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               RatingBar.builder(
        //                 initialRating: controller.ratingMaster,
        //                 minRating: 0,
        //                 direction: Axis.horizontal,
        //                 itemSize: 24,
        //                 unratedColor: AppColor.grey50,
        //                 allowHalfRating: true,
        //                 itemCount: 5,
        //                 itemPadding: EdgeInsets.only(right: 2),
        //                 itemBuilder: (context, index) => SvgPicture.asset(
        //                   "assets/svg/star.svg",
        //                   color: AppColor.starColor,
        //                 ),
        //                 updateOnDrag: true,
        //                 onRatingUpdate: (rating) {
        //                   controller.updateRatingMaster(rating);
        //                 },
        //               ),
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               CustomTextField(
        //                 maxLines: 10,
        //                 minLines: 4,
        //                 nextFocus: controller.priceNode,
        //                 currentFocus: controller.masterNode,
        //                 controller: controller.masterController,
        //                 context: context,
        //                 errorText: "error_input".tr,
        //                 showError: controller.masterError,
        //                 hintText: "add_comment_place".tr,
        //                 labelText: "comment".tr,
        //                 inputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.text,
        //               ),
        //               SizedBox(
        //                 height: 12,
        //               ),
        //               CustomPriceTextField(
        //                 maxLines: 1,
        //                 currentFocus: controller.priceNode,
        //                 controller: controller.priceController,
        //                 hintText: "service_cost".tr,
        //                 nextFocus: controller.appNode,
        //                 context: context,
        //                 errorText: "error_sum".tr,
        //                 labelText: "add_sum_master".tr,
        //                 inputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.number,
        //               ),
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               RatingBar.builder(
        //                 initialRating: controller.ratingApp,
        //                 minRating: 0,
        //                 direction: Axis.horizontal,
        //                 itemSize: 24,
        //                 allowHalfRating: true,
        //                 unratedColor: AppColor.grey50,
        //                 itemCount: 5,
        //                 itemPadding: EdgeInsets.only(right: 2),
        //                 itemBuilder: (context, index) => SvgPicture.asset(
        //                   "assets/svg/star.svg",
        //                   color: AppColor.starColor,
        //                 ),
        //                 updateOnDrag: true,
        //                 onRatingUpdate: (rating) {
        //                   controller.updateRatingApp(rating);
        //                 },
        //               ),
        //               SizedBox(
        //                 height: 24,
        //               ),
        //               CustomTextField(
        //                 maxLines: 10,
        //                 minLines: 4,
        //                 currentFocus: controller.appNode,
        //                 controller: controller.appController,
        //                 context: context,
        //                 errorText: "error_input".tr,
        //                 showError: controller.appError,
        //                 hintText: "how_better".tr,
        //                 labelText: "comment".tr,
        //                 inputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.text,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Positioned(
        //             left: 16,
        //             right: 16,
        //             bottom: 16,
        //             child: CustomButton(
        //               text: "send_feedback".tr,
        //               onTap: () {
        //                 controller.feedbackMaster();
        //               },
        //             ))
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
