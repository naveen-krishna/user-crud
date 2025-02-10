import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/feature/home/presentation/bloc/home_bloc.dart';
import 'package:product_listing/feature/home/presentation/view/user_details.dart';
import 'package:product_listing/feature/home/presentation/widget/date_picker_textfield.dart';
import 'package:product_listing/feature/home/presentation/widget/loading_widget.dart';
import 'package:product_listing/feature/home/presentation/widget/user_card.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  HomeBloc get getBloc => context.read<HomeBloc>();

  @override
  void initState() {
    getBloc.add(FetchProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(product: null)),
            );
          },
          icon: Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            return const LoadingWidget();
          }
          if (state is FetchProductsState) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.products?.length,
                itemBuilder: (context, index) {
                  final product = state.products?[index];

                  return UserCard(
                    product: product,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                UserDetailsScreen(product: product)),
                      );
                    },
                  );
                });
          }
          return Column(
            children: [
              Text("Error"),
            ],
          );
        },
      ),
    );
  }
}
