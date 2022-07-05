import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;
  final bool isScanPage;

  ModalProgressHUD({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.black,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
    this.isScanPage = false,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null)
        layOutProgressIndicator = Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness:
                          isScanPage ? Brightness.dark : Brightness.light,
                    ),
                  ),
                  child:
                      CupertinoActivityIndicator(radius: 20, animating: true),
                ),
        );
      else {
        layOutProgressIndicator = Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator(backgroundColor: Colors.transparent,)
              : CupertinoActivityIndicator(radius: 20, animating: true),
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
