import 'ch4.1go/HomePage.dart';
import 'ch4.1go/ProductGridViewPage.dart';
import 'ch4.1go/AboutPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(LinkPage());

final GoRouter _router = GoRouter(

  routes: <RouteBase>[

    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),

    GoRoute(
      path: '/product',
      builder: (BuildContext context, GoRouterState state) {
        return ProductGridViewPage();
      },
    ),

    GoRoute(
      path: '/about',
      builder: (BuildContext context, GoRouterState state) {
        return AboutPage();
      },
    ),
  ],

  // Optional: Define a page for 404 errors
  errorBuilder: (context, state) => const Text('404 - Page Not Found'),
);

class LinkPage extends StatelessWidget {

  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      // remove debugShowCheckedModeBanner: false for production
      // debugShowCheckedModeBanner: true,
    );
  }
}


