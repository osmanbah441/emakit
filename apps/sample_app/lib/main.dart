import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

// Main function to run the app
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OrderChatApp());
}

// --- Enums for Message Types ---

/// Defines the type of content in a chat message.
enum MessageType { text, agreement }

/// Defines the status of an agreement message.
enum AgreementStatus { none, pending, accepted, declined }

// --- Data Models ---
// These classes represent the data structure for our app.

/// Represents a single chat message, which can also function as the final agreement.
class ChatMessage {
  final MessageType type;
  final String? text;
  final DateTime timestamp;
  final bool isSentByMe;

  // Fields for agreement messages
  final double? price;
  final double? initialPayment;
  final DateTime? expectedCompletionDate;
  final String? instructions;
  AgreementStatus agreementStatus;

  ChatMessage({
    this.type = MessageType.text,
    this.text,
    required this.timestamp,
    required this.isSentByMe,
    this.price,
    this.initialPayment,
    this.expectedCompletionDate,
    this.instructions,
    this.agreementStatus = AgreementStatus.pending,
  });
}

/// Represents a full conversation related to a specific order.
class OrderChat {
  final String orderId;
  final String storeName;
  final String buyerName;
  final String heroImage; // An image to represent the order/store
  final List<ChatMessage> messages;
  List<ChatMessage> agreementHistory; // A history of proposals

  OrderChat({
    required this.orderId,
    required this.storeName,
    required this.buyerName,
    required this.heroImage,
    required this.messages,
    required this.agreementHistory,
  });
}

// --- Mock Data ---
// In a real app, this data would come from a server or database.

final List<OrderChat> mockChats = [
  OrderChat(
    orderId: "SL-ORD-001",
    storeName: "Freetown Fabrics",
    buyerName: "Aminata",
    heroImage: "https://placehold.co/100x100/25D366/FFFFFF?text=FF",
    messages: [
      ChatMessage(
        type: MessageType.text,
        text: "Hello! I'd like to request a custom design for my dress.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        isSentByMe: false,
      ),
      ChatMessage(
        type: MessageType.text,
        text: "Of course! What did you have in mind?",
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
        isSentByMe: true,
      ),
    ],
    // This chat has a pending agreement already created by the tailor.
    agreementHistory: [
      ChatMessage(
        type: MessageType.agreement,
        price: 350000,
        initialPayment: 150000,
        expectedCompletionDate: DateTime.now().add(const Duration(days: 5)),
        instructions:
            "Traditional Sierra Leonean patterns with a modern, knee-length cut.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isSentByMe: true, // Sent by tailor
        agreementStatus: AgreementStatus.pending,
      ),
    ],
  ),
  OrderChat(
    orderId: "SL-ORD-002",
    storeName: "Lumley Beach Crafts",
    buyerName: "Mohamed",
    heroImage: "https://placehold.co/100x100/128C7E/FFFFFF?text=LC",
    messages: [
      ChatMessage(
        type: MessageType.text,
        text: "Hi, when can I expect my order to be delivered?",
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isSentByMe: false,
      ),
      ChatMessage(
        type: MessageType.text,
        text: "Hi Mohamed, it should be with you by 5 PM today.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
        isSentByMe: true,
      ),
    ],
    // This chat demonstrates a declined agreement, ready for a new proposal.
    agreementHistory: [
      ChatMessage(
        type: MessageType.agreement,
        price: 120000,
        initialPayment: 50000,
        expectedCompletionDate: DateTime.now().add(const Duration(days: 2)),
        instructions: "Two wooden masks, dark finish.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isSentByMe: true,
        agreementStatus: AgreementStatus.declined,
      ),
    ],
  ),
];

// --- Main App Widget ---

class OrderChatApp extends StatelessWidget {
  const OrderChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Chat',
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF075E54),
          secondary: const Color(0xFF25D366),
          background: const Color(0xFFECE5DD),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          foregroundColor: Colors.white,
        ),
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      home: const ChatListScreen(),
    );
  }
}

// --- Screens ---

/// Displays the list of all ongoing order conversations, with separate entries for tailor and customer views.
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Conversations"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: mockChats.length * 2,
        itemBuilder: (context, index) {
          final chatIndex = index ~/ 2;
          final isTailorView = index % 2 == 0;
          final chat = mockChats[chatIndex];

          final viewTitle = isTailorView ? "(As Tailor)" : "(As Customer)";
          final lastMessage = chat.messages.isNotEmpty
              ? chat.messages.last
              : null;

          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(chat.heroImage),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
                title: Text(
                  "${chat.storeName} $viewTitle",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  lastMessage?.text ?? "No messages yet",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  lastMessage != null
                      ? DateFormat('h:mm a').format(lastMessage.timestamp)
                      : '',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(chat: chat, isTailorView: isTailorView),
                    ),
                  );
                },
              ),
              const Divider(height: 0, indent: 80, endIndent: 16),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}

/// Displays the messages for a single order and allows the user to send new ones.
class ChatScreen extends StatefulWidget {
  final OrderChat chat;
  final bool isTailorView;

  const ChatScreen({super.key, required this.chat, required this.isTailorView});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  late OrderChat _currentChat;

  @override
  void initState() {
    super.initState();
    _currentChat = widget.chat;
    _messages = List.from(_currentChat.messages);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    final message = ChatMessage(
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isSentByMe: widget.isTailorView,
    );
    _addMessage(message);
    _messageController.clear();
  }

  void _createNewAgreement(
    double price,
    double initialPayment,
    DateTime completionDate,
    String instructions,
  ) {
    final agreementMessage = ChatMessage(
      type: MessageType.agreement,
      price: price,
      initialPayment: initialPayment,
      expectedCompletionDate: completionDate,
      instructions: instructions,
      timestamp: DateTime.now(),
      isSentByMe: true, // Agreements are always initiated by the tailor
      agreementStatus: AgreementStatus.pending,
    );
    setState(() {
      _currentChat.agreementHistory.add(agreementMessage);
    });
  }

