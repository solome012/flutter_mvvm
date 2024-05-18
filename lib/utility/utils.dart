import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushBarErrorMessage(
    String message,
    BuildContext context,
  ) {
    Flushbar(
      message: message,
      messageColor: Colors.white,
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(Icons.error_outline, color: Colors.amber),
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
