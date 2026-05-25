import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_string.dart';
import 'color.dart';
import 'responsive_layout.dart';

class PortalLayout extends StatelessWidget {
  final Widget child;

  const PortalLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.background, body: child);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return AppBar(
      title: InkWell(
        onTap: () => context.go('/'),
        child: const Text(AppString.appName),
      ),
      backgroundColor: AppColor.background,
      foregroundColor: AppColor.white,
      actions: [
        if (isDesktop) ...[
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Home', style: TextStyle(color: AppColor.white)),
          ),
          TextButton(
            onPressed: () => context.go('/sessions'),
            child: const Text(
              'Agenda',
              style: TextStyle(color: AppColor.white),
            ),
          ),
          TextButton(
            onPressed: () => context.go('/speakers'),
            child: const Text(
              'Speakers',
              style: TextStyle(color: AppColor.white),
            ),
          ),
          TextButton(
            onPressed: () => context.go('/sponsors'),
            child: const Text(
              'Sponsors',
              style: TextStyle(color: AppColor.white),
            ),
          ),
          TextButton(
            onPressed: () => context.go('/exhibitors'),
            child: const Text(
              'Exhibitors',
              style: TextStyle(color: AppColor.white),
            ),
          ),
          const SizedBox(width: 16),
        ],
        TextButton(
          onPressed: () {},
          child: const Text(
            AppString.login,
            style: TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primary),
            child: const Text(
              AppString.appName,
              style: TextStyle(color: AppColor.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            title: const Text('Agenda'),
            onTap: () {
              Navigator.pop(context);
              context.go('/sessions');
            },
          ),
          ListTile(
            title: const Text('Speakers'),
            onTap: () {
              Navigator.pop(context);
              context.go('/speakers');
            },
          ),
          ListTile(
            title: const Text('Sponsors'),
            onTap: () {
              Navigator.pop(context);
              context.go('/sponsors');
            },
          ),
          ListTile(
            title: const Text('Exhibitors'),
            onTap: () {
              Navigator.pop(context);
              context.go('/exhibitors');
            },
          ),
        ],
      ),
    );
  }
}
