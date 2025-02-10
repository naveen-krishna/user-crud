import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/constants/app_colors.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:product_listing/feature/user_details/presentation/widget/date_picker_textfield.dart';
import 'package:product_listing/feature/user_details/presentation/widget/role_selection_dropdown.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserEntity? user;
  final bool editing;
  UserDetailsScreen({super.key, required this.user, this.editing = false});

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
          //return result to previous screen true/  false
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.lightBlue,
          title: const Text('User Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        persistentFooterButtons: [
          Row(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.color_1DA1F2,
                  backgroundColor: AppColors.color_EDF8FF,
                  minimumSize: const Size(80, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  side: const BorderSide(
                    width: 1.0,
                    color: AppColors.color_EDF8FF,
                  ),
                ),
                child: const Text("Cancel"),
              ),
              OutlinedButton(
                onPressed: () async {
                  if (widget.editing) {
                    userDetailsBloc
                        .add(UpdateUserEvent(userId: widget.user!.id!));
                  } else {
                    userDetailsBloc.add(CreateUserEvent());
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.color_1DA1F2,
                  minimumSize: const Size(80, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  side: const BorderSide(
                    width: 1.0,
                    color: AppColors.color_EDF8FF,
                  ),
                ),
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
                  labelText: "Full Name",
                  hintText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  print("Entered Name: $value");
                },
              ),
              const SizedBox(height: 16.0),
              RoleSelectionDropdown(
                controller: userDetailsBloc.roleController,
                onValueSelected: (value) {
                  print("Selected Role: $value");
                },
              ),
              const SizedBox(height: 16.0),
              DatePickerTextField(
                controller: userDetailsBloc.dateController,
                onDateSelected: (date) {
                  print("Selected Date: ${date.toIso8601String()}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
