import 'package:flutter/material.dart';

class ListPageLoadingIndicator extends StatelessWidget {
  final double size;
  final bool isLoading;

  const ListPageLoadingIndicator({
    this.size = 30,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: FittedBox(child: CircularProgressIndicator()),
              )
            : const SizedBox.shrink(),
      );
}
