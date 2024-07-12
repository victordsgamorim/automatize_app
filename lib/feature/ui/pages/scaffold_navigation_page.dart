import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/ui/components/menu/menu.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';
import 'package:automatize_app/feature/ui/components/menu/side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../common_libs.dart';

class ScaffoldNavigationPage extends StatefulWidget {
  final GoRouterState state;
  final Widget child;

  const ScaffoldNavigationPage({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  State<ScaffoldNavigationPage> createState() => _ScaffoldNavigationPageState();
}

class _ScaffoldNavigationPageState extends State<ScaffoldNavigationPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width <= tablet;
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(context,
          defaultValue: width,
          conditionalValues: [
            const Condition.equals(name: MOBILE, value: phone),
            Condition.largerThan(breakpoint: phone.toInt(), value: width),
          ]).value,
      child: BouncingScrollWrapper.builder(
        context,
        Scaffold(
          appBar: isMobile
              ? AppBar(
                  centerTitle: false,
                  title: Text(
                    widget.state.topRoute?.name ?? "",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: context.colorScheme.onPrimary,
                )
              : null,
          drawer: isMobile
              ? Drawer(
                  backgroundColor: context.colorScheme.onPrimary,
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverMenu(menus: _menus..add(logoutMenu())),
                      )
                    ],
                  ),
                )
              : null,
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
                if (!isMobile) SideMenu(menus: _menus),
                Expanded(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widget.child,
                  )),
                )
              ],
            ),
          ),
        ),
        dragWithMouse: true,
      ),
    );
  }

  List<MenuItem> get _menus {
    return [
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
          title: "Criar OS", icon: FontAwesomeIcons.circlePlus, onTap: () {}),
      MenuItem(
          title: "Configurações", icon: FontAwesomeIcons.gear, onTap: () {}),
    ];
  }
}

MenuItem logoutMenu() {
  return MenuItem(title: "Sair", icon: Icons.logout_rounded, onTap: () {});
}
