import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui_screens/home_screen.dart';
import '../ui_screens/event_detail_screen.dart';
import '../ui_screens/sessions_screen.dart';
import '../ui_screens/speakers_screen.dart';
import '../ui_screens/sponsors_screen.dart';
import '../ui_screens/exhibitors_screen.dart';
import '../ui_screens/registration_screen.dart';
import '../widgets/portal_layout.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return PortalLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/sessions',
          builder: (context, state) => const SessionsScreen(),
        ),
        GoRoute(
          path: '/speakers',
          builder: (context, state) => const SpeakersScreen(),
        ),
        GoRoute(
          path: '/sponsors',
          builder: (context, state) => const SponsorsScreen(),
        ),
        GoRoute(
          path: '/exhibitors',
          builder: (context, state) => const ExhibitorsScreen(),
        ),
        GoRoute(
          path: '/events/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final isPastEvent = state.extra as bool? ?? false;
            return EventDetailScreen(eventId: id, isPastEvent: isPastEvent);
          },
        ),
        GoRoute(
          path: '/events/:id/register',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return RegistrationScreen(eventId: id);
          },
        ),
      ],
    ),
  ],
);
