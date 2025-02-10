import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/feature/home/presentation/bloc/home_bloc.dart';
import 'package:product_listing/feature/user_details/presentation/view/user_details_page.dart';
import 'package:product_listing/feature/user_details/presentation/view/user_details_screen.dart';
import 'package:product_listing/feature/user_details/presentation/widget/date_picker_textfield.dart';
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
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const UserDetailsPage(user: null)),
            );

            getBloc.add(FetchProductsEvent());
          },
          icon: const Icon(Icons.add)),
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
            if (state.users?.isNotEmpty ?? false) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.users?.length,
                  itemBuilder: (context, index) {
                    final user = state.users?[index];

                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(user?.id ?? ""),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) async {
                        // Remove the item from the data source.

                        final db = FirebaseFirestore.instance;

                        await db
                            .collection("users")
                            .doc('${user?.id}')
                            .delete();

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${user?.name} deleted')));
                      },

                      background: Container(
                        color: Colors.red,
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete)),
                      ),
                      child: UserCard(
                        user: user,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => UserDetailsPage(
                                      user: user,
                                      editing: true,
                                    )),
                          );
                        },
                      ),
                    );
                  });
            } else {
              return Column(
                children: [
                  Text("No Data"),
                ],
              );
            }
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
