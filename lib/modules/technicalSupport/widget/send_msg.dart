import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';

class SendSubject extends StatelessWidget {
  const SendSubject({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController subject = TextEditingController();
    TextEditingController message = TextEditingController();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.h,
          ),
          const Text('تواصل معنا',
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          SizedBox(
            height: 40.h,
          ),
          SizedBox(
            width: .85.sw,
            child: defaultFormField(
              controller: subject,
              lines: 1,
              type: TextInputType.text,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'message_is_Too_Short';
                }
                return null;
              },
              label: 'subject',
              prefix: const Icon(Icons.text_decrease),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: .85.sw,
            child: defaultFormField(
              controller: message,
              lines: 12,
              type: TextInputType.text,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'message_is_Too_Short';
                }
                return null;
              },
              label: 'message',
              prefix: const Icon(Icons.subject),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Spacer(),
          ExpressButton(
            child: Text(context.tr.send),
            onPressed: () async {
              final token = await CacheHelper.getToken();
              log(message.text);
              var headers = {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              };
              var data = FormData.fromMap(
                  {'subject': subject, 'message': message.text});

              var dio = Dio();
              var response = await dio.request(
                'https://future-ex.com/api/v1/contact_us',
                options: Options(
                  method: 'POST',
                  headers: headers,
                ),
                data: data,
              );

              if (response.statusCode == 200) {
                print(json.encode(response.data));
                Navigator.pop(context);
              } else {
                print(response.statusMessage);
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    ));
  }
}
