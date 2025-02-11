import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_listing/core/constants/app_colors.dart';
import 'package:product_listing/core/constants/style_constants.dart';

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

String seleted = 'Today';

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
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                width: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: AppColors.color_1DA1F2,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _selectedDate != null
                                    ? _dateFormat.format(_selectedDate!)
                                    : _dateFormat.format(initialDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: StyleConstants.secondaryButtonStyle,
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton(
                                onPressed: () {
                                  if (_selectedDate != null) {
                                    _setDate(_selectedDate!);
                                    Navigator.pop(context);
                                  }
                                },
                                style: StyleConstants.primaryButtonStyle,
                                child: const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 14),
                                ),
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
    return Column(
      spacing: 8.0,
      children: [
        Row(
          spacing: 12.0,
          children: [
            _buildButton("Today", DateTime.now(), setDialogState, forceRebuild),
            _buildButton("Next Monday", _nextWeekday(DateTime.monday),
                setDialogState, forceRebuild),
          ],
        ),
        Row(
          spacing: 12.0,
          children: [
            _buildButton("Next Tuesday", _nextWeekday(DateTime.tuesday),
                setDialogState, forceRebuild),
            _buildButton("After 1 week", DateTime.now().add(Duration(days: 7)),
                setDialogState, forceRebuild),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(
      String text,
      DateTime date,
      void Function(void Function()) setDialogState,
      VoidCallback forceRebuild) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          seleted = text;
          setDialogState(() {
            _selectedDate = date;
            forceRebuild();
          });
        },
        style: seleted == text
            ? StyleConstants.primaryButtonStyle
            : StyleConstants.secondaryButtonStyle,
        child: Text(text),
      ),
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
        prefixIcon: const Icon(
          Icons.today_outlined,
          color: AppColors.color_1DA1F2,
        ),
        hintText: "Select Date",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.color_E5E5E5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.color_E5E5E5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.color_E5E5E5),
        ),
      ),
    );
  }
}
