import 'package:domain_models/domain_models.dart';

abstract class OrderException implements Exception {
  final String message;
  const OrderException(this.message);

  @override
  String toString() => 'OrderException: $message';
}

class OrderNotFoundException extends OrderException {
  const OrderNotFoundException(String orderId)
    : super('Order with ID "$orderId" was not found.');
}

class InvalidOrderException extends OrderException {
  const InvalidOrderException(String message)
    : super('Invalid order: $message');
}

abstract class OrderRepository {
  const OrderRepository._();

  static OrderRepository instance = MockOrderRepository.instance;

  // Methods defining the contract
  Future<Order> getOrderById(String orderId);
  Future<List<Order>> getOrdersForUser();
  Future<void> createOrder(Order order);
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}

// --------------------------------------------------------------------------
// 3. MOCK DATA INITIALIZATION
// --------------------------------------------------------------------------

// --- Mock Addresses ---
const _mockAddress1 = Address(
  id: 'A-001',
  streetAddress: '45 Willow Creek Lane',
  city: 'Springfield',
  location: (latitude: 39.7837304, longitude: -100.0),
  isDefault: true,
);

const _mockAddress2 = Address(
  id: 'A-002',
  streetAddress: '123 Main St, Apt 2B',
  city: 'Shelbyville',
  location: (latitude: 38.8951, longitude: -77.0364),
  isDefault: false,
);

// --- Mock Product Variations ---
// const _mockVariantTShirt = ProductVariation(
//   id: 'V-101-L-B',
//   productId: 'P-101',
//   price: 25.00,
//   stockQuantity: 50,
//   attributes: {'Color': 'Black', 'Size': 'L'},
//   discountedPrice: 30.00,
//   imageUrls: [
//     'https://picsum.photos/id/100/200/200',
//     'https://picsum.photos/id/100/200/201',
//     'https://picsum.photos/id/100/200/202',
//   ],
// );

// const _mockVariantCoffee = ProductVariation(
//   id: 'V-205-M-G',
//   productId: 'P-205',
//   price: 18.50,
//   stockQuantity: 100,
//   attributes: {'Roast': 'Medium', 'Weight': '1kg'},
//   imageUrls: [
//     'https://picsum.photos/id/100/200/200',
//     'https://picsum.photos/id/100/200/201',
//     'https://picsum.photos/id/100/200/202',
//   ],
// );

// const _mockVariantLaptop = ProductVariation(
//   id: 'V-330-S-16',
//   productId: 'P-330',
//   price: 1299.99,
//   stockQuantity: 5,
//   attributes: {'CPU': 'M1 Pro', 'Storage': '512GB'},
//   imageUrls: [
//     'https://picsum.photos/id/100/200/200',
//     'https://picsum.photos/id/100/200/201',
//     'https://picsum.photos/id/100/200/202',
//   ],
// );

// --- Mock Orders List ---
// final List<Order> _initialMockOrders = [
//   // Order 1: Delivered (Completed Order)
//   Order(
//     id: 'ORD-001',
//     userId: 'user-abc',
//     date: DateTime.now().subtract(const Duration(days: 10)),
//     deliveryAddress: _mockAddress1,
//     shippingCost: 10.00,
//     taxRate: 0.05,
//     status: OrderStatus.delivered,
//     items: [
//       OrderItem(
//         id: 'OI-001-A',
//         variantSnapshot: _mockVariantTShirt,
//         quantity: 3,
//         unitPrice: 25.00,
//         status: OrderStatus.delivered,
//       ),
//       OrderItem(
//         id: 'OI-001-B',
//         variantSnapshot: _mockVariantCoffee,
//         quantity: 2,
//         unitPrice: 18.50,
//         status: OrderStatus.delivered,
//       ),
//     ],
//   ),

//   // Order 2: In Process (Recent Order)
//   Order(
//     id: 'ORD-002',
//     userId: 'user-abc',
//     date: DateTime.now().subtract(const Duration(hours: 5)),
//     deliveryAddress: _mockAddress1,
//     shippingCost: 0.00,
//     taxRate: 0.08,
//     status: OrderStatus.inProcess,
//     items: [
//       OrderItem(
//         id: 'OI-002-A',
//         variantSnapshot: _mockVariantLaptop,
//         quantity: 1,
//         unitPrice: 1299.99,
//         status: OrderStatus.inProcess,
//       ),
//     ],
//   ),

//   // Order 3: Partially Shipped/Rejected
//   Order(
//     id: 'ORD-003',
//     userId: 'user-xyz',
//     date: DateTime.now().subtract(const Duration(days: 3)),
//     deliveryAddress: _mockAddress2,
//     shippingCost: 7.50,
//     taxRate: 0.06,
//     status: OrderStatus.inProcess,
//     items: [
//       OrderItem(
//         id: 'OI-003-A',
//         variantSnapshot: _mockVariantTShirt,
//         quantity: 1,
//         unitPrice: 25.00,
//         status: OrderStatus.shipped,
//       ),
//       OrderItem(
//         id: 'OI-003-B',
//         variantSnapshot: _mockVariantCoffee,
//         quantity: 5,
//         unitPrice: 18.50,
//         status: OrderStatus.inProcess,
//       ),
//       OrderItem(
//         id: 'OI-003-C',
//         variantSnapshot: _mockVariantTShirt,
//         quantity: 1,
//         unitPrice: 25.00,
//         status: OrderStatus.rejected,
//       ),
//     ],
//   ),
// ];

// --------------------------------------------------------------------------
// 4. MOCK REPOSITORY IMPLEMENTATION
// --------------------------------------------------------------------------

class MockOrderRepository implements OrderRepository {
  // Use a private, mutable map to simulate a database/API state
  final Map<String, Order> _orders;

  // Use a factory constructor for Singleton-like access with initial data
  static final MockOrderRepository instance = MockOrderRepository._({
    for (var order in []) order.id: order,
  });

  const MockOrderRepository._(this._orders);

  // Utility for simulating API latency
  Future<void> _simulateDelay() =>
      Future.delayed(const Duration(milliseconds: 500));

  @override
  Future<Order> getOrderById(String orderId) async {
    await _simulateDelay();

    final order = _orders[orderId];

    if (order == null) {
      throw OrderNotFoundException(orderId);
    }
    return order;
  }

  @override
  Future<void> createOrder(Order order) async {
    await _simulateDelay();

    if (order.items.isEmpty) {
      throw const InvalidOrderException('Order must contain items.');
    }

    // Simulate ID generation
    final newId = 'ORD-${_orders.length + 100}';
    final newOrder = Order(
      id: newId,
      userId: order.userId,
      date: DateTime.now(), // Use current time for creation
      items: order.items,
      deliveryAddress: order.deliveryAddress,
      shippingCost: order.shippingCost,
      taxRate: order.taxRate,
      status: OrderStatus.pending, // Always starts as pending
    );
    _orders[newId] = newOrder;
  }

  @override
  Future<List<Order>> getOrdersForUser() async {
    await _simulateDelay();
    // Return a defensive copy of the list
    return _orders.values.toList();
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await _simulateDelay();

    final order = _orders[orderId];
    if (order == null) {
      throw OrderNotFoundException(orderId);
    }

    // Simulate a successful update by creating a new Order instance with the new status
    _orders[orderId] = Order(
      id: order.id,
      userId: order.userId,
      date: order.date,
      items: order.items,
      deliveryAddress: order.deliveryAddress,
      shippingCost: order.shippingCost,
      taxRate: order.taxRate,
      status: status, // The updated status
    );
  }
}
