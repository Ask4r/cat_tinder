import 'package:flutter/material.dart';

import '../../theme.dart';
import '../assets/loading_indicator.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    return Padding(
      padding: EdgeInsets.only(top: variables.space(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: variables.space(8),
        children: [
          const LoadingIndicator(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 352),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: variables.space(2),
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: variables.text.textLg.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: variables.text.textSm.copyWith(
                    color: variables.colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
