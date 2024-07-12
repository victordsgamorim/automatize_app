import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/gen/fonts.gen.dart';

const bodyFontString = FontFamily.lexend;
const displayFontString = FontFamily.lexend;

TextTheme createTextTheme(BuildContext context) {
  TextTheme baseTextTheme = context.textTheme;

  TextStyle? headlineSmall =
      baseTextTheme.headlineSmall?.copyWith(fontFamily: bodyFontString);

  TextStyle? headlineMedium =
      baseTextTheme.headlineMedium?.copyWith(fontFamily: bodyFontString);

  TextStyle? headlineLarge =
      baseTextTheme.headlineLarge?.copyWith(fontFamily: bodyFontString);

  TextStyle? titleLarge =
      baseTextTheme.titleLarge?.copyWith(fontFamily: bodyFontString);

  TextStyle? titleMedium =
      baseTextTheme.titleMedium?.copyWith(fontFamily: bodyFontString);

  TextStyle? titleSmall =
      baseTextTheme.titleSmall?.copyWith(fontFamily: bodyFontString);

  TextStyle? bodyLarge =
      baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFontString);

  TextStyle? bodyMedium =
      baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFontString);

  TextStyle? bodySmall =
      baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFontString);

  TextStyle? labelLarge =
      baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFontString);

  TextStyle? labelMedium =
      baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFontString);

  TextStyle? labelSmall =
      baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFontString);

  TextTheme textTheme = baseTextTheme.copyWith(
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    titleSmall: titleSmall,
    titleMedium: titleMedium,
    titleLarge: titleLarge,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
  );

  return textTheme;
}
