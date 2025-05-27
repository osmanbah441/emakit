import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
    super.key,
    required this.onAddToFavorites,
    required this.label,
  });

  final VoidCallback onAddToFavorites;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        onPressed: onAddToFavorites,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black, // Text color
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
          ), // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
