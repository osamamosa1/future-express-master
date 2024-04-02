import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/shared/palette.dart';

class AccountListTile extends StatelessWidget {
  final String title;
  final String icon;
  final void Function() onPressed;
  final Widget? trailing;

  const AccountListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      leading: SizedBox(
        width: 24.0,
        height: 24.0,
        child: SvgPicture.asset(
          icon,
          colorFilter:
              const ColorFilter.mode(Palette.primaryColor, BlendMode.srcIn),
        ),
      ),
      trailing: trailing ??
          const SizedBox(
            width: 24.0,
            height: 24.0,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Palette.greyColor,
            ),
          ),
      dense: true,
    );
  }
}
