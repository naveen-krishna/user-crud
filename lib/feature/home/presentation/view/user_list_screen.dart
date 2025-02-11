import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/feature/home/presentation/bloc/home_bloc.dart';
import 'package:product_listing/feature/user_details/presentation/view/user_details_page.dart';
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
    getBloc.add(FetchUsersEvent());
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

            getBloc.add(FetchUsersEvent());
          },
          icon: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: false,
        title: const Text(
          'Employee List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is UserDeletedState) {
            getBloc.add(FetchUsersEvent());
          }
        },
        builder: (context, state) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              print(state);
              if (state is LoadingState) {
                return const LoadingWidget();
              }
              if (state is FetchUsersState) {
                if (state.users?.isNotEmpty ?? false) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.users?.length,
                      itemBuilder: (context, index) {
                        final user = state.users?[index];

                        return Dismissible(
                          key: Key(user?.id ?? ""),
                          onDismissed: (direction) async {
                            getBloc
                                .add(DeleteUserEvent(userId: user?.id ?? ""));

                            // show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('${user?.name} deleted')));
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete)),
                          ),
                          child: UserCard(
                            user: user,
                            onTap: () async {
                              final delete = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => UserDetailsPage(
                                          user: user,
                                          editing: true,
                                        )),
                              );

                              if (delete == true) {
                                getBloc.add(
                                    DeleteUserEvent(userId: user?.id ?? ""));
                              } else {
                                getBloc.add(FetchUsersEvent());
                              }
                            },
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Image(image: AssetImage('assets/no_record.png')),
                  );
                }
              }
              return const Column(
                children: [
                  Text("Somthing went wrong!"),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
