import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(DateTime)? onDateSelected;

  const DatePickerTextField({
    Key? key,
    required this.controller,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat("d MMM yyyy");

  void _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    _selectedDate ??= initialDate;

    await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            GlobalKey calendarKey = GlobalKey();

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Quick Selection Buttons
                      _quickSelectButtons(setDialogState, () {
                        calendarKey = GlobalKey();
                      }),

                      // Calendar with Month Navigation
                      SizedBox(
                        height: 300,
                        child: CalendarDatePicker(
                          key: calendarKey,
                          initialDate: _selectedDate ?? initialDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          onDateChanged: (date) {
                            setDialogState(() => _selectedDate = date);
                          },
                        ),
                      ),

                      // Selected Date Display & Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 18),
                              SizedBox(width: 5),
                              Text(
                                _selectedDate != null
                                    ? _dateFormat.format(_selectedDate!)
                                    : _dateFormat.format(initialDate),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_selectedDate != null) {
                                    _setDate(_selectedDate!);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("Save"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _quickSelectButtons(void Function(void Function()) setDialogState,
      VoidCallback forceRebuild) {
    return Wrap(
      spacing: 8.0,
      children: [
        _buildButton("Today", DateTime.now(), setDialogState, forceRebuild),
        _buildButton("Next Monday", _nextWeekday(DateTime.monday),
            setDialogState, forceRebuild),
        _buildButton("Next Tuesday", _nextWeekday(DateTime.tuesday),
            setDialogState, forceRebuild),
        _buildButton("After 1 week", DateTime.now().add(Duration(days: 7)),
            setDialogState, forceRebuild),
      ],
    );
  }

  Widget _buildButton(
      String text,
      DateTime date,
      void Function(void Function()) setDialogState,
      VoidCallback forceRebuild) {
    return ElevatedButton(
      onPressed: () {
        setDialogState(() {
          _selectedDate = date;
          forceRebuild();
        });
      },
      child: Text(text),
    );
  }

  DateTime _nextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilNext = (weekday - now.weekday + 7) % 7;
    return now.add(Duration(days: daysUntilNext == 0 ? 7 : daysUntilNext));
  }

  void _setDate(DateTime date) {
    String formattedDate = _dateFormat.format(date);
    widget.controller.text = formattedDate;
    widget.onDateSelected?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today),
        hintText: "Select Date",
        border: OutlineInputBorder(),
      ),
    );
  }
}
