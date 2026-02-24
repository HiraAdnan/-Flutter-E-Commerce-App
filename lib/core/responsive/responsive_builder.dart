import 'package:flutter/material.dart';
import 'breakpoints.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
  });

  final Widget compact;
  final Widget? medium;
  final Widget? expanded;
  final Widget? large;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = getScreenSize(constraints.maxWidth);
        switch (size) {
          case ScreenSize.large:
            return large ?? expanded ?? medium ?? compact;
          case ScreenSize.expanded:
            return expanded ?? medium ?? compact;
          case ScreenSize.medium:
            return medium ?? compact;
          case ScreenSize.compact:
            return compact;
        }
      },
    );
  }
}
