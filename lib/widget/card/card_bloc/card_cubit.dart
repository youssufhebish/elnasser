import 'package:elnasser/widget/card/card_bloc/card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(ExitHoverState()) {
    controller = AutoScrollController();
  }

  static CardCubit get(BuildContext context) => BlocProvider.of(context);
  bool show = false;

  void showHover(bool value) {
    show = value;
    emit(ShowHoverState());
  }

  void closeHover(bool value) {
    show = value;
    emit(ExitHoverState());
  }

  void showMenu(bool value) {
    show = value;
    emit(ShowMenuState());
  }

  /// web cubit funcation ///
  late AutoScrollController controller;

  int firstListIndex = 3;

  goToNext() async {
    if (firstListIndex < 9) {
      firstListIndex++;
      await controller
          .scrollToIndex(firstListIndex, preferPosition: AutoScrollPosition.end)
          .whenComplete(() => print(firstListIndex));
      emit(CardWebNextIndexState());
    }
  }

  goToPrevious() async {
    if (firstListIndex != 0 && firstListIndex > 3) {
      firstListIndex--;
      await controller
          .scrollToIndex(firstListIndex, preferPosition: AutoScrollPosition.end)
          .whenComplete(() => print(firstListIndex));
      emit(CardWebPreviousIndexState());
    }
  }
}
