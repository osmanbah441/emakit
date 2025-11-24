import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:order_repository/order_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:collection/collection.dart';

import 'components/order_item_row.dart';
import 'components/order_card.dart';

enum OrderFilter { pending, outForDelivery, grouped, completed, rejected }

class StoreOrderListScreen extends StatefulWidget {
  final Function(String id) onOrderTap;
  final OrderRepository orderRepository;

  const StoreOrderListScreen({
    super.key,
    required this.onOrderTap,
    required this.orderRepository,
  });

  @override
  State<StoreOrderListScreen> createState() => _StoreOrderListScreenState();
}

class _StoreOrderListScreenState extends State<StoreOrderListScreen> {
  // Set default to 'pending' to match original filter availability
  OrderFilter _currentFilter = OrderFilter.pending;
  List<StoreOrderItemFulfillment> _allOrders = [];
  late Future<List<StoreOrderItemFulfillment>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
  }

  Future<List<StoreOrderItemFulfillment>> _fetchOrders() async {
    return widget.orderRepository.getStoreOrders();
  }

  void _refreshData() {
    setState(() {
      _ordersFuture = _fetchOrders();
    });
  }

  Map<String, List<StoreOrderItemFulfillment>> _groupOrdersByUserId(
    List<StoreOrderItemFulfillment> orders,
  ) {
    return groupBy(orders, (item) => item.userId);
  }

  List<StoreOrderItemFulfillment> _getFilteredData() {
    List<OrderItemStatus> statuses;

    switch (_currentFilter) {
      case OrderFilter.pending:
        statuses = [OrderItemStatus.pending];
        break;
      case OrderFilter.outForDelivery:
        statuses = [OrderItemStatus.outForDelivery];
        break;
      case OrderFilter.completed:
        statuses = [OrderItemStatus.approved];
        break;
      case OrderFilter.rejected:
        statuses = [OrderItemStatus.rejected];
        break;
      case OrderFilter.grouped:
        statuses = [OrderItemStatus.pending, OrderItemStatus.outForDelivery];
        break;
    }

    return _allOrders
        .where((item) => statuses.contains(item.orderItemStatus))
        .toList();
  }

  Future<void> _updateOrderItemStatus(
    String orderItemId,
    OrderItemStatus newStatus,
  ) async {
    try {
      await widget.orderRepository.updateOrderItemStatus(
        orderItemId,
        newStatus,
      );

      _refreshData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order Item status updated to ${newStatus.name}. Refreshing data...',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update status: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // REVERTED: Original _buildFilterChips implementation
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8.0,
          children: OrderFilter.values
              .map((filter) {
                String label;
                switch (filter) {
                  case OrderFilter.pending:
                    label = 'Pending';
                    break;
                  case OrderFilter.outForDelivery:
                    label = 'Out for Delivery';
                    break;
                  case OrderFilter.completed:
                    label = 'Completed';
                    break;
                  case OrderFilter.rejected:
                    label = 'Rejected';
                    break;
                  case OrderFilter.grouped:
                    // This is the key change: Hiding the 'grouped' chip
                    return const SizedBox.shrink();
                }

                return FilterChip(
                  label: Text(label),
                  selected: _currentFilter == filter,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _currentFilter = filter;
                      });
                    }
                  },
                );
              })
              .where((widget) => widget is! SizedBox)
              .toList(),
        ),
      ),
    );
  }

  Widget _buildGroupedList(List<StoreOrderItemFulfillment> filteredData) {
    final Map<String, List<StoreOrderItemFulfillment>> groupedOrders =
        _groupOrdersByUserId(filteredData);
    final List<MapEntry<String, List<StoreOrderItemFulfillment>>>
    userOrderGroups = groupedOrders.entries.toList();

    return ListView.builder(
      itemCount: userOrderGroups.length,
      itemBuilder: (context, index) {
        final List<StoreOrderItemFulfillment> itemsForUser =
            userOrderGroups[index].value;
        final StoreOrderItemFulfillment firstItem = itemsForUser.first;

        final double totalOrderPrice = itemsForUser.fold(
          0.0,
          (sum, item) => sum + item.itemSubtotal,
        );

        final List<OrderItemRow> itemRows = itemsForUser.map((item) {
          final status = item.orderItemStatus;
          final String imageUrl = item.media.url;
          final bool canAct = item.orderItemStatus == OrderItemStatus.pending;

          return OrderItemRow(
            imageUrl: imageUrl,
            name: item.productName,
            price: item.priceAtPurchase.toStringAsFixed(2),
            qty: item.quantity,
            status: status,
            isStoreView: true,
            // Now passing a list of 'actions'
            actions: canAct
                ? [
                    OrderActionButton(
                      icon: Icons.local_shipping_outlined,
                      color: Colors
                          .orange, // Use a distinguishing color for 'Delivery'
                      onTap: () {
                        // Use item.id or item.orderItemId, depending on your domain model
                        _updateOrderItemStatus(
                          item.orderItemId,
                          OrderItemStatus.outForDelivery,
                        );
                      },
                    ),
                  ]
                : null,
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: OrderCard(
            isInitiallyExpanded: index == 0,
            customerName: firstItem.buyerFullName,
            itemCount: itemsForUser.length,
            totalPrice: totalOrderPrice.toStringAsFixed(2),
            details: Text(
              firstItem.deliveryPhoneNumber,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            itemRows: itemRows,
          ),
        );
      },
    );
  }

  Widget _buildIndividualList(List<StoreOrderItemFulfillment> filteredData) {
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        final status = item.orderItemStatus;
        final String imageUrl = item.media.url;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: OrderItemRow(
            imageUrl: imageUrl,
            name: item.productName,
            price: item.priceAtPurchase.toStringAsFixed(2),
            qty: item.quantity,
            status: status,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: FutureBuilder<List<StoreOrderItemFulfillment>>(
              future: _ordersFuture,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState != ConnectionState.done) {
                  return const CenteredProgressIndicator();
                }

                if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                }

                _allOrders = asyncSnapshot.data ?? [];
                if (_allOrders.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }

                final List<StoreOrderItemFulfillment> filteredData =
                    _getFilteredData();

                if (filteredData.isEmpty) {
                  final filterName = _currentFilter.toString().split('.').last;
                  return Center(child: Text('No $filterName orders found.'));
                }

                // Logic based on original file structure: Completed/Rejected are individual lists.
                // Pending/Out for Delivery will use the Grouped/Card view logic.
                if (_currentFilter == OrderFilter.completed ||
                    _currentFilter == OrderFilter.rejected) {
                  return _buildIndividualList(filteredData);
                } else {
                  return _buildGroupedList(filteredData);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
