import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/gen/fonts.gen.dart';

/// | NAME           | SIZE |  WEIGHT |  SPACING |             |
/// |----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge     | 20.0 | medium  |  0.15    |             |
/// | titleMedium    | 16.0 | regular |  0.15    |             |
/// | titleSmall     | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     |             |
/// | bodyMedium     | 14.0 | regular |  0.25    |             |
/// | bodySmall      | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall     | 10.0 | regular |  1.5     |             |

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
