import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/screens/Favorite/favorite_bloc/favorite_cubit.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/beanches/branches_bloc/branches_cubit.dart';
import 'package:elnasser/screens/best_sales/best_sales_bloc/best_sales_bloc.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/categories/category_bloc/category_cubit.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_cubit.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/filter/filter_bloc/filter_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password_bloc/forget_password_cubit.dart';
import 'package:elnasser/screens/initial_pages/login/login_bloc/login_cubit.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_screen.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_bloc.dart';
import 'package:elnasser/screens/notification/notification_bloc/notification_cubit.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/points_screen/point_bloc/point_cubit.dart';
import 'package:elnasser/screens/question/question_bloc/question_cubit.dart';
import 'package:elnasser/screens/rating/rating_bloc/rating_bloc.dart';
import 'package:elnasser/screens/search_result_filter/search_result_bloc/search_result_filter_event.dart';
import 'package:elnasser/screens/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:elnasser/services/google_service/google_cubit.dart';
import 'package:elnasser/widget/card/card_bloc/card_cubit.dart';
import 'package:elnasser/widget/search_widget/search_widget_bloc/search_widget_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';

import 'helpers/connection_bloc/connection_cubit.dart';
import 'screens/categories/category_bloc/sup_category_cubit.dart';
import 'screens/category_products/category_products_bloc/category_products_bloc.dart';
import 'screens/contat_us/contact_us_bloc/contact_us_cubit.dart';
import 'screens/initial_pages/register/register_bloc/register_cubit.dart';
import 'screens/new_arrival_screen/new_arrival_bloc/new_arrival_bloc.dart';
import 'screens/notify_me/notify_me_bloc/notify_me_cubit.dart';
import 'screens/offers/offer_bloc/offer_event.dart';
import 'screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';
import 'screens/product_details/product_details_bloc/product_details_suggestion_cubit.dart';
import 'screens/rate_order/ratin_oredr_bloc/rating_order_bloc.dart';
import 'screens/rating/rating_bloc/rating_cubit.dart';
import 'screens/search_result_filter/search_result_bloc/search_result_filter_bloc.dart';
import 'screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc.dart';
import 'screens/special_products_screen/special_products_bloc/special_products_bloc.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel("id", "name", importance: Importance.max, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> fetchNotifiction(BuildContext context) async {
  await Future.delayed(Duration.zero, () {
    NotificationCubit.get(context).getNotification(context);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
}

quicSort(List list) {
  if (list.length <= 1) {
    return list;
  }
  String piovt = list.first;
  List lessThanPivot = [];
  List greatThanPivot = [];

  list.sublist(1).forEach((elemnt) {
    if (elemnt.toString().codeUnitAt(0) <= piovt.toString().codeUnitAt(0)) {
      lessThanPivot.add(elemnt);
    } else {
      greatThanPivot.add(elemnt);
    }
  });

  return quicSort(lessThanPivot) + [piovt] + quicSort(greatThanPivot);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  Bloc.observer = BlocObserver();
  SharedMethods.getDeviceDetails();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print(quicSort(["ziad", "ali", "omar", "mohamed"]));

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  ///
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'EN'),
      Locale('ar', 'EG'),
    ],
    path: 'assets/langs',
    saveLocale: true,
    child: MyApp(
      connectivity: Connectivity(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({required this.connectivity});
  // This widget is the root of your application.
  final Connectivity connectivity;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SplashCubit>(
            create: (context) => SplashCubit(context),
          ),
          RepositoryProvider<ConnectionCubit>(
            create: (context) => ConnectionCubit(connectivity: widget.connectivity, context: context),
          ),
          RepositoryProvider<SmsCubit>(
            create: (context) => SmsCubit(),
          ),
          RepositoryProvider<RegisterCubit>(
            create: (context) => RegisterCubit(),
          ),
          RepositoryProvider<CompletePaymentCubit>(
            create: (context) => CompletePaymentCubit(context),
          ),
          RepositoryProvider<AddressCubit>(
            create: (context) => AddressCubit(context),
          ),
          RepositoryProvider<FilterCubit>(
            create: (context) => FilterCubit(),
          ),
          RepositoryProvider<SearchWidgetCubit>(
            create: (context) => SearchWidgetCubit(),
          ),
          RepositoryProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
          RepositoryProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
          RepositoryProvider<HomeMobileCubit>(
            create: (context) => HomeMobileCubit(context)..getData(context),
          ),
          RepositoryProvider<AddToCartCubit>(
            create: (context) => AddToCartCubit(),
          ),
          RepositoryProvider<CategoryProductsCubit>(
            create: (context) => CategoryProductsCubit(),
          ),
          RepositoryProvider<CategoryListCubit>(
            create: (context) => CategoryListCubit(),
          ),
          RepositoryProvider<CardCubit>(
            create: (context) => CardCubit(),
          ),
          RepositoryProvider<BranchesCubit>(
            create: (context) => BranchesCubit(),
          ),
          RepositoryProvider<NotifyMeCubit>(
            create: (context) => NotifyMeCubit(),
          ),
          RepositoryProvider<BestSalesBloc>(
            create: (context) => BestSalesBloc(context),
          ),
          RepositoryProvider<CategoryProductsBloc>(
            create: (context) => CategoryProductsBloc(context),
          ),
          RepositoryProvider<SearchResultBloc>(
            create: (context) => SearchResultBloc(context)..add(SearchResultFetchFilter()),
          ),
          RepositoryProvider<WalletBloc>(
            create: (context) => WalletBloc(context),
          ),
          RepositoryProvider<SearchResultTitleBloc>(
            create: (context) => SearchResultTitleBloc(context),
          ),
          RepositoryProvider<NewArrivalBloc>(
            create: (context) => NewArrivalBloc(context),
          ),
          RepositoryProvider<OfferBloc>(
            create: (context) => OfferBloc(context)..add(OfferFetch()),
          ),
          RepositoryProvider<SpecialProductsBloc>(
            create: (context) => SpecialProductsBloc(context),
          ),
          RepositoryProvider<OrderBloc>(
            create: (context) => OrderBloc(context),
          ),
          RepositoryProvider<NotificationBloc>(
            create: (context) => NotificationBloc(context),
          ),
          RepositoryProvider<RatingBloc>(
            create: (context) => RatingBloc(context),
          ),
          RepositoryProvider<RatingCubit>(
            create: (context) => RatingCubit(),
          ),
          RepositoryProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(),
          ),
          RepositoryProvider<NotificationCubit>(
            create: (context) => NotificationCubit(),
          ),
          RepositoryProvider<SupCategoryCubit>(
            create: (context) => SupCategoryCubit(),
          ),
          RepositoryProvider<FavoriteCubit>(
            create: (context) => FavoriteCubit(),
          ),
          RepositoryProvider<OrderCubit>(
            create: (context) => OrderCubit(),
          ),
          RepositoryProvider<EditUserCubit>(
            create: (context) => EditUserCubit(context),
          ),
          RepositoryProvider<PointCubit>(
            create: (context) => PointCubit(),
          ),
          RepositoryProvider<RatingOrderCubit>(
            create: (context) => RatingOrderCubit(),
          ),
          RepositoryProvider<GoogleServiceCubit>(
            create: (context) => GoogleServiceCubit(),
          ),
          RepositoryProvider<ProductDetailsSliderCubit>(
            create: (context) => ProductDetailsSliderCubit(),
          ),
          RepositoryProvider<ProductDetailsSuggestionCubit>(
            create: (context) => ProductDetailsSuggestionCubit(),
          ),
          RepositoryProvider<ContactUsCubit>(
            create: (context) => ContactUsCubit()..getData(),
          ),
          RepositoryProvider<QuestionCubit>(
            create: (context) => QuestionCubit(),
          ),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const SplashScreen(),
            );
          },
        ));
  }
}
