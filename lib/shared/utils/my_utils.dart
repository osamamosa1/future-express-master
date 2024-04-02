import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<T?> pushPage<T>(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (context) => page));
}

void showMyBottomSheet(BuildContext context, Widget page) {
  unawaited(showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => page));
}

class UrlLauncher {
  static Future<void> launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrlString('tel:$url')) {
      await launchUrlString('tel:$url');
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> makeMail(Uri url) async {
    if (await canLaunchUrlString('email:$url')) {
      await launchUrlString('email:$url');
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SocialButton extends StatelessWidget {
  final Function onPressed;
  final Color? buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final bool? isMinSize;
  final IconData? iconDate;
  const SocialButton(
      {super.key,
      required this.onPressed,
      this.buttonColor,
      this.iconColor,
      this.iconSize = 25,
      this.isMinSize,
      this.iconDate});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.white,
      mini: isMinSize ?? true,
      onPressed: onPressed as void Function()?,
      backgroundColor: buttonColor ?? const Color.fromARGB(255, 30, 255, 0),
      child: Icon(
        iconDate,
        color: iconColor ?? Colors.white,
        size: iconSize,
      ),
    );
  }
}
