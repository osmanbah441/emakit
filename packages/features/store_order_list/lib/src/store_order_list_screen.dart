import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required this.onOrderTap});

  final Function(String id) onOrderTap;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // final List<Order> allOrders = [
  //   Order(
  //     id: '1001',
  //     date: DateTime(2025, 8, 04),
  //     total: 75.50,
  //     totalItems: 10,
  //     completedItems: 7,
  //   ),
  //   Order(
  //     id: '1002',
  //     date: DateTime(2025, 7, 28),
  //     total: 120.00,
  //     totalItems: 5,
  //     completedItems: 5,
  //   ),
  //   Order(
  //     id: '1003',
  //     date: DateTime(2025, 8, 1),
  //     total: 45.20,
  //     totalItems: 1,
  //     completedItems: 0,
  //   ),
  // ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // List<Order> get completedOrders =>
  //     allOrders.where((o) => o.completedItems == o.totalItems).toList();

  // List<Order> get uncompletedOrders =>
  //     allOrders.where((o) => o.completedItems != o.totalItems).toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My orders'),
          centerTitle: false,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            tabs: const [
              Tab(text: 'Uncompleted'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: Center(
          child: Text(
            'Order list functionality is currently disabled.',
            style: theme.textTheme.bodyLarge,
          ),
        ),
        // body: TabBarView(
        //   controller: _tabController,
        //   children: [
        //     OrderListView(
        //       orders: uncompletedOrders,
        //       onOrderTap: widget.onOrderTap,
        //     ),
        //     OrderListView(
        //       orders: completedOrders,
        //       onOrderTap: widget.onOrderTap,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

@visibleForTesting
class OrderListView extends StatelessWidget {
  const OrderListView({
    super.key,
    required this.orders,
    required this.onOrderTap,
  });
  final List<Order> orders;

  final Function(String id) onOrderTap;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders found.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Placeholder();
        // return OrderListCard(
        //   totalItems: order.totalItems,
        //   completedItems: order.completedItems,
        //   onTap: () => onOrderTap(order.id),
        //   orderId: order.id,
        //   formattedDate: order.getFormattedDate(),
        //   amount: 'NLE ${order.total.toStringAsFixed(2)}',
        // );
      },
    );
  }
}
