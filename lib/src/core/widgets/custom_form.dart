import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomForm extends StatefulWidget {
  final int quantity;
  final GlobalKey<FormState> formKey;
  final EdgeInsetsGeometry padding;
  final Function(TextEditingController controller) onTap;
  final Function(String value)? onChanged;
  final List<String? Function(String?)?>? validator;
  final List<List<TextInputFormatter>?>? inputFormatters;
  final List<String> label;
  final List<String>? hint;
  final void Function(String)? onFieldSubmitted;
  const CustomForm({
    Key? key,
    required this.quantity,
    required this.formKey,
    required this.padding,
    required this.onTap,
    required this.label,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.hint,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  List<TextEditingController> controllers() {
    final controllers = List.generate(
      widget.quantity,
      (index) => TextEditingController(),
    );
    return controllers;
  }

  @override
  void dispose() {
    for (var controller in controllers()) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forms = List.generate(
      widget.quantity,
      (index) => TextFormField(
        decoration: InputDecoration(
          labelText: widget.label[index],
          hintText: widget.hint?[index],
        ),
        validator: widget.validator?[index],
        inputFormatters: widget.inputFormatters?[index],
        onChanged: (_) {
          final value = controllers()[index].text;
          widget.onChanged?.call(value);
        },
        onFieldSubmitted: (_) {
          final value = controllers()[index].text;
          widget.onFieldSubmitted?.call(value);
        },
        onTap: () => widget.onTap.call(
          controllers()[index],
        ),
        controller: controllers()[index],
      ),
    );
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: widget.padding,
        child: Column(
          children: forms,
        ),
      ),
    );
  }
}
