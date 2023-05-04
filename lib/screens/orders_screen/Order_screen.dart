import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_cubt.dart';
import 'package:elnasser/screens/cart/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_bloc_state.dart';
import 'package:elnasser/screens/orders_screen/order_bloc/order_event.dart';
import 'package:elnasser/screens/orders_screen/order_detail_screen_no_api.dart';
import 'package:elnasser/widget/cart_ounter_widget.dart';
import 'package:elnasser/widget/no_data_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/notificationCounter.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'bloc_widget/bloc_widget.dart';
import 'order_bloc/order_cubit.dart';
import 'order_detail_with_api.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key, required this.colorsValue}) : super(key: key);
  final ColorsInitialValue colorsValue;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    int x = 0;

    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
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
                  text: "order".tr().toString(),
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
                // actions: [
                //   NotificationCounter(colorsValue:colorsValue),
                //
                //   BlocBuilder<AddToCartCubit,AddToCartState>(builder: (context,state){return CartCounterWidget(colorsValue:colorsValue);})
                //
                // ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // OrderWidget(colorsValue: colorsValue,)
                    BlocConsumer<OrderBloc, OrderBlocState>(
                      buildWhen: (prev, current) {
                        print("current");
                        print(current.status);
                        if (prev != current &&
                            (current.status == OrderBlocStatus.refresh ||
                                current.status == OrderBlocStatus.failure ||
                                current.status == OrderBlocStatus.success)) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 100.h - (AppBar().preferredSize.height * 2),
                          child: SmartRefresher(
                            physics: BouncingScrollPhysics(),
                            enablePullDown: true,
                            enablePullUp: true,
                            header: WaterDropHeader(),
                            footer: CustomFooter(
                              builder: (context, mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  // body = state.hasReachedMax == true
                                  //     ? Container()
                                  //     : Center(
                                  //     child: CircularProgressIndicator(
                                  //         strokeWidth: 1.5));
                                  body = Text("No more Data");
                                } else if (mode == LoadStatus.loading) {
                                  body = Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
                                } else if (mode == LoadStatus.failed) {
                                  body = Text("Load Failed!Click retry!");
                                } else {
                                  body = Text("No more Data");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: _refreshController,
                            onRefresh: () async {
                              x = 0;
                              context.read<OrderBloc>().add(OrderReset());
                              await Future.delayed(Duration(seconds: 5));

                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              // await Future.delayed(Duration(seconds: 0));
                              // context
                              //     .read<OrderBloc>()
                              //     .add(OrderFetch());

                              _refreshController.loadComplete();
                            },
                            child: (state.status == OrderBlocStatus.success &&
                                    state.orderList.isNotEmpty)
                                ? ListView.builder(
                                    itemCount: state.orderList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            print(
                                                " ${state.orderList[index].ordersId!} ");
                                            print(
                                                " ${state.orderList[index].ordersStatus!} ");

                                            OrderCubit.get(context).getOrderDetails(
                                                context: context,
                                                orderId:
                                                    "${state.orderList[index].ordersId!}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetailScreenWithApi(
                                                            colorsValue:
                                                                colorsValue)));
                                          },
                                          child: OrderWidget(
                                            colorsValue: colorsValue,
                                            orderListModel:
                                                state.orderList[index],
                                          ));
                                    })
                                : (state.status == OrderBlocStatus.success &&
                                        state.orderList.isEmpty)
                                    ? NoDataWidget(
                                        colorsValue: colorsValue,
                                        image: ImageConstants.noOrder,
                                        title: 'noOrder',
                                        description: 'noOrderDesc',
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
                          ),
                        );
                      },
                      listener: (context, state) {
                        print(
                            'state ${state.orderList.isEmpty && OrderBlocStatus.success == state.status}');
                        if (state.status == OrderBlocStatus.refresh) {
                          print(state.status);
                          context.read<OrderBloc>().add(OrderFetch());

                          x++;
                          print('xxxx $x');
                          if (x == 2) {}
                        }
                        if (state.orderList.isEmpty &&
                            OrderBlocStatus.success == state.status) {}
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // context
        //     .read<OrderBloc>()
        //     .emit(OrderBlocState(context: context));
        // context
        //     .read<OrderBloc>()
        //     .add(OrderReset());
        // context
        //     .read<OrderBloc>()
        //     .add(OrderFetch());
      }
    });
  }
}
