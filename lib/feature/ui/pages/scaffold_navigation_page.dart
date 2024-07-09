import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';
import 'package:automatize_app/feature/ui/components/menu/side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../common_libs.dart';

class ScaffoldNavigationPage extends StatefulWidget {
  final Widget child;

  const ScaffoldNavigationPage({super.key, required this.child});

  @override
  State<ScaffoldNavigationPage> createState() => _ScaffoldNavigationPageState();
}

class _ScaffoldNavigationPageState extends State<ScaffoldNavigationPage> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              context.colorScheme.onPrimary,
              const Color(0xffD6E3FF).withOpacity(.5)
            ])),
        child: Row(
          children: [
            SideMenu(
              menus: [
                MenuItem(
                  title: "Início",
                  icon: FontAwesomeIcons.house,
                  onTap: () => context.go(R.home),
                ),
                MenuItem(
                    title: "Clientes",
                    icon: FontAwesomeIcons.users,
                    onTap: () => context.go(R.clients)),
                MenuItem(
                    title: "Produtos",
                    icon: FontAwesomeIcons.boxesStacked,
                    onTap: () => context.go(R.products)),
                MenuItem(
                    title: "Criar OS",
                    icon: FontAwesomeIcons.circlePlus,
                    onTap: () {}),
                MenuItem(
                    title: "Configurações",
                    icon: FontAwesomeIcons.gear,
                    onTap: () {}),
              ],
            ),
            Expanded(
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: widget.child,
              )),
            )
          ],
        ),
      ),
    );
  }
}
