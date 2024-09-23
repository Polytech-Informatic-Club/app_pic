import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ScaffoldFeatureController alerteMessageWidget(
    BuildContext context, String message, Color color) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
}
