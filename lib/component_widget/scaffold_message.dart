import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        backgroundColor: Colors.lightBlue,
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white, size: 20,),
            const VerticalDivider(width: 10,),
            Text(message)
          ],
        ),
        behavior: SnackBarBehavior.floating,
      )
  );
}