import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:salonku/app/common/currency_input_formater.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_box_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

enum InputTextType {
  text,
  email,
  password,
  number,
  paragraf,
  money,
  ktp,
  phone,
}

class InputTextController extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _con = TextEditingController();
  final Debouncer _debouncer = Debouncer();
  late Function(VoidCallback fn) setState;

  InputTextController({this.type = InputTextType.text, this.onTap});

  final bool _required = false;
  bool _showPassword = false;
  final InputTextType type;

  VoidCallback? onEditingComplete;
  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;

  String? _validator(String? v, {FormFieldValidator<String>? otherValidator}) {
    if (_required && (v?.isEmpty ?? false)) {
      return 'The field is required';
    }
    if (type == InputTextType.email) {
      const pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      final regex = RegExp(pattern);
      if ((v?.isEmpty ?? false) || !regex.hasMatch(v!)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
    if (type == InputTextType.ktp) {
      if (v!.length < 16) return "Tambahkan min. 16 digits";
    }
    if (type == InputTextType.phone) {
      if (v!.length < 10) return "Nomor Telepon minimal 10 digit";
      if (v.length > 14) return "Nomor Telepon maksimal 14 digit";
    }
    if (otherValidator != null) {
      return otherValidator(v);
    }
    return null;
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    return valid;
  }

  dynamic get value {
    if (type == InputTextType.number) {
      return num.tryParse(_con.text);
    } else if (type == InputTextType.money) {
      return InputFormatter.currencyToDouble(_con.text);
    } else {
      return _con.text;
    }
  }

  set value(dynamic value) {
    if (type == InputTextType.money) {
      value = value is int ? value.toDouble() : value;
      _con.text = value == null ? "" : InputFormatter.toCurrency(value);
    } else {
      _con.text = value == null ? "" : "$value";
    }
  }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }
}

class InputTextComponent extends StatefulWidget {
  final InputTextController controller;
  final bool required;
  final String? label;
  final bool editable;
  final String? placeHolder;
  final double? marginBottom;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final Radius? borderRadius;
  final bool? visibility;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool disableInputKeyboard;
  final Color? labelColor;

  const InputTextComponent({
    super.key,
    required this.controller,
    this.required = false,
    this.label,
    this.editable = true,
    this.placeHolder,
    this.marginBottom,
    this.inputFormatters,
    this.validator,
    this.prefixText,
    this.borderRadius,
    this.focusNode,
    this.visibility = true,
    this.prefixIcon,
    this.suffixIcon,
    this.disableInputKeyboard = false,
    this.labelColor,
  });

  @override
  State<InputTextComponent> createState() => _InputTextState();
}

class _InputTextState extends State<InputTextComponent> {
  @override
  void initState() {
    widget.controller._init((fn) {
      if (mounted) {
        setState(fn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      filled: true,
      fillColor: context.accent2.withValues(alpha: widget.editable ? .03 : .1),
      hintText: widget.placeHolder,
      hintStyle: const TextStyle(fontSize: FontSizes.normal),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
        borderSide: BorderSide(color: context.contrast, width: .1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
        borderSide: BorderSide(
          color: context.contrast,
          width: widget.editable ? .1 : .3,
        ),
      ),
      prefixText: widget.prefixText,
      prefixStyle: TextStyle(color: context.text.withValues(alpha: 0.6)),
      suffixIconConstraints: const BoxConstraints(minHeight: 30, minWidth: 30),
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.controller.type == InputTextType.password
          ? InkWell(
              splashColor: Colors.transparent,
              onTap: () => setState(() {
                widget.controller._showPassword =
                    !widget.controller._showPassword;
              }),
              child: Icon(
                widget.controller._showPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: context.text.withValues(alpha: 0.6),
                size: 15,
              ),
            )
          : widget.suffixIcon,
    );

    var textFormField = TextFormField(
      focusNode: widget.focusNode,
      maxLength: (widget.controller.type == InputTextType.ktp) ? 16 : null,
      maxLines: widget.controller.type == InputTextType.paragraf ? 4 : 1,
      onChanged: (text) {
        widget.controller.isValid;
        widget.controller.onChanged != null
            ? widget.controller._debouncer.run(
                () => widget.controller.onChanged!(text),
              )
            : null;
      },
      onSaved: widget.controller.onSaved,
      onTap: widget.controller.onTap,
      onFieldSubmitted: widget.controller.onFieldSubmitted,
      style: TextStyle(color: context.text),
      inputFormatters:
          widget.controller.type == InputTextType.number ||
              widget.controller.type == InputTextType.ktp ||
              widget.controller.type == InputTextType.phone
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\d{0,10}')),
              ...(widget.inputFormatters ?? []),
            ]
          : widget.controller.type == InputTextType.money
          ? [
              CurrencyInputFormatter.allow,
              CurrencyInputFormatter(),
              ...(widget.inputFormatters ?? []),
            ]
          : widget.inputFormatters,
      controller: widget.controller._con,
      validator: (v) =>
          widget.controller._validator(v, otherValidator: widget.validator),
      autocorrect: false,
      enableSuggestions: false,
      readOnly: !widget.editable || widget.disableInputKeyboard,
      obscureText: widget.controller.type == InputTextType.password
          ? !widget.controller._showPassword
          : false,
      onEditingComplete: widget.controller.onEditingComplete,
      keyboardType:
          (widget.controller.type == InputTextType.number ||
              widget.controller.type == InputTextType.money ||
              widget.controller.type == InputTextType.ktp ||
              widget.controller.type == InputTextType.phone)
          ? TextInputType.number
          : null,
      decoration: decoration,
    );

    return Visibility(
      visible: widget.visibility!,
      child: InputBoxComponent(
        label: widget.label,
        labelColor: widget.labelColor,
        marginBottom: widget.marginBottom,
        childText: widget.controller._con.text,
        isRequired: widget.required,
        children: Form(key: widget.controller._key, child: textFormField),
      ),
    );
  }
}

class Debouncer {
  Timer? _timer;

  Debouncer();

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 1000), action);
  }
}
