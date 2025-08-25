import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({super.key});

  @override
  DateOfBirthFieldState createState() => DateOfBirthFieldState();
}

class DateOfBirthFieldState extends State<DateOfBirthField> {
  final _dayController = TextEditingController();
  final _yearController = TextEditingController();
  int? _selectedMonth;

  final _dayFocus = FocusNode();
  final _yearFocus = FocusNode();

  DateTime? get dateOfBirth {
    if (_dayController.text.isNotEmpty &&
        _selectedMonth != null &&
        _yearController.text.isNotEmpty) {
      try {
        return DateTime(
          int.parse(_yearController.text),
          _selectedMonth!,
          int.parse(_dayController.text),
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }

  @override
  void dispose() {
    _dayController.dispose();
    _yearController.dispose();
    _dayFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: dateOfBirth,
      validator: (value) {
        final day = int.tryParse(_dayController.text);
        final year = int.tryParse(_yearController.text);

        if (day == null || _selectedMonth == null || year == null) {
          return 'Please enter a complete date.';
        }

        if (day > _getDaysInMonth(year, _selectedMonth!)) {
          return 'Invalid day for the selected month.';
        }

        final now = DateTime.now();
        final enteredDate = dateOfBirth;
        if (enteredDate == null) return 'Invalid date format.';

        final minAgeDate = DateTime(now.year - 100, now.month, now.day);
        final maxAgeDate = DateTime(now.year - 5, now.month, now.day);

        if (enteredDate.isBefore(minAgeDate)) {
          return 'Age cannot be more than 100 years.';
        }
        if (enteredDate.isAfter(maxAgeDate)) {
          return 'You must be at least 5 years old.';
        }

        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date of Birth', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildMonthDropdown()),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDateField(
                    controller: _dayController,
                    focusNode: _dayFocus,
                    nextNode: _yearFocus,
                    label: 'Day',
                    maxLength: 2,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDateField(
                    controller: _yearController,
                    focusNode: _yearFocus,
                    label: 'Year',
                    maxLength: 4,
                    isLast: true,
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMonthDropdown() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(labelText: 'Month'),
      value: _selectedMonth,
      items: List.generate(12, (index) {
        return DropdownMenuItem(value: index + 1, child: Text(months[index]));
      }),
      onChanged: (value) {
        setState(() {
          _selectedMonth = value;
        });
      },
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextNode,
    required String label,
    required int maxLength,
    bool isLast = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: label,
        counterText: '', // Hide the counter
      ),
      onChanged: (value) {
        setState(() {}); // Trigger rebuild to re-validate
        if (value.length == maxLength && nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
        if (isLast && value.length == maxLength) {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }
}
