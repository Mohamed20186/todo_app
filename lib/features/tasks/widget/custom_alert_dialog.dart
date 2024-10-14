import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAlertdialog extends StatelessWidget {
  CustomAlertdialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 134, 131, 131),
      content: Text(
        "delete_confirmation".tr(), // Localized text
        style: theme.textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "cancel".tr(), // Localized text
            style: theme.textTheme.bodyMedium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "delete".tr(), // Localized text
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
