import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  TextInputAction? inputAction;
  int? maxLines;
  TextInputType? keyboardType;

  TextFormFieldWidget(
      {this.label, this.inputAction, this.maxLines, this.keyboardType});
  var context_;
  @override
  Widget build(BuildContext context) {
    context_ = context;
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: inputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(label!),
        border: onUnFocusedBorder,
        focusedBorder: getFocusedBorder(),
      ),
    );
  }

  OutlineInputBorder get onUnFocusedBorder {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }

  OutlineInputBorder getFocusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context_).primaryColor,
      ),
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }
}
