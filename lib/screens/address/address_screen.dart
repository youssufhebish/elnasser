import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/widget/address_list_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  @override
  Widget build(BuildContext context) {
    EditUserCubit.get(context).getData(context);
    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      print('Current State $state');
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: CustomText(
                  text: "address".tr().toString(),
                  style: TextStyleConstant.headerText(context, colorsValue),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: AddressListWidget(
                  colorsValue: colorsValue,
                  showDeleteIcon: true,
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // AddressCubit.get(context).getData();
        // AddressCubit.get(context).getAddressAndPaymentMethods(context);
      }
    });
  }
}
