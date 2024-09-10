import 'package:flutter/material.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/styles.dart';

class CategoryCard extends StatelessWidget {
  final String pic;
  final String title;
  final Function() press;
  const CategoryCard({
    required this.pic,
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: AppColor.kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(
                    pic,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Styles.textStyle20,
                    // maxLines: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
