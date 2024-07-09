import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
