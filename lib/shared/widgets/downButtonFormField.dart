import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class downButtonFormField extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String selected;
  final String hint;
  final void Function(Object?)? onChanged;
  const downButtonFormField(
      {super.key,
      required this.items,
      required this.hint,
      required this.onChanged,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.sp),
            borderSide: BorderSide(
                style: BorderStyle.solid, color: Colors.grey.shade300),
          ),
          filled: true,
        ),
        hint: Text(hint),
        isExpanded: true,
        isDense: true,
        value: 'selected',
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
