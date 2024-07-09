import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/theme/theme.dart';
import 'package:automatize_app/core/theme/text_theme.dart';
import 'package:automatize_app/feature/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MaterialTheme(createTextTheme(context)).light(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
