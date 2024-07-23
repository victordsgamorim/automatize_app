import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/core/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: MaterialTheme(createTextTheme(context)).light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: const Locale("pt", 'BR'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: phone, name: MOBILE),
          const Breakpoint(start: 451, end: tablet, name: TABLET),
          const Breakpoint(start: 769, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
