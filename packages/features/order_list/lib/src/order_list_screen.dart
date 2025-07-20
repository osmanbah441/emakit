// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id; // Unique ID for the item
  final String name;
  final int quantity;
  final double price; // Price per unit
  final String imageUrl;
  final String itemSellerName; // Seller specific to THIS item

  const OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.itemSellerName,
  });

  double get totalPrice => quantity * price;

  @override
  List<Object?> get props => [
    id,
    name,
    quantity,
    price,
    imageUrl,
    itemSellerName,
  ];
}

/// Represents an entire order.
class Order extends Equatable {
  final String id; // Unique ID for the order
  final String orderNumber;
  final String orderDate;
  final String status;
  final double totalOrderPrice; // Total price of all items in this order
  final String primarySellerName; // The primary seller for this order
  final String shippingDetails;
  final String paymentSummary;
  final List<OrderItem> items; // List of OrderItem objects

  const Order({
    required this.id,
    required this.orderNumber,
    required this.orderDate,
    required this.status,
    required this.totalOrderPrice,
    required this.primarySellerName,
    required this.shippingDetails,
    required this.paymentSummary,
    required this.items,
  });

  // Helper to get total number of unique items (not quantity)
  int get uniqueItemCount => items.length;
  // Helper to get total quantity of all items
  int get totalQuantityCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  // New helper methods to categorize order status for tabs
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isOutForDelivery => status.toLowerCase() == 'out for delivery';
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isCancelled =>
      status.toLowerCase() == 'cancelled' ||
      status.toLowerCase() ==
          'refund issued'; // Group refund issued with cancelled

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    orderDate,
    status,
    totalOrderPrice,
    primarySellerName,
    shippingDetails,
    paymentSummary,
    items,
  ];
}

// ======== 2. Data Provider (Simulated API) ========

class OrderApiProvider {
  // Simulate network delay and fetch data
  Future<List<Order>> fetchOrders() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Shorter delay for testing tabs

