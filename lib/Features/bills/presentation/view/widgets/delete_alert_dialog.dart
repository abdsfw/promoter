import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: icon,
      content: Text(title),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            S.of(context).ok,
          ),
        ),
      ],
    );
  }
}
