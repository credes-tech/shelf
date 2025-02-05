import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final Color color;
  final ValueChanged<bool> onChanged;

  CustomSwitch({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.color,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isChecked;
  late Color color;
  double position = 0.0; // To track the position of the switch

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
    color = widget.color;
    position = isChecked ? 30.0 : 0.0; // Initialize the position
  }

  void _toggleSwitch() {
    setState(() {
      isChecked = !isChecked;
      position = isChecked ? 30.0 : 0.0;
    });

    widget.onChanged(isChecked); // Notify the parent about the change
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
          _toggleSwitch(); // Toggle to the "on" position
        } else {
          _toggleSwitch(); // Toggle to the "off" position
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 30.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: isChecked ? color : Colors.grey,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    // Adding an arrow to the track
                    Positioned(
                      right: 5,
                      top: 4,
                      child: Icon(
                        Icons.arrow_forward,
                        color: color,
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
