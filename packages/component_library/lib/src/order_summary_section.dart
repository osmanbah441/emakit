import 'package:component_library/src/section_header_text.dart';
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final String subtotal;
  final String shippingCost;
  final String taxes;
  final String total;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    required this.shippingCost,
    required this.taxes,
    required this.total,
  });

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 16.0,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 16.0,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderText(title: 'Order Summary'),
          const SizedBox(height: 16.0),
          _buildSummaryRow('Subtotal', subtotal),
          _buildSummaryRow('Shipping', shippingCost),
          _buildSummaryRow('Taxes', taxes),
          const Divider(height: 24.0, thickness: 1.0, color: Color(0xFFE0E0E0)),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }
}
