import 'package:dio/dio.dart';
import 'package:elnasser/models/notification_model.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit_state.dart';
import 'package:elnasser/screens/notification/notification_data_provider/notification_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationCubitState> {
  NotificationCubit() : super(NotificationCubitStateInitial());

  static NotificationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  int x = 0;
  NotificationModel notificationModel = NotificationModel();
  Future<void> getNotification(BuildContext context) async {
    emit(NotificationCubitStateLoading());

    Response? response = await NotificationDataProvider.getNotification(
        context: context, pageIndex: 1);

    if (response!.data["status"] == 200) {
      x = 0;
      notificationModel = NotificationModel.fromJson(response.data);
      print(notificationModel.data!.notifications!.length);
      print("Data Noification ##");
      print("${response.data["status"]}");
      notificationModel.data!.notifications!.forEach((element) {
        if (element.readAt == null) {
          x++;
        }
      });
      emit(NotificationCubitStateSuccess());
    } else {
      emit(NotificationCubitStateFail());
    }
  }

  changeCounter() {
    x = 0;
    emit(NotificationCubitStateReset());
  }
}
