import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/shared_prefrance_constant.dart';
import 'package:elnasser/helpers/shared_prefrance.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_bloc.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_bloc_event.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_bloc_state.dart';
import 'package:elnasser/screens/category_products/category_products_bloc/category_products_cubit.dart';
import 'package:elnasser/screens/category_products/category_products_screen.dart';
import 'package:elnasser/screens/product_details/product_details_bloc/prodct_details_slider_cubit.dart';

import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_event.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_bloc/search_tiltle_bloc_state.dart';
import 'package:elnasser/screens/search_tiltle_screen/search_tiltle_screen.dart';
import 'package:elnasser/widget/search_widget/search_widget_bloc/search_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SharedMethods {
  static convertDate(String date) {
    DateTime localDate = DateTime.parse(date).toLocal();
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse("$localDate").toLocal();
    var inputDate = DateTime.parse(parseDate.toString()).toLocal();
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate).toLocale();
    return outputDate;
  }

  static Future<List<String>> getDeviceDetails() async {
    String? deviceName;
    String? deviceVersion;
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model!;
        deviceVersion = build.version.toString();
        identifier = build.androidId!;
        PreferenceUtils.storeDataToPreferences(deviceId, identifier);

        print("identifier: $identifier");
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name!;
        deviceVersion = data.systemVersion!;
        identifier = data.identifierForVendor!;
        PreferenceUtils.storeDataToPreferences(deviceId, identifier);
        //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return [deviceName!, deviceVersion!, identifier!];
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static goForwardMethod(
      {required String? type,
      required String? value,
      required BuildContext context,
      required String? url,
      required ColorsInitialValue colorsValue,
      required TheInitialModel theInitialModel}) {
    print(value);
    print(type);

    if (value == null && url == null) {
    } else {
      if (type != null) {
        switch (type) {
          case "product":
            ProductDetailsSliderCubit.get(context)
                .getProduct(context, int.parse("${value}"));

            break;
          case "filter":
            SearchWidgetCubit.get(context).getSearchText(value!);
            context
                .read<SearchResultTitleBloc>()
                .emit(SearchResultTitleBlocState(context: context));

            context.read<SearchResultTitleBloc>().add(SearchResultTitleFetch());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchTitleResult(
                          colorsValue: colorsValue,
                          theInitialModel: theInitialModel,
                        )));
            break;
          case "category":
            CategoryProductsCubit.get(context).getCatID(value!);
            CategoryProductsCubit.get(context).getType("");
            context
                .read<CategoryProductsBloc>()
                .emit(CategoryProductsBlocState(context: context));
            // context.read<CategoryProductsBloc>()
            //     .add(CategoryProductsReset());
            context.read<CategoryProductsBloc>().add(CategoryProductsFetch());

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(
                          theInitialModel: theInitialModel,
                          colorsValue: colorsValue,
                        )));
            break;
        }
      } else {
        launchURL(url!);
      }
    }
  }

  static launchTel(String phone) async {
    String url = 'tel://${phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchWithURLWhats(String url) async {
    //const url = 'https://flutter.dev';
    var whatsappUrl = "whatsapp://send?phone=$url";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  static openCategory(
      {required BuildContext context,
      required String title,
      required String catId,
      required ColorsInitialValue colorsValue,
      required TheInitialModel theInitialModel}) {
    CategoryProductsCubit.get(context).getCatID(catId);
    CategoryProductsCubit.get(context).getType(title);
    context
        .read<CategoryProductsBloc>()
        .emit(CategoryProductsBlocState(context: context));
    // context.read<CategoryProductsBloc>()
    //     .add(CategoryProductsReset());
    context.read<CategoryProductsBloc>().add(CategoryProductsFetch());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(
                  theInitialModel: theInitialModel,
                  colorsValue: colorsValue,
                )));
  }

  static launchMap({required String lat, required String long}) async {
    var mapSchema =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving&dir_action=navigate';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }
}
