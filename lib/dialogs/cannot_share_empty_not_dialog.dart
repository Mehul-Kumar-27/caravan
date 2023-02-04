import 'package:flutter/material.dart';

import 'generic_dialog.dart';


Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: "Sharing",
    content: "Cannot share empty notes",
    optionBuilder: () => {
      "Ok": null,
    },
  );
}
