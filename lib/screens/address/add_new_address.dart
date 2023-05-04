import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/address_model/address_model.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';
import 'package:elnasser/screens/address/address_bloc/address_state.dart';
import 'package:elnasser/screens/address/map_widget/map_screen.dart';
import 'package:elnasser/screens/complete_payment/complete_payment_bloc/complete_payment_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/country_code_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({Key? key, required this.colorsValue, this.address, required this.edit}) : super(key: key);
  final ColorsInitialValue colorsValue;
  final bool edit;
  AddressDataModel? address;

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  var nodes = [];
  late bool? isPhoneValid = null;
  String errorTextPhone = "";
  late bool? isNameValid = null;
  String errorTextName = "";
  late bool? isStreetValid = null;
  String errorTextStreet = "";
  late bool? isBuildingValid = null;
  String errorTextBuilding = "";
  late bool? isFlorValid = null;
  String errorTextFlor = "";
  late bool? isDepartmentValid = null;
  String errorTextDepartment = "";

  validatePhone() {
    setState(() {
      if (AddressCubit.get(context).controllerPhone.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerPhone.text = AddressCubit.get(context).controllerPhone.text.trim();
      }

      isPhoneValid = Validations.mobileValidation(AddressCubit.get(context).controllerPhone.text.toString().trim(),
          int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"));

      errorTextPhone = !isPhoneValid!
          ? !AddressCubit.get(context).controllerPhone.text.startsWith("0")
              ? "phoneNotValid".tr().toString()
              : "phoneNumberMustNotStartWith0".tr().toString()
          : "";
    });
  }

  validateName() {
    setState(() {
      if (AddressCubit.get(context).controllerName.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerName.text = AddressCubit.get(context).controllerName.text.trim();
      }
      isNameValid = Validations.nameValidation(AddressCubit.get(context).controllerName.text.toString().trim());

      errorTextName = isNameValid != true ? "fieldRequiredName".tr().toString() : "";
    });
  }

  validateStreet() {
    setState(() {
      if (AddressCubit.get(context).controllerStreet.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerStreet.text = AddressCubit.get(context).controllerStreet.text.trim();
      }
      isStreetValid = Validations.nameValidation(AddressCubit.get(context).controllerStreet.text.toString().trim());

      errorTextStreet = isStreetValid != true ? "fieldRequiredStreet".tr().toString() : "";
    });
  }

  ///
  validateBuilding() {
    setState(() {
      if (AddressCubit.get(context).controllerBuilding.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerBuilding.text = AddressCubit.get(context).controllerBuilding.text.trim();
      }
      isBuildingValid = Validations.intValidation(AddressCubit.get(context).controllerBuilding.text.toString().trim());

      errorTextBuilding = isBuildingValid != true ? "fieldRequiredBuilding".tr().toString() : "";
    });
  }

  validateFlor() {
    setState(() {
      if (AddressCubit.get(context).controllerFlor.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerFlor.text = AddressCubit.get(context).controllerFlor.text.trim();
      }
      isFlorValid = Validations.intValidation(AddressCubit.get(context).controllerFlor.text.toString().trim());

      errorTextFlor = isFlorValid != true ? "fieldRequiredFlor".tr().toString() : "";
    });
  }

  validateDepartment() {
    setState(() {
      if (AddressCubit.get(context).controllerDepartment.text.toString().contains(" ")) {
        AddressCubit.get(context).controllerDepartment.text = AddressCubit.get(context).controllerDepartment.text.trim();
      }
      isDepartmentValid = Validations.intValidation(AddressCubit.get(context).controllerDepartment.text.toString().trim());

      errorTextDepartment = isDepartmentValid != true ? "fieldRequiredDepartment".tr().toString() : "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes[7].addListener(() {
      if (!nodes[7].hasFocus) {
        validatePhone();
      } else if (AddressCubit.get(context).controllerPhone.text.toString().isNotEmpty) {
        AddressCubit.get(context).controllerPhone.addListener(() {
          validatePhone();
        });
      }
    });

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
        validateName();
      } else if (AddressCubit.get(context).controllerName.text.toString().isNotEmpty) {
        AddressCubit.get(context).controllerName.addListener(() {
          validateName();
        });
      }
    });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus) {
        validateStreet();
      } else if (AddressCubit.get(context).controllerStreet.text.toString().isNotEmpty) {
        AddressCubit.get(context).controllerStreet.addListener(() {
          // validateStreet();
        });
      }
    });

    ///
    nodes[2].addListener(() {
      if (!nodes[2].hasFocus) {
        validateBuilding();
      } else if (AddressCubit.get(context).controllerBuilding.text.toString().isNotEmpty) {
        AddressCubit.get(context).controllerBuilding.addListener(() {
          validateBuilding();
        });
      }
    });

    nodes[3].addListener(() {
      if (!nodes[3].hasFocus) {
        validateFlor();
      } else if (AddressCubit.get(context).controllerFlor.text.toString().isNotEmpty) {
        // AddressCubit.get(context).controllerFlor.addListener(() {
        //   validateFlor();
        // });
      }
    });

    nodes[4].addListener(() {
      if (!nodes[4].hasFocus) {
        validateDepartment();
      } else if (AddressCubit.get(context).controllerDepartment.text.toString().isNotEmpty) {
        // AddressCubit.get(context).controllerDepartment.addListener(() {
        //   validateDepartment();
        // });
      }
    });

    if (widget.address != null) {
      AddressCubit.get(context).controllerGov.text = widget.address!.customerAddressesAddress!.split(",")[0];
      AddressCubit.get(context).controllerCity.text = widget.address!.customerAddressesAddress!.split(",")[1];
      AddressCubit.get(context).controllerArea.text = widget.address!.customerAddressesAddress!.split(",")[2];
      AddressCubit.get(context).controllerStreet.text = widget.address!.customerAddressesAddress!.split(",")[3];
      AddressCubit.get(context).controllerBuilding.text = widget.address!.customerAddressesAddress!.split(",")[4];
      AddressCubit.get(context).controllerFlor.text = widget.address!.customerAddressesAddress!.split(",")[5];
      AddressCubit.get(context).controllerDepartment.text = widget.address!.customerAddressesAddress!.split(",")[6];
      AddressCubit.get(context).controllerName.text = widget.address!.customerAddressesName!;
      AddressCubit.get(context).controllerPhone.text = widget.address!.customerAddressesPhone!.replaceAll("+20", "");
      AddressCubit.get(context).controllerNote.text =
          widget.address!.customerAddressesNotes != null ? widget.address!.customerAddressesNotes! : "";
      AddressCubit.get(context).changeDefaultValue(widget.address!.customerAddressesDefault! == "1" ? true : false);
    } else {
      AddressCubit.get(context).controllerGov.text = "";
      AddressCubit.get(context).controllerCity.text = "";
      AddressCubit.get(context).controllerArea.text = "";
      AddressCubit.get(context).controllerStreet.text = "";
      AddressCubit.get(context).controllerBuilding.text = "";
      AddressCubit.get(context).controllerFlor.text = "";
      AddressCubit.get(context).controllerDepartment.text = "";
      AddressCubit.get(context).controllerName.text = "";
      AddressCubit.get(context).controllerPhone.text = "";
      AddressCubit.get(context).controllerNote.text = "";
      AddressCubit.get(context).controllerAddressLine.text = "";
      AddressCubit.get(context).changeDefaultValue(false);
    }

    super.initState();
  }

  bool _keyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocConsumer<ConnectionCubit, InternetState>(builder: (context, state) {
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: _keyboardVisible == false ? 40.h : 20.h,
                          child: MapWidget(
                            colorsValue: widget.colorsValue,
                            edit: widget.edit,
                          )),
                      BlocConsumer<AddressCubit, AddressState>(builder: (context, state) {
                        return SizedBox(
                          height: _keyboardVisible == false ? 55.h : 55.h,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                    enable: true,
                                    password: false,
                                    labelText: 'name'.tr().toString(),
                                    colorsInitialValue: widget.colorsValue,
                                    validation: isNameValid,
                                    controller: AddressCubit.get(context).controllerName,
                                    inputType: TextInputType.text,
                                    nextNode: nodes[1],
                                    hintText: 'name'.tr().toString(),
                                    node: nodes[0],
                                    validationWidget: ValidateText(
                                      validation: isNameValid,
                                    )),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  enable: false,
                                  password: false,
                                  labelText: 'gov'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: true,
                                  controller: AddressCubit.get(context).controllerGov,
                                  inputType: TextInputType.text,
                                  nextNode: null,
                                  hintText: 'gov'.tr().toString(),
                                  node: null,
                                  validationWidget: Container(
                                    width: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  enable: false,
                                  password: false,
                                  labelText: 'city'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: true,
                                  controller: AddressCubit.get(context).controllerCity,
                                  inputType: TextInputType.text,
                                  nextNode: null,
                                  hintText: 'city'.tr().toString(),
                                  node: null,
                                  validationWidget: Container(
                                    width: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  enable: true,
                                  password: false,
                                  labelText: 'street'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: isStreetValid,
                                  controller: AddressCubit.get(context).controllerStreet,
                                  inputType: TextInputType.text,
                                  nextNode: nodes[2],
                                  hintText: 'street'.tr().toString(),
                                  node: nodes[1],
                                  validationWidget: ValidateText(
                                    validation: isStreetValid,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  password: false,
                                  labelText: 'buildingNo'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: isBuildingValid,
                                  controller: AddressCubit.get(context).controllerBuilding,
                                  inputType: TextInputType.number,
                                  nextNode: nodes[3],
                                  hintText: 'buildingNo'.tr().toString(),
                                  node: nodes[2],
                                  validationWidget: ValidateText(
                                    validation: isBuildingValid,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: AppTextFiled(
                                        password: false,
                                        labelText: 'florNo'.tr().toString(),
                                        colorsInitialValue: widget.colorsValue,
                                        validation: isFlorValid,
                                        controller: AddressCubit.get(context).controllerFlor,
                                        inputType: TextInputType.number,
                                        nextNode: nodes[4],
                                        hintText: 'florNo'.tr().toString(),
                                        node: nodes[3],
                                        validationWidget: SizedBox(
                                          width: 0,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: AppTextFiled(
                                        password: false,
                                        labelText: 'departmentNo'.tr().toString(),
                                        colorsInitialValue: widget.colorsValue,
                                        validation: isDepartmentValid,
                                        controller: AddressCubit.get(context).controllerDepartment,
                                        inputType: TextInputType.number,
                                        nextNode: nodes[5],
                                        hintText: 'departmentNo'.tr().toString(),
                                        node: nodes[4],
                                        validationWidget: SizedBox(
                                          width: 0,
                                          height: 0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  enable: true,
                                  password: false,
                                  labelText: 'addressLine'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: true,
                                  controller: AddressCubit.get(context).controllerAddressLine,
                                  inputType: TextInputType.text,
                                  nextNode: nodes[6],
                                  hintText: 'addressLine'.tr().toString(),
                                  node: nodes[5],
                                  validationWidget: Container(
                                    width: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  enable: true,
                                  password: false,
                                  labelText: 'area'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: true,
                                  controller: AddressCubit.get(context).controllerArea,
                                  inputType: TextInputType.text,
                                  nextNode: nodes[7],
                                  hintText: 'area'.tr().toString(),
                                  node: nodes[6],
                                  validationWidget: Container(
                                    width: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomText(
                                    text: "phoneNumberMustNotStartWith0".tr().toString(),
                                    style: TextStyleConstant.bodyTextMainColor(context, widget.colorsValue)),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                                    ? AppTextFiled(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: SizedBox(
                                            width: 25.w,
                                            height: 40,
                                            child: CountryCodeWidget(),
                                          ),
                                        ),
                                        password: false,
                                        labelText: 'mobileNumber'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        node: nodes[7],
                                        nextNode: nodes[8],
                                        hintText: 'mobileNumber'.tr().toString(),
                                        inputType: TextInputType.phone,
                                        validation: isPhoneValid,
                                        validationWidget: ValidateText(
                                          validation: isPhoneValid,
                                        ),
                                        controller: AddressCubit.get(context).controllerPhone,
                                        colorsInitialValue: widget.colorsValue,
                                      )
                                    : AppTextFiledArabic(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: SizedBox(
                                            height: 6.5.h,
                                            width: 20.w,
                                            child: CountryCodeWidget(),
                                          ),
                                        ),
                                        password: false,
                                        labelText: 'mobileNumber'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        node: nodes[7],
                                        nextNode: nodes[8],
                                        hintText: 'mobileNumber'.tr().toString(),
                                        inputType: TextInputType.phone,
                                        validation: isPhoneValid,
                                        validationWidget: ValidateText(
                                          validation: isPhoneValid,
                                        ),
                                        controller: AddressCubit.get(context).controllerPhone,
                                        colorsInitialValue: widget.colorsValue,
                                      ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                CustomText(text: errorTextPhone, style: TextStyleConstant.errorText(context, widget.colorsValue)),
                                SizedBox(
                                  height: 1.h,
                                ),
                                BlocBuilder<AddressCubit, AddressState>(
                                    buildWhen: (prev, current) => current is AddressStateAddressDefaultValue,
                                    builder: (context, state) {
                                      return SizedBox(
                                        width: SizeDataConstant.customWidth(context, 2),
                                        child: CheckboxListTile(
                                            controlAffinity: ListTileControlAffinity.leading,
                                            contentPadding: EdgeInsets.zero,
                                            title: CustomText(
                                              text: "defaultAddress".tr().toString(),
                                              style: TextStyleConstant.bodyText(context, widget.colorsValue),
                                            ),
                                            value: AddressCubit.get(context).defaultValue,
                                            onChanged: (v) {
                                              AddressCubit.get(context).changeDefaultValue(v!);
                                            }),
                                      );
                                    }),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppTextFiled(
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                  password: false,
                                  labelText: 'note'.tr().toString(),
                                  colorsInitialValue: widget.colorsValue,
                                  validation: true,
                                  controller: AddressCubit.get(context).controllerNote,
                                  inputType: TextInputType.text,
                                  nextNode: null,
                                  hintText: 'note'.tr().toString(),
                                  node: nodes[8],
                                  validationWidget: Container(
                                    width: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomText(
                                    text: isNameValid != true
                                        ? errorTextName
                                        : isStreetValid != true
                                            ? errorTextStreet
                                            : isBuildingValid != true
                                                ? errorTextBuilding
                                                : isPhoneValid != true
                                                    ? errorTextPhone
                                                    : "",
                                    style: TextStyleConstant.errorText(context, widget.colorsValue)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Center(
                                  child: AppButton(
                                      colorsInitialValue: widget.colorsValue,
                                      color: ColorsConstant.getColorBackground3(widget.colorsValue),
                                      textStyle: TextStyleConstant.buttonText(context, widget.colorsValue),
                                      title: "save".tr().toString(),
                                      onPressed: () {
                                        if (AddressCubit.get(context).controllerStreet.text.isEmpty ||
                                            AddressCubit.get(context).controllerName.text.isEmpty ||
                                            AddressCubit.get(context).controllerBuilding.text.isEmpty ||
                                            AddressCubit.get(context).controllerCity.text.isEmpty ||
                                            AddressCubit.get(context).controllerGov.text.isEmpty ||
                                            AddressCubit.get(context).controllerPhone.text.isEmpty) {
                                          if (isNameValid != true) {
                                            validateName();
                                            FocusScope.of(context).requestFocus(nodes[0]);
                                          } else if (isStreetValid != true) {
                                            validateStreet();
                                            FocusScope.of(context).requestFocus(nodes[1]);
                                          } else if (isBuildingValid != true) {
                                            validateBuilding();
                                            FocusScope.of(context).requestFocus(nodes[2]);
                                          } else if (isFlorValid != true) {
                                            validateFlor();
                                            FocusScope.of(context).requestFocus(nodes[3]);
                                          } else if (isDepartmentValid != true) {
                                            validateDepartment();
                                            FocusScope.of(context).requestFocus(nodes[4]);
                                          } else if (isPhoneValid != true) {
                                            validatePhone();
                                            FocusScope.of(context).requestFocus(nodes[7]);
                                          } else {
                                            DataErrorAlert.selectLocation(colorValue: widget.colorsValue, context: context);
                                          }
                                        } else {
                                          widget.edit == true
                                              ? AddressCubit.get(context)
                                                  .EditAddressMethod(context: context, addressId: "${widget.address!.customerAddressesId!}")
                                              : AddressCubit.get(context).SubmitAddressMethod(context);
                                        }
                                      }),
                                ),
                                SizedBox(
                                  height: 3.h,
                                )
                              ],
                            ),
                          ),
                        );
                      }, listener: (context, state) {
                        if (state is AddressStateAddressSubmitSuccess ||
                            state is AddressStateAddressDeleteSuccess ||
                            state is AddressStateAddressEditSuccess) {
                          CompletePaymentCubit.get(context).getAddressAndPaymentMethods(context);
                        }
                      })
                    ],
                  ),
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
