import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:order_repository/order_repository.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required this.onOrderTap});

  final Function(String id) onOrderTap;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: OrderRepository.instance.getOrdersForUser(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }

        final orders = asyncSnapshot.data ?? [];

        final completedOrders = orders
            .where((o) => o.completedItemsCount == o.totalItemsCount)
            .toList();
        final uncompletedOrders = orders
            .where((o) => o.completedItemsCount != o.totalItemsCount)
            .toList();

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
            body: TabBarView(
              controller: _tabController,
              children: [
                OrderListView(
                  orders: uncompletedOrders,
                  onOrderTap: widget.onOrderTap,
                ),
                OrderListView(
                  orders: completedOrders,
                  onOrderTap: widget.onOrderTap,
                ),
              ],
            ),
          ),
        );
      },
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
        return OrderListCard(
          totalItems: order.totalItemsCount,
          completedItems: order.completedItemsCount,
          onTap: () => onOrderTap(order.id),
          orderId: order.id,
          formattedDate: order.getFormattedDate(),
          amount: 'NLE ${order.total.toStringAsFixed(2)}',
        );
      },
    );
  }
}
