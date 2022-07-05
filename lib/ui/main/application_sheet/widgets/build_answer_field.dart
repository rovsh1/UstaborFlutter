import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class BuildAnswerField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (value) => Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                value.currentService.question ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.black40,
                ),
              ),
              SizedBox(height: 8),
              ExpandableNotifier(
                controller: value.controllerAnswer,
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          value.toggleAnswer();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Ink(
                          height: 44,
                          padding: EdgeInsets.only(left: 14, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey30, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width - 80,
                                child: Text(
                                  value.currentAnswer.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.baseStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 30,
                                color: AppColor.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expandable(
                      collapsed: SizedBox(),
                      controller: value.controllerAnswer,
                      expanded: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8),
                        height: value.answer.length * 40 + 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: AppColor.grey30, width: 1),
                        ),
                        child: Column(
                          children: [
                            for (int index = 0; index < value.answer.length; index++)
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    value.setAnswer(value.answer[index]);
                                  },
                                  child: Ink(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      height: 40,
                                      width: Get.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          value.answer[index].name ?? '',
                                          maxLines: 2,
                                          style: AppStyle.baseStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          for (int index = 0; index < value.answers.length; index++)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  value.answers.keys.elementAt(index).question ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.baseStyle.copyWith(
                    color: AppColor.black40,
                  ),
                ),
                SizedBox(height: 8),
                ExpandableNotifier(
                  controller: value.answersExpendableController[index],
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            value.toggleAnswers(index);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Ink(
                            height: 44,
                            padding: EdgeInsets.only(left: 14, right: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.grey30, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width - 80,
                                  child: Text(
                                    value.currentAnswers[index].name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.baseStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 30,
                                  color: AppColor.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expandable(
                        collapsed: SizedBox(),
                        controller: value.answersExpendableController[index],
                        expanded: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          height: value.answers.values.elementAt(index).length * 40 + 2,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: AppColor.grey30, width: 1),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0; i < value.answers.values.elementAt(index).length; i++)
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      value.setAnswers(value.answers.values.elementAt(index)[i], index);
                                    },
                                    child: Ink(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        height: 40,
                                        width: Get.width,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            value.answers.values.elementAt(index)[i].name ?? '',
                                            maxLines: 2,
                                            style: AppStyle.baseStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
