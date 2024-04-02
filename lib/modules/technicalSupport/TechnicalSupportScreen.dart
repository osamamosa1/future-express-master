import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_express/modules/technicalSupport/widget/send_msg.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/utils/my_utils.dart';

class TechnicalSupport extends StatefulWidget {
  const TechnicalSupport({
    super.key,
  });

  @override
  State<TechnicalSupport> createState() => _TechnicalSupportState();
}

class _TechnicalSupportState extends State<TechnicalSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ExpressAppBar(
        myTitle: context.tr.technical_support,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                context.tr.having_problem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Palette.primaryLightColor, fontSize: 23),
              ),
              const SizedBox(
                height: 30,
              ),
              ExpressButton(
                onPressed: () async => {pushPage(context, const SendSubject())},
                child: Text(context.tr.send_msg),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                context.tr.communicate_via,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Palette.primaryLightColor, fontSize: 23),
              ),
              const SizedBox(
                height: 30,
              ),
              ExpressCard(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.website,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Palette.blackColor,
                          ),
                        ),
                        const Text('https://future-ex.com',
                            style: TextStyle(
                              fontSize: 18,
                              color: Palette.blackColor,
                            ))
                      ],
                    ),
                    Image.asset(
                      'assets/images/Button.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                context.tr.or_via,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Palette.primaryLightColor, fontSize: 23),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => unawaited(
                        launchUrl(Uri.parse('https://wa.me/+966547247342'))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/whatsapp.png',
                        width: 40,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => unawaited(
                        launchUrl(Uri.parse('https://www.instagram.com/'))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/instagram.png',
                        width: 40,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => unawaited(
                        launchUrl(Uri.parse('https://www.twitter.com/'))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/twitter.png',
                        width: 40,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => unawaited(
                        launchUrl(Uri.parse('https://www.snapchat.com/'))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/snapchat.png',
                        width: 40,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => unawaited(
                        launchUrl(Uri.parse('https://www.facebook.com/'))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        width: 40,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
