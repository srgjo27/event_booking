import 'package:event_booking/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    _isOn = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOn = !_isOn;
        });
        widget.onChanged(_isOn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 45.w,
        height: 25.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          color: _isOn ? AppColors.primary : Colors.grey.shade200,
          border: Border.all(
            color: _isOn ? AppColors.primary : Colors.grey.shade400,
            width: 1.w,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: _isOn ? 20.w : 0.w,
              top: -1.h,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _isOn ? AppColors.primary : Colors.grey.shade400,
                    width: 1.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
