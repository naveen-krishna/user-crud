import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onTap;

  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user?.name ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      user?.role ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