  void _updateAgreementStatus(AgreementStatus status) {
    setState(() {
      if (_currentChat.agreementHistory.isNotEmpty) {
        _currentChat.agreementHistory.last.agreementStatus = status;
      }
    });
    // In a real app, you'd also send this update to your backend.
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.add(message);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(_currentChat.heroImage),
              onBackgroundImageError: (exception, stackTrace) {},
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentChat.storeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Order: ${_currentChat.orderId}",
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c-949e91d20548b.jpg",
            ),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Column(
          children: [
            _buildPinnedAgreementBanner(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatMessageBubble(
                    message: _messages[index],
                    isTailorView: widget.isTailorView,
                  );
                },
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPinnedAgreementBanner() {
    final latestAgreement = _currentChat.agreementHistory.isNotEmpty
        ? _currentChat.agreementHistory.last
        : null;

    // Case 1: No agreement has been created yet
    if (latestAgreement == null) {
      if (widget.isTailorView) {
        return _buildCreateAgreementButton("Create Final Agreement");
      } else {
        return _buildWaitingBanner(
          "Waiting for the store to propose a final agreement.",
        );
      }
    }

    // Case 2: The latest agreement has been declined
    if (latestAgreement.agreementStatus == AgreementStatus.declined) {
      if (widget.isTailorView) {
        return _buildCreateAgreementButton("Create New Proposal");
      } else {
        return _buildWaitingBanner(
          "Agreement declined. Waiting for a new proposal.",
        );
      }
    }

    // Case 3: An agreement is pending or accepted
    return AgreementWidget(
      message: latestAgreement,
      isPinned: true,
      isTailorView: widget.isTailorView,
      onAction: (status) {
        _updateAgreementStatus(status);
      },
    );
  }

  Widget _buildCreateAgreementButton(String text) {
    return Material(
      color: Colors.amber[100],
      child: InkWell(
        onTap: () => _showAgreementDialog(),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.handshake, color: Colors.orange),
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWaitingBanner(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Center(
        child: Text(text, style: const TextStyle(fontStyle: FontStyle.italic)),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onChanged: (text) => setState(() {}),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: _sendMessage,
            mini: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showAgreementDialog() {
    final priceController = TextEditingController();
    final initialPaymentController = TextEditingController();
    final instructionsController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    DateTime? selectedDate = DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Propose Final Agreement'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Final Price (SLL)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Please enter a price'
                            : null,
                      ),
                      TextFormField(
                        controller: initialPaymentController,
                        decoration: const InputDecoration(
                          labelText: 'Initial Payment (SLL)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Please enter an amount'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Expected Completion Date"),
                        subtitle: Text(
                          DateFormat.yMMMd().format(selectedDate!),
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate!,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != selectedDate) {
                            setDialogState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                      ),
                      TextFormField(
                        controller: instructionsController,
                        decoration: const InputDecoration(
                          labelText: 'Final Instructions',
                        ),
                        maxLines: 3,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Please enter instructions'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _createNewAgreement(
                        double.parse(priceController.text),
                        double.parse(initialPaymentController.text),
                        selectedDate!,
                        instructionsController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Send Proposal'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// --- Widgets ---

/// A styled bubble for displaying a single chat message.
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isTailorView;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isTailorView,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSentByMe =
        (isTailorView && message.isSentByMe) ||
        (!isTailorView && !message.isSentByMe);

    final alignment = isSentByMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final color = isSentByMe ? const Color(0xFFDCF8C6) : Colors.white;
    final bubbleRadius = isSentByMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: bubbleRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50.0, bottom: 5.0),
                  child: Text(message.text ?? ""),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    DateFormat('h:mm a').format(message.timestamp),
                    style: TextStyle(fontSize: 11.0, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AgreementWidget extends StatelessWidget {
  final ChatMessage message;
  final Function(AgreementStatus) onAction;
  final bool isTailorView;
  final bool isPinned;

  const AgreementWidget({
    super.key,
    required this.message,
    required this.onAction,
    required this.isTailorView,
    this.isPinned = false,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_SL',
      symbol: 'Le ',
      decimalDigits: 0,
    );
    final priceString = currencyFormat.format(message.price);
    final initialPaymentString = currencyFormat.format(message.initialPayment);
    final completionDateString = message.expectedCompletionDate != null
        ? DateFormat.yMMMd().format(message.expectedCompletionDate!)
        : "Not set";

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (message.agreementStatus) {
      case AgreementStatus.pending:
        statusColor = Colors.orange;
        statusText = "Pending Agreement";
        statusIcon = Icons.hourglass_top;
        break;
      case AgreementStatus.accepted:
        statusColor = Colors.green;
        statusText = "Agreement Accepted";
        statusIcon = Icons.check_circle;
        break;
      case AgreementStatus.declined:
        statusColor = Colors.red;
        statusText = "Agreement Declined";
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusText = "No Agreement";
        statusIcon = Icons.info;
    }

    return Material(
      color: isPinned ? statusColor.withOpacity(0.15) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            _buildDetailRow("Final Price:", priceString),
            _buildDetailRow("Initial Payment:", initialPaymentString),
            _buildDetailRow("Completion Date:", completionDateString),
            const SizedBox(height: 4),
            Text("Instructions: ${message.instructions ?? ''}"),
            const SizedBox(height: 8),
            if (message.agreementStatus == AgreementStatus.pending &&
                !isTailorView)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => onAction(AgreementStatus.declined),
                    child: const Text("Decline"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => onAction(AgreementStatus.accepted),
                    child: const Text("Accept"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
