import 'package:flutter/material.dart';
import 'package:gamehub/features/home/presentation/pages/home_page.dart';
import 'package:gamehub/themes/app_text_style.dart';

class AppRoutes{
  static const home = '/home';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch(settings.name) {
      case home:
        return _pageRouteBuilder(page: const HomePage());
      default:
        return _pageRouteBuilder(
          page: Scaffold(
            body: Text(
              "No route defined for ${settings.name}",
              style: AppTypography.heading8.copyWith(color: const Color(0xFFE6E1E5)),
            ),
          )
        );
    }
  }

  static PageRouteBuilder<dynamic> _pageRouteBuilder({required Widget page}){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }
    );
  }
}