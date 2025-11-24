import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:order_list/src/components/dialog.dart';
import 'package:order_list/src/components/order_card.dart';
import 'package:order_list/src/components/order_item_row.dart';
import 'package:order_repository/order_repository.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({
    super.key,
    required this.onOrderTap,
    required this.orderRepository,
  });

  final Function(String id) onOrderTap;
  final OrderRepository orderRepository;

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
      future: widget.orderRepository.getBuyerOrder(),
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
                  orderRepository: widget.orderRepository,
                ),
                OrderListView(
                  orders: completedOrders,
                  onOrderTap: widget.onOrderTap,
                  orderRepository: widget.orderRepository,
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
class OrderListView extends StatefulWidget {
  const OrderListView({
    super.key,
    required this.orders,
    required this.onOrderTap,
    required this.orderRepository,
  });
  final List<Order> orders;
  final OrderRepository orderRepository;

  final Function(String id) onOrderTap;

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  void updateStatus(String id, OrderItemStatus status) {
    widget.orderRepository.updateOrderItemStatus(id, status);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orders.isEmpty) {
      return Center(
        child: Text(
          'No orders found.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        final order = widget.orders[index];

        return OrderCard(
          customerName: order.id,
          itemCount: order.items.length,
          totalPrice: order.totalAmountPaid.toStringAsFixed(2),
          itemRows: order.items.map((e) {
            final hasAction =
                e.status == OrderItemStatus.pending ||
                e.status == OrderItemStatus.outForDelivery;

            return OrderItemRow(
              imageUrl: e.media.first.url,
              name: e.productName,
              price: e.priceAtPurchase.toStringAsFixed(2),
              qty: e.quantity,
              isStoreView: false,
              actions: hasAction
                  ? [
                      // 1. Thumb Down (Request Refund) Action Button
                      OrderActionButton(
                        icon: Icons.thumb_down,
                        color: Colors.redAccent,
                        onTap: () => CancelOrderDialog.show(
                          imageUrl: e.media.first.url,
                          context: context,
                          itemName: e.productName,
                          onConfirm: () =>
                              updateStatus(e.itemId, OrderItemStatus.rejected),
                        ),
                      ),

                      // 2. Thumb Up (Confirm Receipt & Release Funds) Action Button
                      OrderActionButton(
                        icon: Icons.thumb_up,
                        color: Colors.greenAccent,
                        onTap: () => ConfirmReceiptDialog.show(
                          imageUrl: e.media.first.url,
                          context: context,
                          itemName: e.productName,
                          onConfirm: () =>
                              updateStatus(e.itemId, OrderItemStatus.approved),
                        ),
                      ),
                    ]
                  : null,
              status: e.status,
            );
          }).toList(),

          details: Column(
            children: [
              TextRowComponent(
                label: 'subtotal',
                value: order.totalAmountPaid.toStringAsFixed(2),
              ),
            ],
          ),
        );
      },
    );
  }
}
