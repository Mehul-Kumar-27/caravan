import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Reset Password",
    content: "Link to reset your password is sent to your mail",
    optionBuilder: () => {
      "Ok": null,
    },
  );
}
