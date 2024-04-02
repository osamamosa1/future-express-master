import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/balance_model.dart';
import 'package:future_express/model/order_status.dart';
import '../../../model/statices_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/utils/app_url.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> init() async {
    getStatistics();
    getBalances();
  }

  Statistics? statistics;

  void getStatistics() async {
    try {
      emit(StatisticsLoad());
      var response = await DioHelper.getData(
        Url: AppUrl.statistics,
      );

      if (response.statusCode == 200) {
        print(response.data);

        statistics = Statistics.fromJson(response.data['Statistics']);
        log(statistics!.ordersShipToday.toString());
        emit(StatisticsSuccess(statistics));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      // showToast(message: '$error sestatistics', toastStates: ToastStates.EROOR);
      emit(StatisticsLoadFailed());
    }
  }

  List<BalanceEntry>? balance = [];

  void getBalances() async {
    try {
      emit(BalanceLoad());
      var response = await DioHelper.getData(
        Url: AppUrl.balance,
      );
      if (response.statusCode == 200) {
        print(response.data);

        if (response.data['balance'] != []) {
          Map<String, dynamic> data = response.data;
          BalanceResponse balanceResponse = BalanceResponse.fromJson(data);
          print('فشل الاستجابة: ${response.statusCode}');

          balance = balanceResponse.balance;
        }
        emit(BalanceSuccess(balance));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      // showToast(message: error.toString(), toastStates: ToastStates.EROOR);
      emit(BalanceLoadFailed());
    }
  }

  // get the goal

  List<OrderStatus>? statusesItems = [];
  String? statuseItme;
  int? isOtp = 0;
  int? send_image = 0;

  Future<void> getStatuses() async {
    statusesItems = [];
    statuseItme = '0';
    emit(LoadingStatusesState());
    var response = await DioHelper.getData(
      Url: AppUrl.statuses,
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      (response.data['statuses']).forEach((value) {
        statusesItems!.add(OrderStatus.fromJson(value));
        emit(GetStatusesItemsState());
      });
    } else {
      print(response.statusMessage);
    }

    {
      emit(GetStatusesItemsState());
    }
  }
}
