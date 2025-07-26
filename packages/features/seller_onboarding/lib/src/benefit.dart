import 'package:flutter/material.dart';

class Benefit {
  final IconData icon;
  final String title;
  final String description;

  const Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });

  static List<Benefit> all() => const [
    Benefit(
      icon: Icons.public,
      title: 'Massive Customer Reach',
      description:
          'Instantly connect with thousands of ready-to-buy customers across Sierra Leone. No need to worry about extensive marketing; we bring the buyers to you.',
    ),
    Benefit(
      icon: Icons.auto_awesome,
      title: 'Effortless Business Operations',
      description:
          'Our simple, intuitive tools make setting up your shop, listing products, and managing orders easy. Spend less time on paperwork and more time on what you do best.',
    ),
    Benefit(
      icon: Icons.account_balance,
      title: 'Access to Growth Capital (Loans)',
      description:
          'Leverage your sales data on Salone Bazaar to gain easier access to vital business loans. This helps you invest in inventory, expand your operations, and truly grow.',
    ),
    Benefit(
      icon: Icons.volunteer_activism,
      title: 'Dedicated Support, Always',
      description:
          'Our local team is here to guide you every step of the way, from setup to troubleshooting. You\'re never alone on your journey to success.',
    ),
    Benefit(
      icon: Icons.verified_user,
      title: 'Secure & Seamless Payments',
      description:
          'Receive your earnings reliably and securely, with transparent payouts directly to your Mobile Money or bank account. Sell with confidence, knowing your payments are handled.',
    ),
    Benefit(
      icon: Icons.trending_up,
      title: 'Data-Driven Growth',
      description:
          'Access valuable insights into your sales, popular products, and customer trends. Use this information to make smart decisions and scale your business effectively.',
    ),
    Benefit(
      icon: Icons.diamond,
      title: 'Instant Trust & Credibility',
      description:
          'Benefit from the reputable Salone Bazaar brand. Selling on our platform immediately builds buyer trust in your products and your business.',
    ),
    Benefit(
      icon: Icons.savings,
      title: 'Reduced Marketing Costs',
      description:
          'Save money on advertising. We handle the heavy lifting of bringing customers to the marketplace, freeing up your resources.',
    ),
  ];
}
