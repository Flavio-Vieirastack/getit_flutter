import 'package:flutter/material.dart';

T arguments<T extends Object>(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as T;
  return args;
}
