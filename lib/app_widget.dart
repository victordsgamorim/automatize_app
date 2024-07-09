import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/core/theme/theme.dart';
import 'package:jiffy/jiffy.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Jiffy.setLocale('pt_br');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: MaterialTheme(createTextTheme(context)).light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
