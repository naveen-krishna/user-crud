import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/constants/app_colors.dart';
import 'package:product_listing/core/constants/style_constants.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:product_listing/feature/user_details/presentation/widget/date_picker_textfield.dart';
import 'package:product_listing/feature/user_details/presentation/widget/role_selection_bottomsheet.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserEntity? user;
  final bool editing;
  const UserDetailsScreen(
      {super.key, required this.user, this.editing = false});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserDetailsBloc get userDetailsBloc => context.read<UserDetailsBloc>();

  @override
  void initState() {
    if (widget.user != null) {
      userDetailsBloc.add(InitUserEvent(user: widget.user!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        if (state is UserCreatedState || state is UserUpdatedState) {
          //return false to previous screen when not deleting
          Navigator.pop(context, false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlue,
          title: Text(
            widget.editing ? 'Edit Employee Details' : 'Add Employee Details',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            if (widget.editing)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
          ],
        ),
        persistentFooterButtons: [
          Row(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: StyleConstants.secondaryButtonStyle,
                child: const Text("Cancel"),
              ),
              OutlinedButton(
                onPressed: () async {
                  if (userDetailsBloc.nameController.text.isNotEmpty &&
                      userDetailsBloc.roleController.text.isNotEmpty) {
                    if (widget.editing) {
                      userDetailsBloc
                          .add(UpdateUserEvent(userId: widget.user!.id!));
                    } else {
                      userDetailsBloc.add(CreateUserEvent());
                    }
                  } else {
                    if (userDetailsBloc.nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter name')));
                    } else if (userDetailsBloc.roleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select role')));
                    }
                  }
                },
                style: StyleConstants.primaryButtonStyle,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              TextField(
                controller: userDetailsBloc.nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "Employee name",
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: AppColors.color_1DA1F2,
                  ),
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
                onChanged: (value) {
                  print("Entered Name: $value");
                },
              ),
              const SizedBox(height: 16.0),
              RoleSelectionBottomSheet(
                controller: userDetailsBloc.roleController,
                onValueSelected: (value) {
                  print("Selected Role: $value");
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DatePickerTextField(
                      controller: userDetailsBloc.startDateController,
                      onDateSelected: (date) {
                        print("Selected Date: ${date.toIso8601String()}");
                      },
                      endDate: false,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: AppColors.color_1DA1F2,
                    ),
                  ),
                  Expanded(
                    child: DatePickerTextField(
                      controller: userDetailsBloc.endDateController,
                      onDateSelected: (date) {
                        print("Selected Date: ${date.toIso8601String()}");
                      },
                      endDate: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
