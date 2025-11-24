import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:order_repository/order_repository.dart';

import '../components/order_list_item.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccess extends OrderDetailsState {
  const OrderDetailsSuccess({required this.order});

  final Order order;

  @override
  List<Object> get props => [order];
}

class OrderDetailsError extends OrderDetailsState {
  const OrderDetailsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({
    required OrderRepository orderRepository,
    required this.orderId,
  }) : _orderRepository = orderRepository,
       super(OrderDetailsInitial());

  final OrderRepository _orderRepository;
  final String orderId;

  void fetchOrderDetails() async {
    emit(OrderDetailsLoading());
    try {
      final order = await _orderRepository.getOrderById(orderId);
      emit(OrderDetailsSuccess(order: order));
    } catch (e) {
      emit(OrderDetailsError(message: e.toString()));
    }
  }

  void updateStatus(String id, OrderItemStatus s) async {
    await _orderRepository.updateOrderItemStatus(id, s);
    fetchOrderDetails();
  }
}

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.id,
    required this.orderRepository,
  });

  final String id;
  final OrderRepository orderRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderDetailsCubit(orderRepository: orderRepository, orderId: id)
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
    return Scaffold(
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderDetailsSuccess) {
            final completedItems = state.order.items
                .where(
                  (item) =>
                      item.status == OrderItemStatus.rejected ||
                      item.status == OrderItemStatus.approved,
                )
                .length;
            final totalItems = state.order.items.length;
            final cubit = context.read<OrderDetailsCubit>();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 24,
                  children: [
                    const SizedBox(height: 24),

                    OrderProgressIndicator(
                      completedItems: completedItems,
                      totalItems: totalItems,
                    ),
                    ...state.order.items.map(
                      (item) => OrderListItem(
                        imageUrl: item.media.first.url,
                        title: item.productName,
                        price: item.priceAtPurchase,
                        quantity: item.quantity,
                        itemStatus: item.status,
                        onTap: () {},
                        onConfirmTapped: () => cubit.updateStatus(
                          item.itemId,
                          OrderItemStatus.approved,
                        ),
                        onCancelTapped: () => cubit.updateStatus(
                          item.itemId,
                          OrderItemStatus.rejected,
                        ),
                      ),
                    ),
                    OrderSummarySection(
                      subtotal: state.order.totalAmountPaid.toStringAsFixed(2),

                      total: state.order.totalAmountPaid.toStringAsFixed(2),
                      orderId: id,

                      date: state.order.formattedCreateAt,
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
