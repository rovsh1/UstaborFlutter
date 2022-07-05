import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:usta_bor_android/controller/application_detail_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/ui/main/catalog/application_detail/widgets/info_tab.dart';
import 'package:usta_bor_android/ui/main/catalog/application_detail/widgets/project_tab.dart';
import 'package:usta_bor_android/ui/main/catalog/application_detail/widgets/review_tab.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/call_bottom_sheet.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_constants.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/recall_bottom_sheet.dart';

import '../widgets/login_bottom_sheet.dart';

class ApplicationDetailScreen extends StatefulWidget {
  final Catalog catalog;
  ApplicationDetailScreen({required this.catalog});

  @override
  _ApplicationDetailScreenState createState() => _ApplicationDetailScreenState();
}

class _ApplicationDetailScreenState extends State<ApplicationDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.put(ApplicationDetailController());
  var top = 0.0;

  bool fixedScroll = false;
  @override
  void initState() {
    controller.getMaster(id: widget.catalog.id ?? 0);
    _tabController = TabController(
      vsync: this,
      length: (widget.catalog.projects?.length ?? 0) > 0 && (widget.catalog.reviewsCount ?? 0) > 0
          ? 3
          : (widget.catalog.projects?.length ?? 0) > 0 || (widget.catalog.reviewsCount ?? 0) > 0
              ? 2
              : 1,
    );
    //print("AAAAA ${widget.catalog.preview!.length.toString()}");
    if(_tabController.length==1) {
      fixedScroll = ((widget.catalog.projects!.length<2&&widget.catalog.services!.length<3&&widget.catalog.categories!.length<8));
    }

    controller.scrollController.addListener(_scrollListener);
    _tabController.addListener(() {
    setState(() {
      controller.update();
    });
    });
    _tabController.addListener(_smoothScrollToTop);

    super.initState();
  }

  _scrollListener() {
    if (fixedScroll) {
      controller.scrollController.jumpTo(0);
    }
  }


  _smoothScrollToTop() {
    controller.scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      if(_tabController.index==0)
        {
          print("AAAAAA");

          fixedScroll = ((widget.catalog.projects!.length<2&&widget.catalog.services!.length<3&&widget.catalog.categories!.length<8));
          print("FIXED $fixedScroll");
        }
      if(_tabController.index==1) {
        fixedScroll = widget.catalog.reviewsCount!.toInt() < 5;

        print("FIXED $fixedScroll");
      }
      if(_tabController.index==2) {
        fixedScroll = widget.catalog.projects!.length < 2;
      }


    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationDetailController>(
      builder: (controller) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: controller.loading,
            color: Colors.transparent,
            child: controller.master != null
                ?
NestedScrollView(
  controller: controller.scrollController,
  physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isSlider) {
return [
SliverAppBar(
  leading: LeadingButton(),
  elevation: 0,
      backgroundColor: Colors.white,
   leadingWidth: 68,
    expandedHeight: 240,
  collapsedHeight: 150,
  pinned: true,
  flexibleSpace:
LayoutBuilder(builder:
    (BuildContext context, BoxConstraints constraints)
 {
  // print('constraints=' + constraints.biggest.height.toString());
   top = constraints.biggest.height;
   bool a = top>260;
   return
   Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       SizedBox(height: a?100:90),
       Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 16,
         ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(500),
               child: CachedNetworkImage(
                 imageUrl: widget.catalog.image ?? '',
                 width: top>260?64:50,
                 height: top>260?64:50,
                 fit: BoxFit.cover,
                 placeholder: (_, __) {
                   return Container(
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: AppColor.grey100,
                     ),
                     child: Icon(
                       Icons.person,
                       color: AppColor.black40.withOpacity(.3),
                       size: 16,
                     ),
                   );
                 },
                 errorWidget: (_, __, ___) {
                   return Container(
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: AppColor.grey100,
                     ),
                     child: Icon(
                       Icons.person,
                       color: AppColor.black40.withOpacity(.3),
                       size: 16,
                     ),
                   );
                 },
               ),
             ),
             SizedBox(width: 16),
             SizedBox(
               height: top>260?64:50,
                width:a?Get.width-120:140,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "${widget.catalog.presentation}",
                     maxLines: 1,
                     style: AppStyle.baseStyle.copyWith(
                       color: AppColor.black40,
                       fontSize: 14,
                     ),
                   ),
                   Row(
                     children: [
                       RatingBar.builder(
                         initialRating: (widget.catalog.rating ?? 1).toDouble(),
                         minRating: 1,
                         direction: Axis.horizontal,
                         itemSize: 14,
                         allowHalfRating: true,
                         ignoreGestures: true,
                         itemCount: 5,
                         itemPadding: EdgeInsets.only(right: 2),
                         updateOnDrag: false,
                        itemBuilder: (context, index) => SvgPicture.asset(
                           "assets/svg/star.svg",
                           color: AppColor.starColor,
                         ),
                         unratedColor: AppColor.grey50,
                         onRatingUpdate: (rating) {},
                       ),
                       SizedBox(
                         width: 6,
                       ),
                       RichText(
                         text: TextSpan(
                           text: "${widget.catalog.reviewsCount ?? 0} ",
                           style: AppStyle.baseStyle.copyWith(
                             fontWeight: FontWeight.w600,
                             color: AppColor.black,
                             fontSize: 12,
                           ),
                           children: [
                             TextSpan(
                               text: 'reviews'.tr,
                               style: AppStyle.baseStyle.copyWith(
                                 fontWeight: FontWeight.w600,
                                 color: AppColor.grey60,
                                 fontSize: 10,
                               ),
                             ),
                           ]
                         ),
                       ),
                     ],
                   ),
                   top >260?    Stack(
                     children: [
                       Align(
                         alignment: Alignment.centerLeft,
                         child: Wrap(
                           spacing: 8,
                           runSpacing: 4,
                           children: (widget.catalog.badges?.where((element) => element > 4 && element < 7).toList() ?? [])
                               .map(
                                 (element) => ClipRRect(
                                   borderRadius: BorderRadius.circular(4),
                                   child: Container(
                                     padding: EdgeInsets.symmetric(
                                       horizontal: 6,
                                       vertical: 2,
                                     ),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(4),
                                       color: AppConstants.getBadgeColor(element),
                                     ),
                                     child: Text(
                                       AppConstants.getBadgeName(element),
                                       style: AppStyle.baseStyle.copyWith(
                                         fontSize: 11,
                                         color: AppColor.white,
                                         fontWeight: FontWeight.w600,
                                       ),
                                     ),
                                   ),
                                 ),
                               )
                               .toList(),
                         ),
                       ),
                       Align(
                         alignment: Alignment.centerRight,
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             for (int element in (widget.catalog.badges?.where((element) => element > 0 && element < 4).toList() ?? []))
                               Container(
                                 height: 24,
                                 width: 24,
                                 padding: EdgeInsets.only(left: 0, right: 8, bottom: 8),
                                 child: SvgPicture.asset(
                                   AppConstants.applicationIcons[element-1],
                                   height: 16,
                                   width: 16,
                                 ),
                               ),
                           ],
                         ),
                       )
                     ],
                   ) : SizedBox(height: 0),
                 ],
               ),
             ),
           !a?Spacer():SizedBox(width: 0),
           !a?  Row(
             mainAxisAlignment : MainAxisAlignment.end,
             children: [
               InkWell(
                   onTap: () {
                     print("+++++++22222");
                     print(controller.master!.id);
                     print(controller.master!.url!);
                     // Share.share(controller.master!.url!);
                     final subdomain = LocalSource.sitedomains[controller.master!.siteId ?? 1];

                     Share.share('https://${subdomain}.${ApiConstants.url}/catalog/view/${controller.master!.id}/');

                   },
                   borderRadius: BorderRadius.circular(24),
                   child: Ink(
                     height: 48,
                     width: 48,
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(
                         color: AppColor.green,
                         width: 2,
                       ),
                     ),
                     child: SvgPicture.asset(
                       "assets/svg/download.svg",
                       width: 24,
                       height: 24,
                     ),
                   ),
                 ),
               SizedBox(width: 20),
               InkWell(
                 onTap: ()  async {



                   if (LocalSource.getInstance.hasAccount) {


                     var res = await controller.addMyMaster(
                         id: widget.catalog.id ?? 0,
                         categoryId: widget.catalog.categoryId.toString());
                     if(res){
                       final result = await Get.bottomSheet(
                         CallBottomSheet(
                           catalog: widget.catalog,
                         ),
                         isScrollControlled: true,
                       );
                       if (result == true) {
                         Get.bottomSheet(
                           ReCallBottomSheet(
                             catalog: widget.catalog,
                           ),
                           isScrollControlled: true,
                         );
                       }
                     }
                     else {
                       Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов".tr);
                     }

                   }

                   else if(widget.catalog.promotion!=null){
                     var mastersIds = LocalSource.getInstance.promotedMastersIds;


                       var res = await controller.addMyMaster(
                           id: widget.catalog.id ?? 0,
                           categoryId:mastersIds.contains(widget.catalog.id)?"": widget.catalog.categoryId.toString());
                       if(res){

                         if(!mastersIds.contains(widget.catalog.id)) {

                           mastersIds.add(widget.catalog.id!.toInt());
                           LocalSource.getInstance.setPromotedMasters(mastersIds);
                         }
                         final result = await Get.bottomSheet(
                           CallBottomSheet(
                             catalog: widget.catalog,
                           ),
                           isScrollControlled: true,
                         );
                         if (result == true) {
                           Get.bottomSheet(
                             ReCallBottomSheet(
                               catalog: widget.catalog,
                             ),
                             isScrollControlled: true,
                           );
                         }
                       }
                       else {
                         Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов".tr);
                       }

                   }


                   else {
                     await Get.bottomSheet(
                       LoginBottomSheet(),
                       isScrollControlled: true,
                     );

                   }                 },
                 borderRadius: BorderRadius.circular(24),
                 child: Ink(
                   height: 48,
                   width: 48,
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(24),
                   color: AppColor.green,
                   ),
                   child: SvgPicture.asset(
                     "assets/svg/call.svg",
                     width: 24,
                     height: 24,
                   ),
                 ),
               ),
               SizedBox(width: 5),
             ],
           ):SizedBox(width: 0),
           ],
         ),
       ),
       SizedBox(
          height:a? 24:0,
       ),
       a? Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 16,
         ),
         child: Row(
           children: [
               InkWell(
               onTap: () {
                 print("+++++++111111");
                 print(controller.master!.url!);
                 print(controller.master!.id);

                 // Share.share(controller.master!.url!);

                 final subdomain = LocalSource.sitedomains[controller.master!.siteId ?? 1];
                 Share.share('https://${subdomain}.${ApiConstants.url}/catalog/view/${controller.master!.id}/');

                 // Share.share('https://${subdomain}.${ApiConstants.url}/catalog/view/${controller.master!.id}/?category_id=${widget.catalog.id}');

                 // Share.share(controller.master?.url ?? 'https://www.${ApiConstants.url}/catalog/view/${widget.catalog.id}/?category_id=${widget.catalog.categoryId}&country_id=529&lang=${LocalSource.getInstance.locale}');
                 // Share.share('https://www.${ApiConstants.url}/catalog/view/${widget.catalog.id}/?category_id=${widget.catalog.categoryId}&country_id=529&lang=${LocalSource.getInstance.locale}');
               },
               borderRadius: BorderRadius.circular(8),
               child: Ink(
                 height: 48,
                 width: 48,
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(
                     color: AppColor.green,
                     width: 2,
                   ),
                 ),
                 child: SvgPicture.asset(
                   "assets/svg/download.svg",
                   width: 24,
                   height: 24,
                 ),
               ),
             ),
             SizedBox(
               width: 16,
             ),
             ElevatedButton.icon(
               style: ButtonStyle(
                 shadowColor:  MaterialStateProperty.all<Color>(
                   Colors.transparent
                 ),
                 minimumSize: MaterialStateProperty.all<Size>(
                   Size(Get.width - 96, 48),
                 ),
                 backgroundColor: MaterialStateProperty.all<Color>(
                   AppColor.green,
                 ),
                 alignment: Alignment.centerLeft,
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
               ),
               onPressed: () async {
                 if (LocalSource.getInstance.hasAccount) {
                   print("ADDD MY MASTER");
                   print("${widget.catalog.categoryId.toString()}");

                   var res = await controller.addMyMaster(
                       id: widget.catalog.id ?? 0,
                       categoryId: widget.catalog.categoryId.toString());
                   if(res){
                     print("REEE");
                     final result = await Get.bottomSheet(
                       CallBottomSheet(
                         catalog: widget.catalog,
                       ),
                       isScrollControlled: true,
                     );
                     if (result == true) {
                       Get.bottomSheet(
                         ReCallBottomSheet(
                           catalog: widget.catalog,
                         ),
                         isScrollControlled: true,
                       );
                     }
                   }
                   else {
                     Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов");
                   }

                 }

                 else if(widget.catalog.promotion!=null){
                   var mastersIds = LocalSource.getInstance.promotedMastersIds;


                     var res = await controller.addMyMaster(
                         id: widget.catalog.id ?? 0,
                         categoryId:mastersIds.contains(widget.catalog.id)?"": widget.catalog.categoryId.toString());
                   if(res){
                       if(!mastersIds.contains(widget.catalog.id)) {

                         mastersIds.add(widget.catalog.id!.toInt());
                         LocalSource.getInstance.setPromotedMasters(mastersIds);
                       }
                       final result = await Get.bottomSheet(
                         CallBottomSheet(
                           catalog: widget.catalog,
                         ),
                         isScrollControlled: true,
                       );
                       if (result == true) {
                         Get.bottomSheet(
                           ReCallBottomSheet(
                             catalog: widget.catalog,
                           ),
                           isScrollControlled: true,
                         );
                       }
                     }
                     else {
                       Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов".tr);
                     }

                 }


                 else {
                   await Get.bottomSheet(
                     LoginBottomSheet(),
                     isScrollControlled: true,
                   );

                 }
               },
               icon: SvgPicture.asset(
                 "assets/svg/call.svg",
                 width: 24,
                 height: 24,
               ),
               label: Container(
                 width: Get.width - 156,
                 padding: EdgeInsets.only(right: 32),
                 child: Center(
                   child: Text(
                     'master_contact'.tr,
                     textAlign: TextAlign.right,
                     style: AppStyle.baseStyle.copyWith(
                       color: Colors.white,
                       fontSize: 14,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ):SizedBox(height: 0),
       a? SizedBox(
         height:  24,
       ):Divider(thickness: 1),
]
   );
   },
),
),
SliverPersistentHeader(
  delegate: MyDelegate(
  TabBar(
    onTap: (index) {
      controller.update();
    },

    isScrollable: true,

controller: _tabController, tabs:
          List.generate(
                      _tabController.length,
                      (index) => Tab(
                        child: AnimatedContainer(
                          height: 36,
                          duration: Duration(milliseconds: 100),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: buildItem(
                              isActive: index == _tabController.index,
                              text: index == 1
          ? (widget.catalog.reviewsCount ?? 0) > 0
          ? "feedback".tr
              : "work_image".tr
              : index == 2
          ?"work_image".tr
              : "info".tr,
                              icon: index == 1
                                  ? (widget.catalog.reviewsCount ?? 0) > 0
                                  ?  "assets/svg/reviews.svg"
                                  :  "assets/svg/photos.svg"
                                  : index == 2
                                  ? "assets/svg/photos.svg"
                                  : "assets/svg/info.svg",
                              count: index == 1
                                  ? (widget.catalog.reviewsCount ?? 0) > 0
                                      ? "${(widget.catalog.reviewsCount ?? 0)}"
                                      : "${(widget.catalog.projects?.length ?? 0)}"
                                  : index == 2
                                      ? "${(widget.catalog.projects?.length ?? 0)}"
                                      : ""),
                        ),
                      ),
                    ),
  ),
),
  floating: true,
)
];
        },
  body: TabBarView(
controller: _tabController,
physics: const BouncingScrollPhysics(),
children: [
  InfoTab(
    onTap: () {
      if(widget.catalog.reviewsCount!=null&&(widget.catalog.reviewsCount ?? 0) > 0)
      _tabController.index = 2;
      else
        _tabController.index = 1;
    },
    master: controller.master!,
  ),
  if (widget.catalog.reviewsCount!=null&&(widget.catalog.reviewsCount ?? 0) > 0)
    ReviewTab(
      master: controller.master!,
    ),
  if ((widget.catalog.projects?.length ?? 0) > 0)
    ProjectTab(
      projects: widget.catalog.projects??[],
    ),
],
  ),
)

                : SizedBox(),
          ),
        );
      },
    );
  }

  Widget buildItem({
    required bool isActive,
    required String text,
    required String icon,
    required String count,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: isActive ? AppColor.green : AppColor.grey30,
        ),
        SizedBox(
          width: 8,
        ),
        Text(text,
            style: AppStyle.baseStyle.copyWith(
              fontSize: 14,
              color: isActive ? AppColor.green : AppColor.black40,
            )),
        if (count.isNotEmpty)
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColor.grey80,
              shape: BoxShape.circle,
            ),
            width: 24,
            height: 24,
            child: Center(
              child: Text(count,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                    color: AppColor.black40,
                  )),
            ),
          ),
      ],
    );
  }
}


class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        child: tabBar);
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
