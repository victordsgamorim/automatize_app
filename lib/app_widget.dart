import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/core/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    );
  }
}
