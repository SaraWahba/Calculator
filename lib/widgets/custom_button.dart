import 'package:flutter/material.dart';

import '../constens.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.text,
    required this.darkMode,
    this.style2 = false,
    this.style3 = false,
    this.colorSpecial = false,
    this.widget,
    this.onTap,
  });
  final String? text;
  final bool darkMode;
  final bool style2;
  final bool style3;
  final bool colorSpecial;
  final Widget? widget;
  final void Function()? onTap;

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: Container(
          width: widget.style2
              ? 65
              : widget.style3
                  ? 65
                  : 55,
          height: widget.style2
              ? 45
              : widget.style3
                  ? 30
                  : 55,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: widget.darkMode ? colorDark : colorLight,
            boxShadow: isPressed
                ? null
                : [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4, 4),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1, -1),
                    )
                  ],
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: widget.text == null
                ? widget.widget
                : Text(
                    widget.text!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: widget.style2 ? 25 : 30,
                        color: widget.darkMode
                            ? widget.colorSpecial
                                ? Colors.green
                                : Colors.white
                            : widget.colorSpecial
                                ? Colors.red
                                : Colors.black),
                  ),
          ),
        ),
      ),
    );
  }

  void onPointerDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  void onPointerUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }
}
