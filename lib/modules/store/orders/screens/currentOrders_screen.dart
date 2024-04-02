import 'package:flutter/material.dart';

import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_card.dart';

class CurrentOrdersScreen extends StatefulWidget {
  const CurrentOrdersScreen({
    super.key,
  });

  @override
  State<CurrentOrdersScreen> createState() => _CurrentOrdersScreenState();
}

class _CurrentOrdersScreenState extends State<CurrentOrdersScreen> {
  bool selectedTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ExpressAppBar(
          myTitle: context.tr.current_orders,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Palette.primarygreyColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => {setState(() => selectedTap = false)},
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: selectedTap == false
                                ? Palette.whiteColor
                                : Palette.primarygreyColor,
                          ),
                          child: Center(
                            child: Text(
                              context.tr.current,
                              style: const TextStyle(
                                  color: Palette.greyColor, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => {setState(() => selectedTap = true)},
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: selectedTap == true
                                ? Palette.whiteColor
                                : Palette.primarygreyColor,
                          ),
                          child: Center(
                            child: Text(
                              context.tr.completed,
                              style: const TextStyle(
                                  color: Palette.greyColor, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              selectedTap ? viewCompletedOrders() : viewCurrentOrders(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  viewCurrentOrders() {
    return InkWell(
      onTap: () {},
      child: ExpressCard(
        padding: const EdgeInsets.only(
          top: 18,
          right: 12,
          left: 12,
          bottom: 8,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/icon.png'),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ابو فهد عبدالعزيز',
                            style: TextStyle(
                                color: Palette.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 5.0,
                                  backgroundColor: Palette.greyColor,
                                ),
                              ),
                              Text(
                                '1097 Daju Ridge',
                                style: TextStyle(
                                    color: Palette.greyColor, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 5.0,
                                  backgroundColor: Palette.primaryColor,
                                ),
                              ),
                              Text(
                                '1283 Cunema Extension',
                                style: TextStyle(
                                    color: Palette.greyColor, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'مطعم البيك',
                            style: TextStyle(
                                color: Palette.greyColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Text(
                  '15 ر.س',
                  style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/date.png'),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                      child: Text(
                        '16 oct 2023',
                        style:
                            TextStyle(color: Palette.greyColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ExpressButton(
                  onPressed: () => {},
                  child: const Text('تفاصيل'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  viewCompletedOrders() {
    return ExpressCard(
      padding: const EdgeInsets.only(
        top: 18,
        right: 12,
        left: 12,
        bottom: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/icon.png'),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ابو فهد عبدالعزيز',
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 5.0,
                            backgroundColor: Palette.greyColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '1097 Daju Ridge',
                          style:
                              TextStyle(color: Palette.greyColor, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 5.0,
                            backgroundColor: Palette.primaryColor,
                          ),
                        ),
                        Text(
                          '1283 Cunema Extension',
                          style:
                              TextStyle(color: Palette.greyColor, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'مطعم البيك',
                      style: TextStyle(color: Palette.greyColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/date.png'),
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                child: Text(
                  '16 oct 2023',
                  style: TextStyle(color: Palette.greyColor, fontSize: 18),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
