import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- THEME / STYLES ---
class AppTheme {
  static const Color primary = Color(0xFF90E3F3);
  static const Color checkoutYellow = Color(0xFFFFD814);
  static const Color danger = Colors.redAccent;
  static const Color success = Colors.green;
  static const Color divider = Colors.black12;
  static const Color border = Colors.black26;

  static const double padding = 12.0;
  static const double borderRadius = 8.0;
  static const double fontSize = 14.0;
}

// --- MODELS ---
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? listPrice;
  final bool inStock;
  final String? dealType;
  final String? discountMessage;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.listPrice,
    this.inStock = true,
    this.dealType,
    this.discountMessage,
  });
}

class CartItem {
  final Product product;
  final int quantity;
  final bool isSelected;

  CartItem({required this.product, this.quantity = 1, this.isSelected = true});

  CartItem copyWith({Product? product, int? quantity, bool? isSelected}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// --- STATE MANAGEMENT ---
@immutable
class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get totalItemsInCart => items.fold(0, (sum, item) => sum + item.quantity);
  int get selectedItemsCount => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.quantity);
  double get selectedItemsTotalPrice => items
      .where((item) => item.isSelected)
      .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: _mockData()));

  void toggleItemSelection(String productId) {
    emit(
      state.copyWith(
        items: state.items.map((item) {
          if (item.product.id == productId) {
            return item.copyWith(isSelected: !item.isSelected);
          }
          return item;
        }).toList(),
      ),
    );
  }

  void incrementQuantity(String productId) {
    emit(
      state.copyWith(
        items: state.items.map((item) {
          if (item.product.id == productId) {
            return item.copyWith(quantity: item.quantity + 1);
          }
          return item;
        }).toList(),
      ),
    );
  }

  void decrementQuantity(String productId) {
    emit(
      state.copyWith(
        items: state.items.map((item) {
          if (item.product.id == productId && item.quantity > 1) {
            return item.copyWith(quantity: item.quantity - 1);
          }
          return item;
        }).toList(),
      ),
    );
  }

  void removeItem(String productId) {
    emit(
      state.copyWith(
        items: state.items.where((i) => i.product.id != productId).toList(),
      ),
    );
  }

  static List<CartItem> _mockData() => [
    CartItem(
      product: Product(
        id: '1',
        name:
            'TUORL Car Phone Holder, Universal Phone Mount for Car Dashboard...',
        imageUrl: 'https://placehold.co/150x150/e0e0e0/000000?text=Holder',
        price: 12.23,
        listPrice: 19.99,
        dealType: 'Limited time deal',
      ),
      quantity: 4,
      isSelected: false,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'YUMONDEAR Bluetooth Headphones Over Ear, 80H Playti...',
        imageUrl: 'https://placehold.co/150x150/e0e0e0/000000?text=Headphones',
        price: 39.99,
        discountMessage: 'Up to 8% off',
      ),
      quantity: 1,
      isSelected: true,
    ),
    CartItem(
      product: Product(
        id: '3',
        name:
            'DEPGI 14" Laptop Screen Extender, 1200P FHD One Cable Connect Po...',
        imageUrl: 'https://placehold.co/150x150/e0e0e0/000000?text=Screen',
        price: 179.99,
      ),
      quantity: 1,
      isSelected: true,
    ),
  ];
}

// --- APP ROOT ---
void main() {
  runApp(const ShoppingCartApp());
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Cart Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppTheme.primary,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          fontFamily: 'Roboto',
        ),
        home: const CartScreen(),
      ),
    );
  }
}

// --- UI ---
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CheckoutBar(),
          const Divider(height: 1, color: AppTheme.divider),
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return const Center(
                    child: Text(
                      'Your Amazon Cart is empty.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppTheme.padding),
                  itemCount: state.items.length,
                  itemBuilder: (_, i) => CartItemCard(item: state.items[i]),
                  separatorBuilder: (_, __) =>
                      const Divider(height: 24, color: AppTheme.border),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppTheme.padding),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final subtotal = state.selectedItemsTotalPrice;
          final itemCount = state.selectedItemsCount;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal ($itemCount items):",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "\$${subtotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.danger,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.checkoutYellow,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: itemCount > 0 ? () {} : null,
                child: Text('Proceed to checkout ($itemCount items)'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final product = item.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: item.isSelected,
              onChanged: (_) => cubit.toggleItemSelection(product.id),
              activeColor: AppTheme.primary,
            ),
            Image.network(
              product.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: 120,
                height: 120,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.padding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: AppTheme.fontSize),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.listPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          "List: \$${product.listPrice!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (product.dealType != null)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      color: Colors.red[800],
                      child: Text(
                        product.dealType!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    product.inStock ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(
                      color: product.inStock
                          ? AppTheme.success
                          : AppTheme.danger,
                      fontSize: 13,
                    ),
                  ),
                  if (product.discountMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        product.discountMessage!,
                        style: const TextStyle(
                          color: AppTheme.success,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Wrap(
            spacing: 8,
            children: [
              QuantitySelector(item: item),
              ActionButton(
                label: 'Delete',
                onPressed: () => cubit.removeItem(product.id),
              ),
              const ActionButton(
                label: 'Compare with similar items',
                onPressed: null, // TODO: Implement later
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final CartItem item;
  const QuantitySelector({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              item.quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 18,
              color: Colors.black54,
            ),
            onPressed: () {
              if (item.quantity == 1) {
                cubit.removeItem(item.product.id);
              } else {
                cubit.decrementQuantity(item.product.id);
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18, color: Colors.black54),
            onPressed: () => cubit.incrementQuantity(item.product.id),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const ActionButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}
