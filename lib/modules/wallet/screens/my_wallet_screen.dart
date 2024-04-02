import 'package:flutter/material.dart';

import 'package:future_express/modules/wallet/widgets/balance_table.dart';
import 'package:future_express/modules/wallet/widgets/walletCard.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExpressAppBar(
        myTitle: context.tr.my_wallet,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WalletCard(),
            SizedBox(
              height: 20,
            ),
            BalanceTabel()
          ],
        ),
      ),
    );
  }
}
