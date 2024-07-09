import 'package:automatize_app/feature/ui/components/body.dart';
import 'package:automatize_app/feature/ui/components/side_menu.dart';

import '../../../common_libs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SideMenu(),

          ],
        ),
      ),
    );
  }
}
