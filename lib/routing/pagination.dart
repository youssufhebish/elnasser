import 'package:flutter/cupertino.dart';

class PageNavigation extends PageRouteBuilder {
  final Widget child;
  RouteSettings settings;
  PageNavigation({required this.child, required this.settings})
      : super(
            settings: settings,
            transitionDuration: Duration(milliseconds: 700),
            reverseTransitionDuration: Duration(milliseconds: 700),
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation = CurvedAnimation(
                  curve: Curves.easeInOutQuart,
                  parent: animation,
                  reverseCurve: Curves.fastLinearToSlowEaseIn);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation) {
              return child;
            });
}

class PageNavigationNoRout extends PageRouteBuilder {
  final Widget child;
  PageNavigationNoRout({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation = CurvedAnimation(
                  curve: Curves.easeInOutQuart,
                  parent: animation,
                  reverseCurve: Curves.fastLinearToSlowEaseIn);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation) {
              return child;
            });
}
