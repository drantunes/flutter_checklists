import 'package:flutter/material.dart';
import 'package:flutter_checklist/theme/theme.dart';

class PieIndicator extends StatelessWidget {
  const PieIndicator({
    super.key,
    required this.size,
    required this.value,
  });

  final double size;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: ChecklistTheme.themeColor, width: 3),
            borderRadius: BorderRadius.circular(size),
            color: (value == 1) ? ChecklistTheme.themeColor : null,
          ),
        ),
        (value == 1)
            ? Icon(Icons.check, size: size - 10, color: Colors.white)
            : CircularProgressIndicator(
                value: value,
                strokeWidth: size / 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
      ],
    );
  }
}
