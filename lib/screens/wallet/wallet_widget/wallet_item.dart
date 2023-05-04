import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/wallet_model/Wallet_model.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/wallet/wallet_data_provider/wallet_methods.dart';
import 'package:elnasser/widget/image_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalletWidgetItem extends StatelessWidget {
  const WalletWidgetItem(
      {Key? key, required this.colorsValue, required this.clientOperations})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final List<ClientWalletOperation> clientOperations;
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: clientOperations.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.h,
                  width: 5.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: WalletMethods().getColor(
                          "${clientOperations[index].clientWalletOperationsType}")),
                  child: ImageView(
                    path: WalletMethods().getImage(
                        "${clientOperations[index].clientWalletOperationsType}")!,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 10.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment:
                    // MainAxisAlignment
                    //     .spaceAround,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomText(
                        text: clientOperations[index]
                                    .clientWalletOperationsType ==
                                "order"
                            ? "${"${WalletMethods().getType("${clientOperations[index].clientWalletOperationsType}")}".tr().toString()}. ${clientOperations[index].order!.ordersNo!}"
                            : "${"${WalletMethods().getType("${clientOperations[index].clientWalletOperationsType}")}".tr().toString()}",
                        style: TextStyleConstant.bodyText(context, colorsValue),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: SizeDataConstant.customWidth(context, 1.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: WalletMethods().convertDate(
                                  "${clientOperations[index].clientWalletOperationsCreatedAt}"),
                              style: TextStyleConstant.optionalText(
                                  context, colorsValue),
                            ),
                            CustomText(
                              text:
                                  "${clientOperations[index].clientWalletOperationsValue} ${SplashCubit.get(context).theInitialModel.data!.setting!.settingsCurrency}",
                              style: TextStyleConstant.bodyTextGrey(
                                      context, colorsValue)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        });
  }
}
