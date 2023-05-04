import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/add_new_address.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/address/address_bloc/address_state.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/edit_user/change_phone.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobile_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'addres_item.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget(
      {Key? key, required this.colorsValue, required this.showDeleteIcon})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final bool showDeleteIcon;

  @override
  Widget build(BuildContext context) {
    print(EditUserCubit.get(context).customer.customersPhone);
    return Column(
      children: [
        SizedBox(
          height: EditUserCubit.get(context).customer.customersPhone != null
              ? 8
              : 8.h,
        ),
        EditUserCubit.get(context).customer.customersPhone != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  color: ColorsConstant.getColorBorder1(colorsValue),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNewAddress(
                                        colorsValue: colorsValue,
                                        edit: false,
                                      )));
                        },
                        child: Container(
                          height: 15.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color:
                                    ColorsConstant.getColorText1(colorsValue),
                              ),
                              CustomText(
                                  text: "addNewAddress".tr().toString(),
                                  style: TextStyleConstant.bodyText(
                                      context, colorsValue)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : AppButton(
                colorsInitialValue: colorsValue,
                color: ColorsConstant.getColorBackground3(colorsValue),
                textStyle: TextStyleConstant.buttonText(context, colorsValue),
                title: "addPhoneNumber".tr().toString(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePhone(
                                theInitialModel:
                                    SplashCubit.get(context).theInitialModel,
                              )));
                }),
        BlocConsumer<AddressCubit, AddressState>(
          builder: (context, state) {
            print("MYCurrentstate:$state");

            if ((state != AddressStateAddressLoading ||
                    state != AddressStateAddressFail ||
                    state != AddressStateShared) &&
                AddressCubit.get(context).addressModel.data != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AddressCubit.get(context)
                      .addressModel
                      .data!
                      .addresses!
                      .length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          CompletePaymentCubit.get(context).getAddress(index);

                          AddressCubit.get(context).getAddress(index);
                        },
                        child: AddressItemWidget(
                          showDeleteIcon: showDeleteIcon,
                          currentIndex:
                              AddressCubit.get(context).currentAddressIndex,
                          colorsValue: colorsValue,
                          index: index,
                          address: AddressCubit.get(context)
                              .addressModel
                              .data!
                              .addresses![index],
                        ));
                  });
            } else {
              return SizedBox(
                height: 20.h,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AddressStateAddressSubmitSuccess ||
                state is AddressStateAddressDeleteSuccess ||
                state is AddressStateAddressEditSuccess) {
              AddressCubit.get(context).getAddressAndPaymentMethods(context);
            }
          },
        ),
      ],
    );
  }
}
