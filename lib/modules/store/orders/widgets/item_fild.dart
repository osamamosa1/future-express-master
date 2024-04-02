import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/widgets/coby_text.dart';
import 'package:future_express/shared/widgets/express_card.dart';


class ItemFild extends StatelessWidget {
  const ItemFild({
    super.key,
    required this.nameFild,
    required this.fild,
  });

  final String nameFild;
  final String fild;

  @override
  Widget build(BuildContext context) {
    return fild.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                nameFild,
                style: const TextStyle(
                    color: Palette.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ExpressCard(
                  child: CopyableWidget(
                   textToCopy:  fild,
                   
                  ),
                ),
              ),
            ],
          );
  }
}
