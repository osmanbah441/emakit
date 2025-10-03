// order_details/order_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:order_details/src/order_list_item.dart';
import 'package:equatable/equatable.dart';

// --- Data Models ---
class OrderItem extends Equatable {
  const OrderItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.orderStatus,
  });

  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final OrderStatus orderStatus;

  @override
  List<Object> get props => [imageUrl, title, price, quantity, orderStatus];
}

// --- Repository Pattern ---
class OrderDetailsRepository {
  Future<List<OrderItem>> fetchOrderItems(String orderId) async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 2));

    // Return a dummy list of items
    return [
      OrderItem(
        imageUrl: 'https://picsum.photos/id/101/200/200',
        title: 'Wireless Bluetooth Headphones',
        price: 89.50,
        quantity: 2,
        orderStatus: OrderStatus.pending,
      ),
      OrderItem(
        imageUrl: 'https://picsum.photos/id/101/200/200',
        title: 'Smartwatch',
        price: 199.99,
        quantity: 1,
        orderStatus: OrderStatus.inProcess,
      ),
      OrderItem(
        imageUrl: 'https://picsum.photos/id/101/200/200',
        title: 'Laptop Backpack',
        price: 45.00,
        quantity: 1,
        orderStatus: OrderStatus.delivered,
      ),
      OrderItem(
        imageUrl: 'https://picsum.photos/id/101/200/200',
        title: 'USB-C Cable',
        price: 12.50,
        quantity: 5,
        orderStatus: OrderStatus.accepted,
      ),
      OrderItem(
        imageUrl: 'https://picsum.photos/id/101/200/200',
        title: 'Portable Speaker',
        price: 75.00,
        quantity: 1,
        orderStatus: OrderStatus.rejected,
      ),
    ];
  }
}

// --- State Management: Cubit and State ---
abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccess extends OrderDetailsState {
  const OrderDetailsSuccess({required this.orderItems});

  final List<OrderItem> orderItems;

  @override
  List<Object> get props => [orderItems];
}

class OrderDetailsError extends OrderDetailsState {
  const OrderDetailsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({required this.repository, required this.orderId})
    : super(OrderDetailsInitial());

  final OrderDetailsRepository repository;
  final String orderId;

  Future<void> fetchOrderDetails() async {
    emit(OrderDetailsLoading());
    try {
      final items = await repository.fetchOrderItems(orderId);
      emit(OrderDetailsSuccess(orderItems: items));
    } catch (e) {
      emit(OrderDetailsError(message: e.toString()));
    }
  }
}

// --- UI: The Main Screen Widget ---
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderDetailsCubit(repository: OrderDetailsRepository(), orderId: id)
            ..fetchOrderDetails(),
      child: _OrderDetailsView(id: id),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  const _OrderDetailsView({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderDetailsSuccess) {
            final completedItems = state.orderItems
                .where(
                  (item) =>
                      item.orderStatus == OrderStatus.delivered ||
                      item.orderStatus == OrderStatus.accepted,
                )
                .length;
            final totalItems = state.orderItems.length;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 24,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '$completedItems of $totalItems items completed',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(8),
                            semanticsLabel: 'Progress',
                            value: totalItems > 0
                                ? completedItems / totalItems
                                : 0,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...state.orderItems.map(
                      (item) => OrderListItem(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        price: item.price,
                        quantity: item.quantity,
                        orderStatus: item.orderStatus,
                        onTap: () {},
                        onConfirmTapped: () {},
                        onChatTapped: () {},
                        onCancelTapped: () {},
                      ),
                    ),
                    OrderSummarySection(
                      subtotal: '35.00',
                      shippingCost: '5.00',
                      taxes: '0.89',
                      total: 'NLE.  43.89',
                      orderId: id,
                      shippingAddress: '123 Main St, Anytown USA',
                      date: DateTime.now().toString(),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is OrderDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
