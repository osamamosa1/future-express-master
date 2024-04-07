import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/modules/store/orders/cubit/order_cubit.dart';
import 'package:future_express/modules/store/orders/widgets/item_fild.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/user_local.dart';
import 'package:future_express/shared/widgets/express_card.dart';

class BadyOrderDetails extends StatelessWidget {
  final Order order;

  const BadyOrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..getOrder(order.orderId.toString(),UserLocal.userType),
      child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
        if (state is SuccessOrderDetailsState) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ExpressCard(
                  child: Text(
                    '${state.Orders.clientCity} - ${state.Orders.clientRegion} - ${state.Orders.addressDetails}',
                    style:
                        const TextStyle(color: Palette.greyColor, fontSize: 18),
                  ),
                ),
              ),
              ItemFild(
                nameFild: '${context.tr.phone} ${context.tr.client}',
                fild: state.Orders.clientPhone??'',
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: state.Orders.clientName??''));
                  showToast(
                    message: 'Copied to Clipboard',
                    toastStates: ToastStates.EROOR,
                  );
                },
                child: ItemFild(
                  nameFild: context.tr.name,
                  fild: state.Orders.clientName??'',
                ),
              ),
              ItemFild(
                nameFild: context.tr.email,
                fild: state.Orders.clientEmail??'',
              ),
              ItemFild(
                nameFild: context.tr.city,
                fild: state.Orders.clientCity??'',
              ),
              ItemFild(
                nameFild: context.tr.num,
                fild: state.Orders.numberCount.toString(),
              ),
              ItemFild(
                nameFild: context.tr.store,
                fild: state.Orders.store??'',
              ),
              ItemFild(
                nameFild: context.tr.store_phone,
                fild: state.Orders.storePhone??"",
              ),
            ],
          );
        }else if(state is OrderDetailsLoad){
          return const Center(child: CircularProgressIndicator());
        }else{
          return const Center(child: SizedBox());
        }
      }),
    );
  }
}
