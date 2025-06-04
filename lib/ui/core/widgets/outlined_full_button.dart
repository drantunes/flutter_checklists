import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/base_button.dart';

class OutlinedFullButton extends StatelessWidget {
  const OutlinedFullButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: BaseButton(label: label, icon: icon),
    );
  }
}
