import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/ui/pages/clients_page.dart';
import 'package:automatize_app/feature/ui/pages/home_page.dart';
import 'package:automatize_app/feature/ui/pages/new_client_page.dart';
import 'package:automatize_app/feature/ui/pages/products_page.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: ScaffoldNavigationPage(
              state: state, navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            NoTransitionGoRouter(
              name: RouteName.home,
              path: RoutePath.home,
              child: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            NoTransitionGoRouter(
              name: RouteName.clients,
              path: RoutePath.clients,
              child: (context, state) => const ClientsPage(),
              routes: [
                NoTransitionGoRouter(
                  name: RouteName.newClient,
                  path: RoutePath.newClient,
                  child: (context, state) => const NewClientPage(),
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            NoTransitionGoRouter(
                name: RouteName.products,
                path: RoutePath.products,
                child: (context, state) => const ProductsPage()),
          ],
        ),
      ],
    )
  ],
);

// GoRouter route = GoRouter(
//   initialLocation: RoutePath.init,
//   navigatorKey: _rootNavigatorKey,
//   routes: <RouteBase>[
//     StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) {
//         return DashboardPage(navigationShell: navigationShell);
//       },
//       branches: [
//         StatefulShellBranch(
//           routes: [
//             CupertinoTransitionGoRouter(
//                 path: RoutePath.init,
//                 builder: (_) => const BlastPage(),
//                 routes: [
//                   CupertinoTransitionGoRouter(
//                     path: RoutePath.registerBlast,
//                     builder: (_) => const RegisterBlastPage(),
//                   ),
//                   CupertinoTransitionGoRouter(
//                     path: RoutePath.dumper,
//                     builder: (state) => const DumperPage(),
//                     routes: [
//                       CupertinoTransitionGoRouter(
//                         path: RoutePath.management,
//                         builder: (state) => const ManagementPage(),
//                       )
//                     ],
//                   )
//                 ])
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorKey,
//           routes: [
//             CupertinoTransitionGoRouter(
//                 path: RoutePath.vehicle,
//                 builder: (_) => const VehiclePage(),
//                 routes: [
//                   CupertinoTransitionGoRouter(
//                     path: RoutePath.registerVehicle,
//                     builder: (state) => const RegisterVehiclePage(),
//                   )
//                 ])
//           ],
//         )
//       ],
//     )
//   ],
// );

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

class NoTransitionGoRouter extends GoRoute {
  NoTransitionGoRouter({
    super.name,
    required super.path,
    super.parentNavigatorKey,
    required Widget Function(BuildContext context, GoRouterState state) child,
    List<GoRoute> super.routes = const [],
  }) : super(
            pageBuilder: (context, state) =>
                NoTransitionPage(child: child(context, state)));
}
