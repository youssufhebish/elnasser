import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/order_model/order_model.dart';
import 'package:elnasser/screens/orders_screen/bloc_widget/order_item.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_cubit_state.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen(
      {Key? key,
      required this.items,
      required this.colorsValue,
      required this.orderId})
      : super(key: key);
  final List<OrderItemModel> items;
  final ColorsInitialValue colorsValue;
  final String orderId;
  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    controller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: CustomText(
            text: "refund".tr().toString(),
            style: TextStyleConstant.headerText(context, widget.colorsValue),
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
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                itemCount: widget.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    onChanged: (bool? value) {
                      setState(() {
                        widget.items[index].checked = value!;
                        OrderCubit.get(context).getRefundedIds(widget.items);
                        print(value);
                      });
                    },
                    value: widget.items[index].checked,
                    subtitle: OrderItemWidget(
                      colorsValue: widget.colorsValue,
                      orderItem: widget.items[index],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Center(
                  child: AppTextFiled(
                contentPaddingTop: 50,
                textAlign: TextAlign.start,
                password: false,
                validation: null,
                hintText: "",
                nextNode: null,
                controller: controller,
                inputType: TextInputType.text,
                labelText: "refundNote".tr().toString(),
                node: null,
                validationWidget: Container(),
                colorsInitialValue: widget.colorsValue,
                maxLines: 5,
              )),
              SizedBox(
                height: 5.h,
              ),
              BlocConsumer<OrderCubit, OrderCubitState>(
                builder: (context, state) {
                  return AppButton(
                    withBorder: true,
                    color:
                        ColorsConstant.getColorBackground3(widget.colorsValue),
                    colorsInitialValue: widget.colorsValue,
                    onPressed: () {
                      OrderCubit.get(context).RefundApi(
                          context: context,
                          orderId: widget.orderId,
                          note: controller.text);
                      controller.clear();
                    },
                    title: 'refund'.tr().toString(),
                    textStyle: TextStyleConstant.buttonTextMainColor(
                        context, widget.colorsValue),
                  );
                },
                listener: (context, state) {
                  if (state is OrderCubitStateRefundOrderSuccess) {
                    DataErrorAlert.refundSuccess(
                        colorValue: widget.colorsValue, context: context);
                  } else if (state is OrderCubitStateRefundOrderFailed) {
                    DataErrorAlert.showError(
                        title: "",
                        data: OrderCubit.get(context).errorModel.errors!.first,
                        colorValue: widget.colorsValue,
                        context: context);
                  }
                },
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
