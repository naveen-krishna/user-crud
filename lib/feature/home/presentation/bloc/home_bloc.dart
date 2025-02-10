import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/usecase/get_users_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersDataUsecase getUsersDataUsecase;

  List<ProductEntity>? products;

  TextEditingController searchController = TextEditingController();
  HomeBloc({required this.getUsersDataUsecase}) : super(InitialState()) {
    on<FetchProductsEvent>((event, emitState) async {
      emitState(LoadingState());
      var users = await getUsersDataUsecase(NoParamsModel());
      users.fold((failure) {
        emitState(FetchErrorState(apiFailureModel: failure));
      }, (data) {
        emitState(FetchProductsState(users: data));
      });
    });

    // on<FetchSearchResultsEvent>((event, emitState) async {
    //   isLoading = true;
    //   emitState(LoadingState());
    //   if (event.isNewSearch == true) {
    //     searchDadJokeResultsEntity = null;
    //   }
    //   var searchDadJokeResult =
    //       await getSearchDadJokesUsecase(SearchDadJokeRequestModel(
    //     limit: event.limit,
    //     page: event.page,
    //     term: event.term,
    //   ));

    //   isLoading = false;
    //   SearchDadJokeResultsEntity? searchDadJokeResults;
    //   searchDadJokeResult.fold((failure) {
    //     emitState(FetchErrorState(apiFailureModel: failure));
    //   }, (data) {
    //     searchDadJokeResults = data;
    //     if (searchDadJokeResultsEntity == null) {
    //       searchDadJokeResultsEntity = searchDadJokeResults;
    //       emitState(HideLoadingState());
    //     } else {
    //       searchDadJokeResultsEntity!.results = [
    //         ...searchDadJokeResultsEntity!.results!,
    //         ...searchDadJokeResults!.results!,
    //       ];
    //       searchDadJokeResultsEntity!.currentPage =
    //           searchDadJokeResults!.currentPage;
    //       searchDadJokeResultsEntity!.totalPages =
    //           searchDadJokeResults!.totalPages;
    //       searchDadJokeResultsEntity!.nextPage = searchDadJokeResults!.nextPage;
    //     }
    //     emitState(FetchSearchResultsState());
    //   });
    // });
  }
}
