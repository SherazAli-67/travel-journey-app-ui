import 'package:go_router/go_router.dart';
import 'package:travel_journey_app/presentation/screens/calendar_screen.dart';
import 'package:travel_journey_app/presentation/screens/home_screen.dart';
import 'package:travel_journey_app/presentation/screens/mic_screen.dart';
import 'package:travel_journey_app/presentation/screens/navigation_shell.dart';
import 'package:travel_journey_app/presentation/screens/settings_screen.dart';
import 'package:travel_journey_app/presentation/screens/welcome_screen.dart';
import 'package:travel_journey_app/presentation/screens/wishlist_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state) => const WelcomeScreen()),
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) => NavigationShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.calendar.routeName, builder: (ctx, state) => const CalendarScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.mic.routeName, builder: (ctx, state) => const MicScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.wishlist.routeName, builder: (ctx, state) => const WishlistScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.settings.routeName, builder: (ctx, state) => const SettingsScreen()),
          ],
        ),
      ],
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  calendar('/calendar'),
  mic('/mic'),
  wishlist('/wishlist'),
  settings('/settings');

  final String routeName;
  const NamedRoutes(this.routeName);
}
