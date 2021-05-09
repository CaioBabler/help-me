import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:intl/intl.dart';

final formatDate = new DateFormat('dd/MM/yyyy');
Flushbar showErrorToast(BuildContext context, String message, List<Color> cores,
    {String hit}) {
  return Flushbar(
    title: hit ?? 'Ops, algo deu errado.',
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      Icons.error,
      size: 28.0,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 7),
    backgroundGradient: LinearGradient(
      colors: cores,
    ),
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}
