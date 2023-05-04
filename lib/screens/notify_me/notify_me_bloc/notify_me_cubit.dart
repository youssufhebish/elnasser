import 'package:dio/dio.dart';
import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/screens/notify_me/notfiy_me_data_provider/notify_me_data_provider.dart';
import 'package:elnasser/screens/notify_me/notify_me_bloc/notfy_me_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifyMeCubit extends Cubit<NotifyMeCubitState> {
  NotifyMeCubit() : super(NotifyMeCubitStateInitial());

  static NotifyMeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addToNotify(
      {required BuildContext context, required String productId}) async {
    emit(NotifyMeCubitStateLoading());
    Loader.showLoader(context);
    Response? response = await NotifyMeDataProvider.addToNotifyMe(
        context: context, id: productId);
    if (response!.statusCode == 200) {
      if (response.data["status"] == 200) {
        emit(NotifyMeCubitStateSuccess());
        Loader.hideLoader(context);
      } else {
        emit(NotifyMeCubitStateFail());
        Loader.hideLoader(context);
      }
    } else {
      emit(NotifyMeCubitStateFail());
      Loader.hideLoader(context);
    }
  }
}
