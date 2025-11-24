import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final String customerName;
  final int itemCount;
  final String totalPrice;
  final List<Widget> itemRows;
  final Widget details;
  final bool isInitiallyExpanded;

  const OrderCard({
    super.key,
    required this.customerName,
    required this.itemCount,
    required this.totalPrice,
    required this.itemRows,
    required this.details,
    this.isInitiallyExpanded = false,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          _buildHeader(context),
          if (_isExpanded)
            Divider(height: 1, thickness: 1, color: colorScheme.background),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildExpandedContent(context),
            secondChild: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final headerRadius = _isExpanded
        ? const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )
        : BorderRadius.circular(16.0);

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      borderRadius: headerRadius,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.customerName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.itemCount} Items',
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' | ',
                          style: TextStyle(
                            color: colorScheme.onSecondary.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Total: ',
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.totalPrice,
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: colorScheme.primary,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.itemRows.map((itemRow) => itemRow),

          Divider(height: 1, thickness: 1),

          const SizedBox(height: 16),
          widget.details,
        ],
      ),
    );
  }
}
