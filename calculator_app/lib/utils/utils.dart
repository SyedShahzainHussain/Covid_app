import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          icon: const Icon(
            Icons.info,
            color: Colors.red,
          ),
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(seconds: 5),
          borderRadius: BorderRadius.circular(10),
        )..show(context));
  }
}

class ShowMessage extends StatelessWidget {
  final String? message;
  const ShowMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.center,
        child: Flushbar(
          icon: const Icon(
            Icons.info,
            color: Colors.red,
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(seconds: 5),
          borderRadius: BorderRadius.circular(10),
        )..show(context),
      ),
    );
  }
}
