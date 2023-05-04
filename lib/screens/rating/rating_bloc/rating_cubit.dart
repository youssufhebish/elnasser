import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/models/error_model.dart';
import 'package:elnasser/models/rating/add_rating.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_cubit_state.dart';
import 'package:elnasser/screens/rating/rating_provider/rating_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingCubit extends Cubit<RatingCubitState> {
  RatingCubit() : super(RatingCubitStateInitial());

  static RatingCubit get(BuildContext context) => BlocProvider.of(context);

  double quality = 0.0;
  double price = 0.0;
  double size = 0.0;
  double match = 0.0;

  TextEditingController rateNotes = TextEditingController();

  getSize(double sizeValue) {
    size = sizeValue;
    emit(RatingCubitStateGetSize());
  }

  getQuality(double qualityValue) {
    quality = qualityValue;
    emit(RatingCubitStateGetQuality());
  }

  getPrice(double priceValue) {
    price = priceValue;
    emit(RatingCubitStateGetPrice());
  }

  getMatch(double matchValue) {
    match = matchValue;
    emit(RatingCubitStateGetMatch());
  }

  ErrorModel errorModel = ErrorModel();

  Future<void> addRatingMethod(
      {required BuildContext context, required String orderId}) async {
    emit(RatingCubitStateAddLoading());
    AddRatingModel addRatingModel = AddRatingModel();
    addRatingModel.accountId = Commons.accountId;
    addRatingModel.ratings_text = rateNotes.text;
    addRatingModel.ratings_match_picture = match;
    addRatingModel.ratings_price = price;
    addRatingModel.products_id = orderId;
    addRatingModel.ratings_quality = quality;
    addRatingModel.ratings_size = size;

    Loader.showLoader(context);
    Response? response = await RatingDataProvider.addRating(
        context: context, addRatingModel: addRatingModel);

    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        size = 0.0;
        price = 0.0;
        quality = 0.0;
        match = 0.0;
        rateNotes.clear();
        Loader.hideLoader(context);

        emit(RatingCubitStateAddSuccess());
      } else {
        errorModel = ErrorModel.fromJson(response.data);
        Loader.hideLoader(context);
        emit(RatingCubitStateAddFail());
      }
    } else {
      Loader.hideLoader(context);
      emit(RatingCubitStateAddFail());
    }
  }
}
