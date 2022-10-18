import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  final TextInputAction? inputAction;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function()? editingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final String? Function(String?)? validate;
  String? initValue;

  TextFormFieldWidget(
      {this.label,
      this.inputAction,
      this.maxLines,
      this.keyboardType,
      this.controller,
      this.editingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validate,
      this.initValue});
   var context_;
  @override
  Widget build(BuildContext context) {
    context_ = context;
    return TextFormField(
      initialValue: initValue,
      validator: validate,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: editingComplete,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(label!),
        border: onUnFocusedBorder,
        focusedBorder: getFocusedBorder(),
        enabledBorder: onUnFocusedBorder,
        focusedErrorBorder: getErrorBorder(),
        errorBorder: getErrorBorder(),
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

  OutlineInputBorder getErrorBorder() {
    return OutlineInputBorder(
      borderSide:
          BorderSide(width: 2, color: Theme.of(context_).colorScheme.secondary),
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }
}
