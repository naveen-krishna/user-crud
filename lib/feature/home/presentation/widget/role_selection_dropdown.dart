import 'package:flutter/material.dart';

class RoleSelectionDropdown extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onValueSelected;

  const RoleSelectionDropdown({
    Key? key,
    required this.controller,
    this.onValueSelected,
  }) : super(key: key);

  @override
  _RoleSelectionDropdownState createState() => _RoleSelectionDropdownState();
}

class _RoleSelectionDropdownState extends State<RoleSelectionDropdown> {
  final List<String> _options = ["Product Manager", "Flutter Developer", "QA"];

  void _showDropdownMenu(BuildContext context) async {
    String? selectedValue = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(50, 100, 50, 0),
      items: _options.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    if (selectedValue != null) {
      setState(() {
        widget.controller.text = selectedValue;
      });
      widget.onValueSelected?.call(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _showDropdownMenu(context),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down),
        hintText: "Select Role",
        border: OutlineInputBorder(),
      ),
    );
  }
}
