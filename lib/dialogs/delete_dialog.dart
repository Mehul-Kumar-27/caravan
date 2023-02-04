import 'package:flutter/cupertino.dart';


import 'generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Delete",
    content: "Delete the note",
    optionBuilder: () => {
      "Cancel": false,
      "Yes": true,
    },
  ).then((value) => value ?? false);
}
