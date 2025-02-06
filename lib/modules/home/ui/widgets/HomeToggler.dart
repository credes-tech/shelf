import 'package:flutter/material.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';

class HomeToggler extends StatefulWidget {
  final bool initialValue;
  final Color color;
  final ValueChanged<bool> onChanged;

  const HomeToggler({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.color,
  });

  @override
  _HomeTogglerState createState() => _HomeTogglerState();
}

class _HomeTogglerState extends State<HomeToggler> {
  late bool isChecked;
  late Color color;
  double position = 0.0;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
    color = widget.color;
    position = isChecked ? 30.0 : 0.0;
  }

  void _toggleSwitch() {
    setState(() {
      isChecked = !isChecked;
      position = isChecked ? 30.0 : 0.0;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.localPosition.dx < 0) return; // Prevent left swipe
        setState(() {
          position = details.localPosition.dx.clamp(0.0, 3.0);
        });
      },
      onHorizontalDragEnd: (details) {
        if (position > 15.0) {
          _toggleSwitch();
        } else {
          _toggleSwitch();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 35.0,
        width: 65.0,
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xSmall, vertical: AppSpacing.xxSmall),
        decoration: BoxDecoration(
          color: isChecked ? color : Colors.black12,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Positioned(
              left: position,
              top: 3,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  color: isChecked? Colors.white: color,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 5,
                      top: 4,
                      child: Icon(
                        Icons.arrow_forward,
                        color: isChecked ? color : Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
