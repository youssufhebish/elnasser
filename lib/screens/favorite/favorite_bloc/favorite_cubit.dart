import 'package:dio/dio.dart';
import 'package:elnasser/models/favorite/favorite_model.dart';

import 'package:elnasser/screens/Favorite/favorite_data_provider/favorite_data_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteStateInitial());
  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addToFavorite(
      {required BuildContext context, required String productId}) async {
    emit(FavoriteStateAddLoading());

    Response? response = await FavoriteDataProvider.addToFavoriteApi(
        context: context, id: productId);

    if (response!.data["status"] == 200) {
      // HomeMobileCubit.get(context).getMobileHome(context);
      // context.read<NewArrivalBloc>().add(NewArrivalReset());
      // context.read<NewArrivalBloc>().add(NewArrivalFetch());
      // context.read<BestSalesBloc>().add(BestSalesReset());
      // context.read<BestSalesBloc>().add(BestSalesFetch());
      // context.read<SpecialProductsBloc>().add(SpecialProductsReset());
      // context.read<SpecialProductsBloc>().add(SpecialProductsFetch());
      // getFavorite(context:context);
      emit(FavoriteStateAddingSuccess());
    } else {
      emit(FavoriteStateAddFail());
    }
  }

  FavoriteModelClass favoriteModel = FavoriteModelClass();
  Future<void> getFavorite({required BuildContext context}) async {
    emit(FavoriteStateGetLoading());

    Response? response =
        await FavoriteDataProvider.getFavorite(context: context);

    if (response!.data["status"] == 200) {
      favoriteModel = FavoriteModelClass.fromJson(response.data);
      emit(FavoriteStateGetSuccess());
    } else {
      emit(FavoriteStateGetFail());
    }
  }
}
