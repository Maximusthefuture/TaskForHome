import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {

  final Widget child;
  
  CustomPageRoute(this.child): super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              ),
        );

  // @override
  // Color? get barrierColor => Colors.black;

  // @override
  
  // String? get barrierLabel => '';

  // @override
  // Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    
  //   // return FadeTransition(opacity: animation, child: child);
  //   // return DecoratedBoxTransition(decoration: decoration, child: child)
  //   AlignTransition(alignment: alignment, child: child)
  //   // return SlideTransition(position: position)
  // }

  // @override
  
  // bool get maintainState => true;

  // @override
  
  // Duration get transitionDuration => Duration(seconds: 1);

}