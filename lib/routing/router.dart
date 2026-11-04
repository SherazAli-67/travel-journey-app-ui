import 'package:go_router/go_router.dart';
import 'package:travel_journey_app/presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state)=> WelcomeScreen())
  ],
);


enum NamedRoutes{
  welcome('/welcome');

  final String routeName;
  const NamedRoutes(this.routeName);
}