import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';


Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Log Out",
    content: "Sure you want to logout",
    optionBuilder: () => {
      "No": false,
      "Yes": true,
    },
  ).then((value) => value ?? false);
}
