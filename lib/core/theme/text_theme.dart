import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/build_context_extension.dart';
import 'package:automatize_app/gen/assets.gen.dart';
import 'package:automatize_app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

const bodyFontString = FontFamily.lexend;
const displayFontString = FontFamily.lexend;

TextTheme createTextTheme(BuildContext context) {
  TextTheme baseTextTheme = context.textTheme;

  TextStyle? bodyLarge = baseTextTheme.bodyLarge?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 16.0,
  );

  TextStyle? bodyMedium = baseTextTheme.bodyMedium?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 14.0,
  );

  TextStyle? bodySmall = baseTextTheme.bodySmall?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 12.0,
  );

  TextStyle? labelLarge = baseTextTheme.labelLarge?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 14.0,
  );

  TextStyle? labelMedium = baseTextTheme.labelMedium?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 12.0,
  );

  TextStyle? labelSmall = baseTextTheme.labelSmall?.copyWith(
    fontFamily: bodyFontString,
    fontSize: 10.0,
  );

  TextTheme textTheme = baseTextTheme.copyWith(
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  return textTheme;
}
