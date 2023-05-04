import 'package:dio/dio.dart';
import 'package:elnasser/models/question_model.dart';
import 'package:elnasser/screens/question/data_provider/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionStateInitial());

  static QuestionCubit get(BuildContext context) => BlocProvider.of(context);

  QuestionsModel questionsModel = QuestionsModel();

  Future<void> getQuestion(BuildContext context) async {
    emit(QuestionStateLoading());

    Response? response =
        await QuestionDataProvider.getQuestion(context: context);

    if (response!.statusCode == 200) {
      questionsModel = QuestionsModel.fromJson(response.data);
      emit(QuestionStateSuccess());
    } else {
      emit(QuestionStateFail());
    }
  }
}
