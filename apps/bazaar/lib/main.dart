import 'package:flutter/material.dart';

class OfferCard extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String variationSignature;
  final double initialPrice;
  final int initialStock;
  final bool initialActive;

  final VoidCallback onDeleteConfirmed;
  final void Function(double price, int stock, bool isActive) onSaveConfirmed;

  const OfferCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.variationSignature,
    required this.initialPrice,
    required this.initialStock,
    required this.initialActive,
    required this.onDeleteConfirmed,
    required this.onSaveConfirmed,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  bool isEditing = false;

  late double price;
  late int stock;
  late bool isActive;

  late double backupPrice;
  late int backupStock;
  late bool backupActive;

  @override
  void initState() {
    super.initState();
    price = widget.initialPrice;
    stock = widget.initialStock;
    isActive = widget.initialActive;
  }

  Future<bool> confirmDialog(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("No")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Yes")),
        ],
      ),
    );
    return result ?? false;
  }

  String getStatus() {
    if (stock <= 0) return "Out of Stock";
    return isActive ? "Active" : "Inactive";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return Colors.green;
      case "Inactive":
        return Colors.grey;
      default:
        return Colors.red;
    }
  }

  Future<void> handleToggle(bool value) async {
    final ok = await confirmDialog(
      "Change Status",
      "Are you sure you want to ${value ? 'activate' : 'deactivate'} this offer?",
    );

    if (ok) {
      setState(() => isActive = value);
    }
  }

  Future<void> handleSave() async {
    final ok = await confirmDialog(
      "Save Changes",
      "Are you sure you want to save these changes?",
    );

    if (!ok) return;

    setState(() => isEditing = false);

    widget.onSaveConfirmed(price, stock, isActive);
  }

  Future<void> handleCancel() async {
    final ok = await confirmDialog(
      "Cancel Editing",
      "Discard all unsaved changes?",
    );

    if (!ok) return;

    setState(() {
      isEditing = false;
      price = backupPrice;
      stock = backupStock;
      isActive = backupActive;
    });
  }

  Future<void> handleDelete() async {
    final ok = await confirmDialog(
      "Delete Offer",
      "Are you sure you want to delete this offer?",
    );

    if (!ok) return;

    widget.onDeleteConfirmed();
  }

  void startEdit() {
    setState(() {
      isEditing = true;
      backupPrice = price;
      backupStock = stock;
      backupActive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = getStatus();
    final statusColor = getStatusColor(status);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              widget.imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STATUS + TOGGLE + NAME
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.productName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Switch(
                      value: isActive,
                      onChanged: stock <= 0
                          ? null
                          : (v) async => await handleToggle(v),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  widget.variationSignature,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 14),

                // PRICE + STOCK
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: isEditing,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Price"),
                        controller: TextEditingController(
                          text: price.toStringAsFixed(2),
                        ),
                        onChanged: (v) {
                          final p = double.tryParse(v);
                          if (p != null) price = p;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        enabled: isEditing,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Stock",
                          errorText: stock <= 0 ? "Out of stock" : null,
                        ),
                        controller: TextEditingController(text: stock.toString()),
                        onChanged: (v) {
                          final s = int.tryParse(v);
                          if (s != null) setState(() => stock = s);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ACTION BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isEditing)
                      ElevatedButton(
                        onPressed: startEdit,
                        child: const Text("Edit"),
                      ),

                    if (!isEditing)
                      OutlinedButton(
                        onPressed: handleDelete,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text("Delete"),
                      ),

                    if (isEditing)
                      ElevatedButton(
                        onPressed: handleSave,
                        child: const Text("Save"),
                      ),

                    if (isEditing)
                      OutlinedButton(
                        onPressed: handleCancel,
                        child: const Text("Cancel"),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
