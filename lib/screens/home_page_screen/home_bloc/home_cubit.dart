import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/categories/categories.dart';
import 'package:elnasser/screens/filter/filter.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mopWidget/home_screen_widget.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_screen.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc_state.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_event.dart';
import 'package:elnasser/screens/offers/offers.dart';
import 'package:elnasser/screens/personal_data/personal_data.dart';
import 'package:elnasser/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoadingState()) {
    getData();
    controller = AutoScrollController();
  }
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool showSearch = false;
  void changeHomePage(int index, BuildContext context) {
    currentIndex = index;
    showSearch = false;
    if (index == 0) {
      // HomeMobileCubit.get(context).getMobileHome(context);
    }
    emit(HomeChangeBottomNavState());
  }

  // TheInitialModel theInitialModel = TheInitialModel();
  getData() async {
    // PreferenceUtils.getDataFromPreferences(initialData).then((value) {
    //   print(value);
    //
    //   theInitialModel = TheInitialModel.fromJson(jsonDecode(value!));
    // });

    emit(HomePreferenceState());
  }

  showSearchEmit(BuildContext context) {
    showSearch = true;
    emit(ShowSearchState());
  }

  List<Widget> homeWidget(ColorsInitialValue colorsInitialValue) => [
        HomeMopScreenWidget(
          colorsValue: colorsInitialValue,
        ),
        CategoriesScreen(
          colorsValue: colorsInitialValue,
        ),
        OffersScreen(
          colorsValue: colorsInitialValue,
        ),

        // FilterScreen(colorsValue: colorsInitialValue,),
        PersonalDataScreen(
          colorsValue: colorsInitialValue,
        ),
        supportScreen(
          colorsValue: colorsInitialValue,
        ),
      ];

  /// web cubit funcation ///
  late AutoScrollController controller;

  int firstListIndex = 3;

  goToNext() async {
    if (firstListIndex < 9) {
      firstListIndex++;
      await controller
          .scrollToIndex(firstListIndex, preferPosition: AutoScrollPosition.end)
          .whenComplete(() => print(firstListIndex));
      emit(HomeWebNextIndexState());
    }
  }

  goToPrevious() async {
    if (firstListIndex != 0 && firstListIndex > 3) {
      firstListIndex--;
      await controller
          .scrollToIndex(firstListIndex, preferPosition: AutoScrollPosition.end)
          .whenComplete(() => print(firstListIndex));
      emit(HomeWebPreviousIndexState());
    }
  }

  bool showCatValue = false;
  showCat() async {
    showCatValue = !showCatValue;
    emit(HomeWebShowCatState());
  }

  /// Language /////
//   getCurrentLanguage(BuildContext context){
//     if(EasyLocalization.of(context)!.currentLocale!.languageCode =="en"){
//       isArabic =false;
//       isEnglish =true;
//     }else{
//       isArabic =true;
//       isEnglish =false;
//     }
//     emit(HomeChangeLanguageValue());
//
//   }
  bool isArabic = false;
  bool isEnglish = false;
  changeLanguage({required String type, required BuildContext context}) {
    switch (type) {
      case "arabic":
        EasyLocalization.of(context)!.setLocale(Locale('ar', 'EG'));
        print(EasyLocalization.of(context)!.currentLocale!.languageCode);
        emit(HomeChangeLanguage());
        isArabic = true;
        isEnglish = false;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));

        break;
      case "english":
        EasyLocalization.of(context)!.setLocale(Locale('en', 'EN'));
        print(EasyLocalization.of(context)!.currentLocale!.languageCode);
        emit(HomeChangeLanguage());
        isArabic = false;
        isEnglish = true;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
        break;
    }
  }
}
