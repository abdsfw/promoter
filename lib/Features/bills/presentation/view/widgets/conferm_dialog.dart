import 'package:flutter/material.dart';
import 'package:promoter/core/utils/styles.dart';

import '../../../../../generated/l10n.dart';

class ConfermDialog extends StatelessWidget {
  const ConfermDialog({
    super.key,
    required this.title,
    this.onPressed,
    this.isAlert = false,
  });
  final String title;
  final void Function()? onPressed;
  final bool isAlert;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Styles.textStyle18,
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        (isAlert)
            ? const SizedBox()
            : ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  // 'ok',
                  S.of(context).ok,
                  style: Styles.textStyle14,
                ),
              ),
        (isAlert)
            ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  // 'ok',
                  S.of(context).ok,
                  style: Styles.textStyle14,
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  // 'cancel',
                  S.of(context).cancel,
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
      ],
    );
  }
}
