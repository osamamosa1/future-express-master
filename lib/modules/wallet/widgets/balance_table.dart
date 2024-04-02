import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/model/balance_model.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';

import '../../../shared/palette.dart';

class BalanceTabel extends StatelessWidget {
  const BalanceTabel({super.key});

  @override
  Widget build(BuildContext context) {
    List<BalanceEntry>? balance = HomeCubit.get(context).balance;

    return balance!.isEmpty
        ? Column(
            children: [
              SvgPicture.asset('assets/images/wallet.svg'),
              const Text(
                'لا يوجد سجلات !',
                style: TextStyle(color: Palette.blackColor),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'الرجاء إتمام أي عملية إيداع او سحب حتى \nتظهر بيانات هذه التحويلات',
                textAlign: TextAlign.center,
                style: TextStyle(color: Palette.greyColor),
              ),
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(color: Palette.greyColor),
              decoration: const BoxDecoration(color: Palette.whiteColor),
              headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Palette.primaryColor,
              ),
              columns: [
                const DataColumn(
                  label: Text(
                    '#',
                    style: TextStyle(color: Palette.whiteColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    context.tr.type,
                    style: const TextStyle(color: Palette.whiteColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    context.tr.price,
                    style: const TextStyle(color: Palette.whiteColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    context.tr.order_details,
                    style: const TextStyle(color: Palette.whiteColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    context.tr.date,
                    style: const TextStyle(color: Palette.whiteColor),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                balance.length,
                (index) {
                  final item = balance[index];
                  final itemIndex = index + 1; // للبدء من 1
                  return DataRow(cells: [
                    DataCell(Text(itemIndex.toString())),
                    DataCell(Text(
                        item.debtor - item.creditor >= 0 ? 'دائن' : 'مدين')),
                    DataCell(Text(item.debtor - item.creditor >= 0
                        ? '${item.debtor} ريال'
                        : '${item.creditor} ريال')),
                    DataCell(Text(item.description.toString())),
                    DataCell(Text(item.date.toString())),
                  ]);
                },
              ),
            ));
  }
}
