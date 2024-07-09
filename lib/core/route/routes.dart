import 'package:bloc_paten/screens/login/login_screen.dart';
import 'package:bloc_paten/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_paten/screens/home/home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MyHomePage(),
    ),
  ],
);
