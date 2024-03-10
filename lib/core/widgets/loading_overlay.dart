import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  final EdgeInsets progressIndicatorPadding;

  const LoadingOverlay({
    super.key,
    required this.child,
    this.alignment = Alignment.topCenter,
    this.progressIndicatorPadding = const EdgeInsets.only(top: 10),
  });

  @override
  Widget build(BuildContext context) => Stack(
        alignment: alignment,
        children: [
          ColoredBox(
            color: Colors.black.withOpacity(0.05),
            child: child,
          ),
          Padding(
            padding: progressIndicatorPadding,
            child: const CircularProgressIndicator(),
          ),
        ],
      );
}
