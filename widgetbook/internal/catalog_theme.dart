import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter/material.dart';

Widget buildCatalogTheme({required bool dark, required Widget child}) => Theme(
  data: appTheme(
    variables: UiVariables(colors: UiColors(dark: dark)),
  ),
  child: Material(child: child),
);
