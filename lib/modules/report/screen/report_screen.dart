import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/report/cubit/report_cubit.dart';
import 'package:future_express/modules/report/screen/form_report.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReportCubit()..getClient()
        // ..getReport(),
        ,
        child: const FormReport()
            // : Scaffold(
            //     appBar: ExpressAppBar(
            //         myTitle: context.tr.today_report,
            //         widget: IconButton(
            //           onPressed: () => router.pop(),
            //           icon: const Icon(Icons.arrow_back_ios,
            //               color: Palette.greyColor),
            //         )),
            //     body: BlocBuilder<ReportCubit, ReportState>(
            //         builder: (context, state) {
            //       var reportModel = ReportCubit.get(context).reportModel;
            //       return ListView.builder(
            //         itemCount: reportModel!.length,
            //         itemBuilder: (context, index) => Column(
            //           children: [
            //             ItemFild(
            //                 nameFild: context.tr.name,
            //                 fild: reportModel[index].delegateName),
            //             ItemFild(
            //                 nameFild: context.tr.order,
            //                 fild: reportModel[index].delegateCode),
            //             ItemFild(
            //                 nameFild: context.tr.city,
            //                 fild: reportModel[index].delegateCity),
            //             ItemFild(
            //                 nameFild: context.tr.name,
            //                 fild: reportModel[index].received.toString()),
            //             ItemFild(
            //                 nameFild: context.tr.total,
            //                 fild: reportModel[index].total.toString()),
            //           ],
            //         ),
            //       );
            //     }))
            );
  }
}
