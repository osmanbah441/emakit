part of 'cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  List<CartItem> _items = [
    const CartItem(
      id: 'product_1',
      product: ProductVariation(
        id: 'product_1',
        productId: 'nike_t_shirt_1',
        price: 25.00,
        stockQuantity: 100,
        attributes: {'Color': 'Red', 'Size': 'Medium'},
        imageUrls: ["https://picsum.photos/200/300"],
      ),
      quantity: 2,
      productName: 'Nike Dri-FIT T-shirt',
    ),
    const CartItem(
      id: 'product_2',
      product: ProductVariation(
        id: 'product_2',
        productId: 'iphone_15_pro_1',
        price: 999.00,
        stockQuantity: 50,
        attributes: {'Color': 'Blue Titanium', 'Storage': '256GB'},
        imageUrls: ["https://picsum.photos/200/300"],
      ),
      quantity: 1,
      productName: 'Apple iPhone 15 Pro',
      isSelected: true,
    ),
    const CartItem(
      id: 'product_3',
      product: ProductVariation(
        imageUrls: ["https://picsum.photos/200/300"],
        id: 'product_3',
        productId: 'ikea_dresser_1',
        price: 150.00,
        stockQuantity: 20,
        attributes: {'Color': 'White Stain'},
      ),
      quantity: 1,
      productName: 'IKEA HEMNES 3-Drawer Chest',
    ),
    const CartItem(
      id: 'product_4',
      product: ProductVariation(
        id: 'product_4',
        productId: 'sony_headphones_1',
        price: 349.99,
        stockQuantity: 30,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Color': 'Black'},
      ),
      quantity: 1,
      productName: 'Sony WH-1000XM5 Headphones',
      isSelected: true,
    ),
    const CartItem(
      id: 'product_5',
      product: ProductVariation(
        id: 'product_5',
        productId: 'samsung_tv_1',
        price: 799.00,
        stockQuantity: 5,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Size': '55-inch'},
      ),
      quantity: 1,
      productName: 'Samsung 4K UHD Smart TV',
    ),
    const CartItem(
      id: 'product_6',
      product: ProductVariation(
        id: 'product_6',
        productId: 'logitech_mouse_1',
        price: 79.99,
        stockQuantity: 75,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Color': 'Graphite'},
      ),
      quantity: 3,
      productName: 'Logitech MX Master 3S',
      isSelected: true,
    ),
    const CartItem(
      id: 'product_7',
      product: ProductVariation(
        id: 'product_7',
        productId: 'kindle_paperwhite_1',
        price: 139.99,
        stockQuantity: 40,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Storage': '16GB'},
      ),
      quantity: 1,
      productName: 'Kindle Paperwhite',
    ),
    const CartItem(
      id: 'product_8',
      product: ProductVariation(
        id: 'product_8',
        productId: 'hydro_flask_1',
        price: 44.95,
        stockQuantity: 60,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Color': 'Cobalt', 'Size': '32 oz'},
      ),
      quantity: 2,
      productName: 'Hydro Flask Water Bottle',
      isSelected: true,
    ),
    const CartItem(
      id: 'product_9',
      product: ProductVariation(
        id: 'product_9',
        productId: 'lego_millennium_falcon_1',
        price: 849.99,
        stockQuantity: 15,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {},
      ),
      quantity: 1,
      productName: 'LEGO Star Wars Millennium Falcon',
    ),
    const CartItem(
      id: 'product_10',
      product: ProductVariation(
        id: 'product_10',
        productId: 'anker_powerbank_1',
        price: 39.99,
        stockQuantity: 90,
        imageUrls: ["https://picsum.photos/200/300"],
        attributes: {'Capacity': '20000mAh'},
      ),
      quantity: 2,
      productName: 'Anker PowerCore Power Bank',
      isSelected: true,
    ),
  ];

  @override
  List<CartItem> getItems() {
    return _items;
  }

  @override
  void incrementQuantity(String productId) {
    _items = _items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
  }

  @override
  void decrementQuantity(String productId) {
    _items = _items.map((item) {
      if (item.product.id == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
  }

  @override
  void removeItem(String productId) {
    _items = _items.where((item) => item.product.id != productId).toList();
  }

  @override
  void toggleItemSelection(String productId) {
    _items = _items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();
  }

  @override
  Future<void> addItem({required String productId, int? quantity}) {
    throw Exception();
  }
}

extension on CartItem {
  CartItem copyWith({
    ProductVariation? product,
    int? quantity,
    bool? isSelected,
    String? title,
  }) {
    return CartItem(
      id: id,
      productName: title ?? this.productName,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
