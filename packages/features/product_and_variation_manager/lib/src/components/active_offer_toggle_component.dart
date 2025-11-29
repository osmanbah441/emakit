import 'package:flutter/material.dart';

class ActiveOfferToggleComponent extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ActiveOfferToggleComponent({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Activate Offer', style: Theme.of(context).textTheme.bodyLarge),
          Switch(value: isActive, onChanged: onChanged),
        ],
      ),
    );
  }
}
