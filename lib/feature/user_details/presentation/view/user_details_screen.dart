import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/di/injection_container.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/presentation/bloc/home_bloc.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
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
          title: const Text('User Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Create a new user with a first and last name
                  final userData = <String, dynamic>{
                    "name": userDetailsBloc.nameController.text,
                    "role": userDetailsBloc.roleController.text,
                    "start-date": userDetailsBloc.dateController.text,
                    "end-date": userDetailsBloc.dateController.text,
                  };

                  if (widget.editing) {
                    userDetailsBloc.add(UpdateUserEvent(user: widget.user!));
                  } else {
                    userDetailsBloc.add(CreateUserEvent());
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              Text(
                widget.user?.name ?? "",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
