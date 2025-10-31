import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:order_repository/order_repository.dart';

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
  OrderDetailsCubit({required this.repository, required this.orderId})
    : super(OrderDetailsInitial());

  final OrderRepository repository;
  final String orderId;

  Future<void> fetchOrderDetails() async {
    emit(OrderDetailsLoading());
    try {
      final order = await repository.getOrderById(orderId);
      emit(OrderDetailsSuccess(order: order));
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
          OrderDetailsCubit(repository: OrderRepository.instance, orderId: id)
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
                      item.status == OrderStatus.delivered ||
                      item.status == OrderStatus.accepted,
                )
                .length;
            final totalItems = state.order.items.length;

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
                    // ...state.order.items.map(
                    //   (item) => OrderListItem(
                    //     imageUrl: item.variantSnapshot.imageUrls.first,
                    //     title: item.variantSnapshot.getDisplayName(
                    //       'product name',
                    //     ),
                    //     price: item.variantSnapshot.price,
                    //     quantity: item.quantity,
                    //     orderStatus: item.status,
                    //     onTap: () {},
                    //     onConfirmTapped: () {},
                    //     onChatTapped: () {},
                    //     onCancelTapped: () {},
                    //   ),
                    // );
                    OrderSummarySection(
                      subtotal: state.order.subtotal.toStringAsFixed(2),
                      shippingCost: state.order.shippingCost.toStringAsFixed(2),
                      taxes: state.order.taxAmount.toStringAsFixed(2),
                      total: state.order.total.toStringAsFixed(2),
                      orderId: id,
                      shippingAddress:
                          state.order.deliveryAddress.streetAddress,
                      date: state.order.getFormattedDate(),
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
