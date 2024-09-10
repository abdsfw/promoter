import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constant/constant.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator(
      {super.key, this.color = AppColor.hBackgroundColor});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      size: 35,
      color: color,
    );
  }
}
