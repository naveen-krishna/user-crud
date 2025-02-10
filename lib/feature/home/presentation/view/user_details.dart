import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/presentation/widget/date_picker_textfield.dart';
import 'package:product_listing/feature/home/presentation/widget/role_selection_dropdown.dart';

class UserDetailsScreen extends StatelessWidget {
  final ProductEntity? product;
  UserDetailsScreen({super.key, required this.product});

  TextEditingController _nameController = TextEditingController();

  TextEditingController _roleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {
                // Create a new user with a first and last name
                final user = <String, dynamic>{
                  "name": _nameController.text,
                  "role": _roleController.text,
                  "start-date": dateController.text,
                  "end-date": dateController.text,
                };
// Add a new document with a generated ID
                db.collection("users").add(user).then((DocumentReference doc) =>
                    print('DocumentSnapshot added with ID: ${doc.id}'));
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
              product?.title ?? "",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            TextField(
              controller: _nameController,
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
              controller: _roleController,
              onValueSelected: (value) {
                print("Selected Role: $value");
              },
            ),
            const SizedBox(height: 16.0),

            DatePickerTextField(
              controller: dateController,
              onDateSelected: (date) {
                print("Selected Date: ${date.toIso8601String()}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
