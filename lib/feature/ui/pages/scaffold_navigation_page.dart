import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/menu/menu.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';
import 'package:automatize_app/feature/ui/components/menu/side_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../common_libs.dart';

class ScaffoldNavigationPage extends StatefulWidget {
  final GoRouterState state;
  final StatefulNavigationShell navigationShell;

  const ScaffoldNavigationPage({
    super.key,
    required this.state,
    required this.navigationShell,
  });

  @override
  State<ScaffoldNavigationPage> createState() => _ScaffoldNavigationPageState();
}

class _ScaffoldNavigationPageState extends State<ScaffoldNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showMobileLayout = isMobile(context);
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
          appBar: showMobileLayout
              ? AppBar(
                  centerTitle: false,
                  title: Text(widget.state.topRoute?.name ?? ""),
                  backgroundColor: context.colorScheme.onPrimary,
                )
              : null,
          drawer: showMobileLayout
              ? Drawer(
                  backgroundColor: context.colorScheme.onPrimary,
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverMenu(
                          index: _currentIndex,
                          menus: _menus..add(logoutMenu()),
                          onChanged: _onChanged,
                        ),
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
                if (!showMobileLayout)
                  SideMenu(
                    index: _currentIndex,
                    menus: _menus,
                    onChanged: _onChanged,
                  ),
                Expanded(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(
                        _currentIndex == 1 || _currentIndex == 2 ? 0 : 16),
                    child: widget.navigationShell,
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

  _onChanged(int index) {
    if (index == 5) return;
    _currentIndex = index;
  }

  void _onTap(int index) {
    final bool isSamePage = index == widget.navigationShell.currentIndex;
    if (isSamePage) return;
    widget.navigationShell.goBranch(index, initialLocation: isSamePage);
    if (isMobile(context)) {
      Future.delayed(const Duration(milliseconds: 85), () {
        context.pop();
      });
    }
  }

  List<MenuItem> get _menus {
    return [
      MenuItem(
        title: "Início",
        icon: FontAwesomeIcons.house,
        onTap: () => _onTap(0),
      ),
      MenuItem(
          title: "Clientes",
          icon: FontAwesomeIcons.users,
          onTap: () => _onTap(1)),
      MenuItem(
          title: "Produtos",
          icon: FontAwesomeIcons.boxesStacked,
          onTap: () => _onTap(2)),
      MenuItem(
        title: "Criar OS",
        icon: FontAwesomeIcons.circlePlus,
        onTap: () => _onTap(3),
      ),
      MenuItem(
          title: "Configurações", icon: FontAwesomeIcons.gear, onTap: () {}),
    ];
  }
}

MenuItem logoutMenu() {
  return MenuItem(title: "Sair", icon: Icons.logout_rounded, onTap: () {});
}

bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width <= tablet;

List<Widget> dividedHeader(String title) {
  return [
    AutomatizeHeader(label: title),
    const AutomatizeDivider(),
  ];
}
