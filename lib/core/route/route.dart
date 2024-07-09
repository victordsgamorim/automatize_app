import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/ui/pages/clients_page.dart';
import 'package:automatize_app/feature/ui/pages/home_page.dart';
import 'package:automatize_app/feature/ui/pages/products_page.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: ScaffoldNavigationPage(child: child));
      },
      routes: [
        FadeTranslationTransitionGoRouter(
            parentNavigatorKey: _shellNavigatorKey,
            path: RoutePath.home,
            child: (context, state) => const HomePage()),
        FadeTranslationTransitionGoRouter(
            parentNavigatorKey: _shellNavigatorKey,
            path: RoutePath.clients,
            child: (context, state) => const ClientsPage()),
        FadeTranslationTransitionGoRouter(
            parentNavigatorKey: _shellNavigatorKey,
            path: RoutePath.products,
            child: (context, state) => const ProductsPage()),
      ],
    )
  ],
);

class FadeTranslationTransitionGoRouter extends GoRoute {
  FadeTranslationTransitionGoRouter({
    super.name,
    required super.path,
    required super.parentNavigatorKey,
    required Widget Function(BuildContext context, GoRouterState state) child,
    Duration duration = const Duration(milliseconds: 750),
    List<GoRoute> super.routes = const [],
  }) : super(
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: child(context, state),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, -0.1);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var opacityTween = Tween<double>(begin: 0.0, end: 1.0);

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: FadeTransition(
                        opacity: animation.drive(opacityTween),
                        child: child,
                      ),
                    );
                  },
                ));
}
