import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/core/theme/theme.dart';
import 'package:automatize_app/feature/ui/controllers/client/client_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..displayDuration = const Duration(seconds: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Automatize Software',
      theme: MaterialTheme(createTextTheme(context)).light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: const Locale("pt", 'BR'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return EasyLoading.init(builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: phone, name: MOBILE),
              const Breakpoint(start: 451, end: tablet, name: TABLET),
              const Breakpoint(start: 769, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
        })(context, child);
      },
    );
  }
}
