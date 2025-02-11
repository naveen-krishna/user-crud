import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/di/injection_container.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:product_listing/feature/user_details/presentation/view/user_details_screen.dart';

class UserDetailsPage extends StatelessWidget {
  final UserEntity? user;
  final bool editing;
  const UserDetailsPage({super.key, this.user, this.editing = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("UserDetailsPageScaffoldGestureDetector"),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocProvider(
          create: (context) => UserDetailsBloc(
            createUsersDataUsecase: sl(),
            updateUsersDataUsecase: sl(),
          ),
          child: UserDetailsScreen(
            user: user,
            editing: editing,
          ),
        ),
      ),
    );
  }
}
