import 'package:calculator/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomTextView extends StatefulWidget {
  const CustomTextView({
    super.key,
    required this.darkMode,
    required this.numberString,
    required this.result,
    required this.isCalculator,
  });
  final bool darkMode;
  final String numberString;
  final String result;
  final bool isCalculator;

  @override
  State<CustomTextView> createState() => _CustomTextViewState();
}

class _CustomTextViewState extends State<CustomTextView> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: widget.darkMode ? colorDark : colorLight, width: 8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .15,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.darkMode
              ? const Color((0xFF88A273))
              : const Color(0xFFC3D1B7),
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Colors.red, width: 8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              child: Text(
                widget.numberString,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isCalculator ? 20 : 25,
                    color: widget.isCalculator ? Colors.black45 : Colors.black),
              ),
            ),
            Text(
              widget.result,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.isCalculator ? 25 : 20,
                  color: widget.isCalculator ? Colors.black : Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
