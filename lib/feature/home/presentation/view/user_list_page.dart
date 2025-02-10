import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/di/injection_container.dart';
import 'package:product_listing/feature/home/presentation/bloc/home_bloc.dart';
import 'package:product_listing/feature/home/presentation/view/user_list_screen.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("HomeScaffoldGestureDetector"),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => HomeBloc(
              getUsersDataUsecase: sl(),
              deleteUserDataUsecase: sl(),
            ),
            child: const UserListScreen(),
          ),
        ),
      ),
    );
  }
}
