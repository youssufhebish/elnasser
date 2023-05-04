import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/initial_pages/confirm_code/confirm_code.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/country_code_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.theInitialModel, required this.title}) : super(key: key);
  final TheInitialModel? theInitialModel;
  final String title;
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneController = TextEditingController();

  var nodes = [];
  late bool? isPhoneValid = null;
  late bool? isPasswordValid = null;
  String errorText = "";

  validatePhone() {
    setState(() {
      if (phoneController.text.toString().contains(" ")) {
        phoneController.text = phoneController.text.trim();
      }

      isPhoneValid = Validations.mobileValidation(phoneController.text.toString().trim(),
          int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"));

      errorText = !isPhoneValid!
          ? !phoneController.text.startsWith("0")
              ? "phoneNotValid".tr().toString()
              : "phoneNumberMustNotStartWith0".tr().toString()
          : "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    nodes.add(FocusNode());

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
        validatePhone();
      } else if (phoneController.text.toString().isNotEmpty) {
        phoneController.addListener(() {
          validatePhone();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionCubit, InternetState>(builder: (context, state) {
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: ColorsConstant.getColorBackground6(widget.theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                ),
                title: CustomText(
                  text: "${widget.title}".tr().toString(),
                  style: TextStyleConstant.headerText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                ),
                centerTitle: true,
              ),
              body: (SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Hero(tag: "LogoWidget", child: LogoRegister()),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                        width: SizeDataConstant.customWidth(context, 1.1),
                        child: CustomText(
                            text: "forgetPasswordData".tr().toString(),
                            style: TextStyleConstant.optionalText(context, widget.theInitialModel!.data!.account!.mobileAppColors!))),
                    SizedBox(
                      height: 2.h,
                    ),
                    Hero(
                      tag: "PhoneTag",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "phoneNumberMustNotStartWith0".tr().toString(),
                              style: TextStyleConstant.bodyTextMainColor(context, widget.theInitialModel!.data!.account!.mobileAppColors!)),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Material(
                            child: SizedBox(
                              width: SizeDataConstant.customWidth(context, 1.1),
                              height: 6.5.h,
                              child: EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                                  ? AppTextFiled(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: SizedBox(
                                          width: 25.w,
                                          child: CountryCodeWidget(),
                                        ),
                                      ),
                                      password: false,
                                      labelText: 'mobileNumber'.tr().toString(),
                                      textAlign: TextAlign.left,
                                      node: nodes[0],
                                      nextNode: null,
                                      hintText: 'mobileNumber'.tr().toString(),
                                      inputType: TextInputType.phone,
                                      validation: isPhoneValid,
                                      validationWidget: ValidateText(
                                        validation: isPhoneValid,
                                      ),
                                      controller: phoneController,
                                      colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                                    )
                                  : AppTextFiledArabic(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: SizedBox(
                                          width: 20.w,
                                          child: CountryCodeWidget(),
                                        ),
                                      ),
                                      password: false,
                                      labelText: 'mobileNumber'.tr().toString(),
                                      textAlign: TextAlign.left,
                                      node: nodes[0],
                                      nextNode: null,
                                      hintText: 'mobileNumber'.tr().toString(),
                                      inputType: TextInputType.phone,
                                      validation: isPhoneValid,
                                      validationWidget: ValidateText(
                                        validation: isPhoneValid,
                                      ),
                                      controller: phoneController,
                                      colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: errorText.isEmpty ? 0 : 02.h,
                    ),
                    SizedBox(
                        width: SizeDataConstant.customWidth(context, 1.1),
                        child: CustomText(
                            text: errorText,
                            style: TextStyleConstant.errorText(context, widget.theInitialModel!.data!.account!.mobileAppColors!))),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<SmsCubit, SmsState>(builder: (context, state) {
                      return AppButton(
                        disable: phoneController.text.length !=
                            int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"),
                        color: ColorsConstant.getColorBackground3(widget.theInitialModel!.data!.account!.mobileAppColors!),
                        textStyle: TextStyleConstant.whiteText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                        title: "submit".tr().toString(),
                        colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                        onPressed: () {
                          SmsCubit.get(context).checkPhoneNumForgetPassword(context: context, phone: phoneController.text);
                        },
                        widthRatio: 1.1,
                        heightRatio: 7,
                      );
                    }, listener: (context, state) {
                      if (state is SmsStateForgetSuccess) {
                        SmsCubit.get(context).sendSms(context: context, phone: phoneController.text);
                      } else if (state is SmsStateForgetFailure) {
                        DataErrorAlert.showError(
                            title: "",
                            data: SmsCubit.get(context).errorModel!.message!,
                            colorValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                            context: context);
                      }

                      if (state is SmsStateSendSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmCode(
                                      theInitialModel: SplashCubit.get(context).theInitialModel,
                                      type: "forgetPassword",
                                      phone: phoneController.text,
                                    )));
                      }
                    })
                  ],
                ),
              )),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // ForgetPasswordCubit.get(context).getData();
      }
    });
  }
}
