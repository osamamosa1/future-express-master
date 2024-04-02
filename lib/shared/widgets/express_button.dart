import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';

class ExpressButtonStyle {
  final BoxDecoration decoration;
  final BoxDecoration activeDecoration;
  final Color textColor;

  const ExpressButtonStyle({
    required this.decoration,
    required this.textColor,
    BoxDecoration? activeDecoration,
  }) : activeDecoration = activeDecoration ?? decoration;

  static const primary = ExpressButtonStyle(
    decoration: BoxDecoration(
      color: Palette.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    activeDecoration: BoxDecoration(
      color: Palette.primaryLightColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    textColor: Palette.whiteColor,
  );

  static final secondary = ExpressButtonStyle(
    decoration: BoxDecoration(
      color: Palette.whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(
        color: Palette.primaryColor,
        width: 1,
        // width:
      ),
    ),
    activeDecoration: BoxDecoration(
      color: Palette.greyColor.shade200,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(
        color: Palette.primaryColor,
        width: 1,
      ),
    ),
    textColor: Palette.primaryColor,
  );

  static ExpressButtonStyle text([Color? color]) {
    color ??= Palette.greyColor.shade700;

    return ExpressButtonStyle(
      decoration: BoxDecoration(
        color: color.withOpacity(0),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      activeDecoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      textColor: color,
    );
  }

  static ExpressButtonStyle dashed({
    Color color = Palette.primaryColor,
    bool filled = false,
  }) {
    return ExpressButtonStyle(
      decoration: BoxDecoration(
        color: color.withOpacity(filled ? 0.8 : 0.04),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      activeDecoration: BoxDecoration(
        color: color.withOpacity(filled ? 1 : 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      textColor: filled ? Palette.whiteColor : color,
    );
  }

  static const disabled = ExpressButtonStyle(
    decoration: BoxDecoration(
      color: Palette.disabledColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    textColor: Palette.disabledTextColor,
  );
}

class ExpressButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final Widget child;
  final bool disabled;
  final bool loading;
  final bool dense;
  final ExpressButtonStyle style;

  const ExpressButton({
    super.key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    this.dense = false,
    ExpressButtonStyle? style,
  }) : style = disabled
            ? ExpressButtonStyle.disabled
            : (style ?? ExpressButtonStyle.primary);

  @override
  State<ExpressButton> createState() => _ExpressButtonState();
}

class _ExpressButtonState extends State<ExpressButton> {
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.dense ? 2.0 : 12.0,
              horizontal: widget.dense ? 4.0 : 16.0,
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
                    : widget.child,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