    return [
      Order(
        id: 'order_001',
        orderNumber: '#12345',
        orderDate: 'July 15, 2025',
        status: 'Pending',
        totalOrderPrice: 50.00,
        primarySellerName: 'Gadget Gurus',
        shippingDetails:
            'Est. Delivery: July 20-22, 2025 - DHL Tracking: ABC123XYZ',
        paymentSummary: 'Paid with Visa ending in 1234',
        items: const [
          OrderItem(
            id: 'item_001',
            name: 'Wireless Headphones',
            quantity: 1,
            price: 30.00,
            imageUrl: 'https://picsum.photos/seed/order1_item1/100/100',
            itemSellerName: 'Gadget Gurus',
          ),
          OrderItem(
            id: 'item_002',
            name: 'USB-C Cable (2m)',
            quantity: 2,
            price: 10.00,
            imageUrl: 'https://picsum.photos/seed/order1_item2/100/100',
            itemSellerName: 'Tech Accessories Inc.',
          ),
        ],
      ),
      Order(
        id: 'order_002',
        orderNumber: '#67890',
        orderDate: 'July 14, 2025',
        status: 'Completed',
        totalOrderPrice: 75.00,
        primarySellerName: 'Bookworm Store',
        shippingDetails: 'Delivered on: July 16, 2025 - USPS',
        paymentSummary: 'Paid with PayPal',
        items: const [
          OrderItem(
            id: 'item_003',
            name: 'Flutter for Dummies',
            quantity: 1,
            price: 75.00,
            imageUrl: 'https://picsum.photos/seed/order2_item1/100/100',
            itemSellerName: 'Bookworm Store',
          ),
        ],
      ),
      Order(
        id: 'order_003',
        orderNumber: '#11223',
        orderDate: 'July 12, 2025',
        status: 'Cancelled',
        totalOrderPrice: 30.00,
        primarySellerName: 'Artisan Crafts',
        shippingDetails: 'Cancellation Confirmed: July 13, 2025',
        paymentSummary: 'Refund Issued',
        items: const [
          OrderItem(
            id: 'item_004',
            name: 'Handmade Soap Bar',
            quantity: 3,
            price: 5.00,
            imageUrl: 'https://picsum.photos/seed/order3_item1/100/100',
            itemSellerName: 'Artisan Crafts',
          ),
          OrderItem(
            id: 'item_005',
            name: 'Lavender Scented Candle',
            quantity: 2,
            price: 7.50,
            imageUrl: 'https://picsum.photos/seed/order3_item2/100/100',
            itemSellerName: 'Scented Delights Co.',
          ),
          OrderItem(
            id: 'item_006',
            name: 'Custom Engraved Mug',
            quantity: 1,
            price: 10.00,
            imageUrl: 'https://picsum.photos/seed/order3_item3/100/100',
            itemSellerName: 'Crafty Creations',
          ),
        ],
      ),
      Order(
        id: 'order_004',
        orderNumber: '#98765',
        orderDate: 'July 10, 2025',
        status: 'Out for Delivery', // New status for the tab
        totalOrderPrice: 25.00,
        primarySellerName: 'Tech Gadgets',
        shippingDetails: 'Tracking: XYZ789ABC - Arriving soon!',
        paymentSummary: 'Paid with Visa',
        items: const [
          OrderItem(
            id: 'item_007',
            name: 'Smartphone Case',
            quantity: 1,
            price: 25.00,
            imageUrl: 'https://picsum.photos/seed/order4_item1/100/100',
            itemSellerName: 'Tech Gadgets',
          ),
        ],
      ),
      Order(
        id: 'order_005',
        orderNumber: '#54321',
        orderDate: 'July 17, 2025',
        status: 'Pending',
        totalOrderPrice: 120.00,
        primarySellerName: 'Sporting Goods Co.',
        shippingDetails: 'Processing Shipment',
        paymentSummary: 'Paid via Bank Transfer',
        items: const [
          OrderItem(
            id: 'item_008',
            name: 'Running Shoes',
            quantity: 1,
            price: 80.00,
            imageUrl: 'https://picsum.photos/seed/order5_item1/100/100',
            itemSellerName: 'Sporting Goods Co.',
          ),
          OrderItem(
            id: 'item_009',
            name: 'Water Bottle',
            quantity: 2,
            price: 20.00,
            imageUrl: 'https://picsum.photos/seed/order5_item2/100/100',
            itemSellerName: 'Sporting Goods Co.',
          ),
        ],
      ),
      Order(
        id: 'order_006',
        orderNumber: '#22446',
        orderDate: 'July 18, 2025',
        status: 'Out for Delivery', // Another 'Out for Delivery'
        totalOrderPrice: 45.00,
        primarySellerName: 'Home Essentials',
        shippingDetails: 'Tracking: DEF456GHI - Expected July 19th',
        paymentSummary: 'Paid with MasterCard',
        items: const [
          OrderItem(
            id: 'item_010',
            name: 'Smart Light Bulb',
            quantity: 2,
            price: 22.50,
            imageUrl: 'https://picsum.photos/seed/order6_item1/100/100',
            itemSellerName: 'Home Essentials',
          ),
        ],
      ),
    ];
  }
}

// ======== 3. Repository ========

class OrderRepository {
  final OrderApiProvider orderApiProvider;

  OrderRepository({required this.orderApiProvider});

  Future<List<Order>> getOrders() async {
    return await orderApiProvider.fetchOrders();
  }
}

// ======== 4. Cubit States ========

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

// OrdersLoaded now also holds the currently filtered list
class OrdersLoaded extends OrdersState {
  final List<Order> allOrders; // The complete list from the repository
  final List<Order>
  displayedOrders; // The list currently shown on screen (filtered)
  final int selectedTabIndex; // To keep track of the active tab in the state

  const OrdersLoaded({
    required this.allOrders,
    required this.displayedOrders,
    this.selectedTabIndex = 0, // Default to 'All Orders'
  });

