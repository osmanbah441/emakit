import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SellerSection extends StatelessWidget {
  const SellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SellerCallToActionCard.existingStore(onManageStoreTapped: () {});
  }
}
