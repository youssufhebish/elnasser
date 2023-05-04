import 'package:country_code_picker/country_code_picker.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/contat_us/contact_us_bloc/contact_us_cubit.dart';
import 'package:elnasser/screens/initial_pages/login/login_bloc/login_cubit.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:flutter/material.dart';

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountryCodePicker(
          onChanged: (value) {
            LoginCubit.get(context).getCountryCode(value.dialCode.toString());
            ContactUsCubit.get(context).getCountryCode(value.dialCode.toString());
            SmsCubit.get(context).getCountryCode(value.dialCode.toString());
            AddressCubit.get(context).getCountryCode(value.dialCode.toString());
          },

          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'EG',
          favorite: ['+20', 'EG'],
          // optional. Shows only country name and flag
          showCountryOnly: true,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: false,
          enabled: false,
          flagWidth: 20,
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