  // CopyWith for easier state updates
  OrdersLoaded copyWith({
    List<Order>? allOrders,
    List<Order>? displayedOrders,
    int? selectedTabIndex,
  }) {
    return OrdersLoaded(
      allOrders: allOrders ?? this.allOrders,
      displayedOrders: displayedOrders ?? this.displayedOrders,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object> get props => [allOrders, displayedOrders, selectedTabIndex];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError({required this.message});

  @override
  List<Object> get props => [message];
}

// ======== 5. Cubit ========

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepository orderRepository;

  OrdersCubit({required this.orderRepository}) : super(OrdersInitial());

  List<Order> _cachedAllOrders = []; // Cache the full list after initial fetch

  Future<void> fetchOrders() async {
    try {
      emit(OrdersLoading());
      _cachedAllOrders = await orderRepository.getOrders();
      // Initially display all orders and set tab to 0 (All Orders)
      emit(
        OrdersLoaded(
          allOrders: _cachedAllOrders,
          displayedOrders: _cachedAllOrders,
          selectedTabIndex: 0,
        ),
      );
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  void filterOrdersByTab(int tabIndex) {
    if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      List<Order> filteredList;

      switch (tabIndex) {
        case 0: // All Orders
          filteredList = _cachedAllOrders;
          break;
        case 1: // Pending
          filteredList = _cachedAllOrders
              .where((order) => order.isPending)
              .toList();
          break;
        case 2: // Out for Delivery
          filteredList = _cachedAllOrders
              .where((order) => order.isOutForDelivery)
              .toList();
          break;
        case 3: // Completed
          filteredList = _cachedAllOrders
              .where((order) => order.isCompleted)
              .toList();
          break;
        case 4: // Cancelled
          filteredList = _cachedAllOrders
              .where((order) => order.isCancelled)
              .toList();
          break;
        default:
          filteredList = _cachedAllOrders; // Fallback to all orders
      }
      // Emit a new OrdersLoaded state with the filtered list and updated tab index
      emit(
        currentState.copyWith(
          displayedOrders: filteredList,
          selectedTabIndex: tabIndex,
        ),
      );
    }
  }
}

// ======== 6. UI Widgets ========

// Enum for actions
enum OrderAction { cancelOrder, reorder, contactSeller }

class OrderCard extends StatefulWidget {
  final Order order; // Now takes an Order object

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'refund issued':
        return Colors.red; // Visual treat refund as cancelled for color
      case 'out for delivery':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access order properties via widget.order
    final order = widget.order;
    final int totalQuantityCount = order.totalQuantityCount;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Row 1: Order # and Kebab Menu ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ${order.orderNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Sold by: ${order.primarySellerName}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton<OrderAction>(
                    onSelected: (OrderAction result) {
                      switch (result) {
                        case OrderAction.cancelOrder:
                          print('Cancel Order ${order.orderNumber} clicked');
                          // Add logic to call Cubit method for cancellation
                          break;
                        case OrderAction.reorder:
                          print('Reorder ${order.orderNumber} clicked');
                          // Add logic to call Cubit method for reordering
                          break;
                        case OrderAction.contactSeller:
                          print(
                            'Contact Seller ${order.primarySellerName} for Order ${order.orderNumber}',
                          );
                          // Add logic to open chat with seller or compose email
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      List<PopupMenuEntry<OrderAction>> items = [];
                      // Logic based on more granular statuses
                      if (order.isCompleted || order.isCancelled) {
                        items.add(
                          const PopupMenuItem<OrderAction>(
                            value: OrderAction.reorder,
                            child: Text('Reorder'),
                          ),
                        );
                      }
                      if (order.isPending || order.isOutForDelivery) {
                        items.add(
                          const PopupMenuItem<OrderAction>(
                            value: OrderAction.cancelOrder,
                            child: Text('Cancel Order'),
                          ),
                        );
                      }
                      items.add(
                        const PopupMenuItem<OrderAction>(
                          value: OrderAction.contactSeller,
                          child: Text('Contact Seller'),
                        ),
                      );
                      return items;
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              // --- Row 2: Date and Status ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderDate,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13.0),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // --- Item Count & Total Price (Always visible) ---
              Text(
                'Total: $totalQuantityCount items',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Order Value: \$${order.totalOrderPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),

              // --- Expanded Content (Conditionally visible) ---
              if (_isExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 24.0),
                    Text(
                      'Items in this Order:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        final item = order.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  item.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Sold by: ${item.itemSellerName}',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${item.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),

                    Row(
                      children: [
                        const Icon(
                          Icons.local_shipping,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            order.shippingDetails,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.payment, size: 18, color: Colors.grey),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            order.paymentSummary,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== 7. My Orders Screen ========

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the screen initializes
    context.read<OrdersCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // BlocBuilder for the tab bar to react to Cubit's selectedTabIndex
          BlocBuilder<OrdersCubit, OrdersState>(
            buildWhen: (previous, current) =>
                current is OrdersLoaded && previous is OrdersLoaded
                ? previous.selectedTabIndex != current.selectedTabIndex
                : true,
            builder: (context, state) {
              int currentTabIndex = 0;
              if (state is OrdersLoaded) {
                currentTabIndex = state.selectedTabIndex;
              }
              return _buildTabBar(currentTabIndex);
            },
          ),
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrdersLoaded) {
                  final List<Order> displayedOrders = state.displayedOrders;

                  if (displayedOrders.isEmpty) {
                    return Center(
                      child: Text('No orders found for this category.'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: displayedOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: OrderCard(order: displayedOrders[index]),
                      );
                    },
                  );
                } else if (state is OrdersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.message}'),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OrdersCubit>().fetchOrders(); // Retry
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink(); // Initial empty state or fallback
              },
            ),
          ),
        ],
      ),
    );
  }

