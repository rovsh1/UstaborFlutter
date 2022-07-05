import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? searchController;

  CustomSearchBar({
    Key? key,
    this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10.0),
                hintText: 'search_something'.tr,
                hintStyle:TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.3),
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            //onTap: onSearchRe,
            child: Container(height: 40, width: 40, padding: const EdgeInsets.only(right: 10.0), child: SvgPicture.asset('assets/svg/search.svg')),
          ),
        ],
      ),
    );
  }
}
