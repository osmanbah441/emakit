import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AppSuccessView extends StatelessWidget {
  final String title;
  final Widget content;

  final String actionLabel;
  final VoidCallback onAction;

  const AppSuccessView({
    super.key,
    required this.title,
    required this.content,
  required this.actionLabel, required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Success icon
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child:  Icon(Icons.check, size: 48, color: theme.colorScheme.onSecondaryContainer,),
              ),

              const SizedBox(height: 24),

              Text(title),

              const SizedBox(height: 12),

            

      

              content,

              const SizedBox(height: 48),

              PrimaryActionButton(label: actionLabel, onPressed: onAction ,),
            ],
          ),
        ),
      ),
    );
  }
}