  // _buildTabBar now takes the selectedTabIndex from the Cubit state
  Widget _buildTabBar(int currentTabIndex) {
    return Container(
      color: Colors.white,
      // Removed horizontal padding from Container, apply to SingleChildScrollView instead
      child: SingleChildScrollView(
        // <--- FIX: Added SingleChildScrollView
        scrollDirection: Axis.horizontal, // <--- FIX: Horizontal scrolling
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ), // <--- FIX: Padding applied here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTabItem(0, 'All Orders', currentTabIndex),
            const SizedBox(width: 24.0),
            _buildTabItem(1, 'Pending', currentTabIndex),
            const SizedBox(width: 24.0),
            _buildTabItem(2, 'Out for Delivery', currentTabIndex),
            const SizedBox(width: 24.0),
            _buildTabItem(3, 'Completed', currentTabIndex),
            const SizedBox(width: 24.0),
            _buildTabItem(4, 'Cancelled', currentTabIndex),
          ],
        ),
      ),
    );
  }

  // _buildTabItem now also takes currentTabIndex to determine selection
  Widget _buildTabItem(int index, String title, int currentTabIndex) {
    bool isSelected = currentTabIndex == index;
    return GestureDetector(
      onTap: () {
        // Trigger the Cubit to filter orders based on the tapped tab index
        context.read<OrdersCubit>().filterOrdersByTab(index);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ),
          if (isSelected)
            Container(
              height: 3.0,
              width:
                  title.length *
                  8.0, // Adjust width based on title length for better underline
              color: Colors.deepPurple,
            ),
        ],
      ),
    );
  }
}

// ======== 8. Main App Entry Point ========

void main() {
  runApp(const MyAppRoot());
}

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => OrderApiProvider()),
        RepositoryProvider(
          create: (context) => OrderRepository(
            orderApiProvider: context.read<OrderApiProvider>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            OrdersCubit(orderRepository: context.read<OrderRepository>()),
        child: MaterialApp(
          title: 'My Orders',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MyOrdersScreen(),
        ),
      ),
    );
  }
}
