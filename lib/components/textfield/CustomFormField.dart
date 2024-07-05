import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_clearError);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_clearError);
    super.dispose();
  }

  void _clearError() {
    if (_errorText != null && widget.controller.text.isNotEmpty) {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorText: _errorText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        obscureText: widget.isPassword ? _obscureText : false,
        onChanged: (value) {
          _clearError();
        },
        validator: (value) {
          final validationResult =
              widget.validator != null ? widget.validator!(value) : null;
          setState(() {
            _errorText = validationResult;
          });
          return validationResult;
        },
      ),
    );
  }
}
