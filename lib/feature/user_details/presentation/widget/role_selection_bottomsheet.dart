import 'package:flutter/material.dart';
import 'package:product_listing/core/constants/app_colors.dart';

class RoleSelectionBottomSheet extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onValueSelected;

  const RoleSelectionBottomSheet({
    Key? key,
    required this.controller,
    this.onValueSelected,
  }) : super(key: key);

  @override
  _RoleSelectionBottomSheetState createState() =>
      _RoleSelectionBottomSheetState();
}

class _RoleSelectionBottomSheetState extends State<RoleSelectionBottomSheet> {
  final List<String> _options = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._options.map((role) => ListTile(
                    title: Center(child: Text(role)),
                    onTap: () {
                      widget.controller.text = role;

                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _showBottomSheet(context),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        prefixIcon: Icon(
          Icons.work_outline,
          color: AppColors.color_1DA1F2,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.color_1DA1F2,
        ),
        hintText: "Select Role",
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
