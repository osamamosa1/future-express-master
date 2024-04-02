import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';

class HomeButtonStyle {
  final BoxDecoration decoration;
  final BoxDecoration activeDecoration;
  final Color textColor;

  const HomeButtonStyle({
    required this.decoration,
    required this.textColor,
    BoxDecoration? activeDecoration,
  }) : activeDecoration = activeDecoration ?? decoration;

  static const primary = HomeButtonStyle(
    decoration: BoxDecoration(
      color: Palette.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(40)),
      image: DecorationImage(
          image: AssetImage(
            'assets/images/waves_white.png',
          ),
          fit: BoxFit.fitWidth,
          alignment: Alignment.centerRight),
    ),
    activeDecoration: BoxDecoration(
      color: Palette.primaryLightColor,
      borderRadius: BorderRadius.all(Radius.circular(40)),
      image: DecorationImage(
          image: AssetImage(
            'assets/images/waves_white.png',
          ),
          fit: BoxFit.fitWidth,
          alignment: Alignment.centerRight),
    ),
    textColor: Palette.whiteColor,
  );

  static final secondary = HomeButtonStyle(
    decoration: BoxDecoration(
      color: Palette.whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      border: Border.all(
        color: Palette.primaryColor,
        // width:
      ),
      image: const DecorationImage(
          image: AssetImage(
            'assets/images/waves_red.png',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight),
    ),
    activeDecoration: BoxDecoration(
      color: Palette.greyColor.shade200,
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      border: Border.all(
        color: Palette.primaryColor,
        // width:
      ),
      image: const DecorationImage(
          image: AssetImage(
            'assets/images/waves_red.png',
          ),
          fit: BoxFit.fitWidth,
          alignment: Alignment.centerRight),
    ),
    textColor: Palette.greyColor.shade800,
  );
}

class HomeScreenButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String title;
  final String subTitle;
  final bool disabled;
  final bool loading;
  final bool dense;
  final HomeButtonStyle style;

  const HomeScreenButton({
    super.key,
    required this.title,
    this.subTitle = '',
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    this.dense = false,
    required this.style,
  });

  @override
  State<HomeScreenButton> createState() => _HomeScreenButtonState();
}

class _HomeScreenButtonState extends State<HomeScreenButton> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final decoration =
        _tapped ? widget.style.activeDecoration : widget.style.decoration;
    final textStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(color: widget.style.textColor);

    return GestureDetector(
      onTap: (widget.disabled || widget.loading) ? null : widget.onPressed,
      onTapDown: (details) {
        if (widget.disabled || widget.loading) return;

        setState(() {
          _tapped = true;
        });
      },
      onTapUp: (details) {
        if (widget.disabled || widget.loading) return;

        setState(() {
          _tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: decoration,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.dense ? 12.0 : 18.0,
            horizontal: widget.dense ? 16.0 : 24.0,
          ),
          child: IconTheme.merge(
            data: IconThemeData(
              color: widget.style.textColor,
            ),
            child: DefaultTextStyle.merge(
              style: textStyle,
              child: widget.loading
                  ? Center(
                      child: SizedBox(
                        width: 17.0,
                        height: 17.0,
                        child: CircularProgressIndicator(
                          color: textStyle.color,
                          strokeWidth: 2.5,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 32,
                              color: widget.style == HomeButtonStyle.primary
                                  ? Palette.whiteColor
                                  : Palette.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Text(
                            widget.subTitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.style == HomeButtonStyle.primary
                                  ? Palette.whiteColor
                                  : Palette.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
