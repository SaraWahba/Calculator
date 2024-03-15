import 'dart:math' as math;

import 'package:calculator/widgets/custom_text_view.dart';
import 'package:flutter/material.dart';

import 'btn.dart';
import 'constens.dart';
import 'widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool darkMode = false;
  bool isCalculator = false;
  String finalResult = "";
  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                darkMode: darkMode,
                style3: true,
                widget: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      darkMode = !darkMode;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.sunny,
                        color: darkMode ? Colors.grey : Colors.red,
                        size: 20,
                      ),
                      Icon(
                        Icons.bedtime,
                        color: darkMode ? Colors.green : Colors.grey,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomTextView(
                darkMode: darkMode,
                isCalculator: isCalculator,
                numberString: "$number1$operand$number2".isEmpty
                    ? "0"
                    : "$number1$operand$number2",
                result: finalResult.isEmpty ? "0" : finalResult,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue1.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    style2: true,
                    text: Btn.buttonsValue1[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue1[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue2.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    colorSpecial: Btn.buttonsValue2[index] == Btn.clr ||
                            Btn.buttonsValue2[index] == Btn.div
                        ? true
                        : false,
                    text: Btn.buttonsValue2[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue2[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue3.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    colorSpecial:
                        Btn.buttonsValue3[index] == Btn.mul ? true : false,
                    text: Btn.buttonsValue3[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue3[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue4.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    colorSpecial:
                        Btn.buttonsValue4[index] == Btn.sub ? true : false,
                    text: Btn.buttonsValue4[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue4[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue5.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    colorSpecial:
                        Btn.buttonsValue5[index] == Btn.plus ? true : false,
                    text: Btn.buttonsValue5[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue5[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  Btn.buttonsValue6.length,
                  (index) => CustomButton(
                    darkMode: darkMode,
                    colorSpecial: Btn.buttonsValue6[index] == Btn.del ||
                            Btn.buttonsValue6[index] == Btn.cal
                        ? true
                        : false,
                    text: Btn.buttonsValue6[index],
                    onTap: () {
                      onBtnTap(Btn.buttonsValue6[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.per) {
      moreOperations(value);
      return;
    }
    if (value == Btn.sin) {
      moreOperations(value);
      return;
    }
    if (value == Btn.cos) {
      moreOperations(value);
      return;
    }
    if (value == Btn.tan) {
      moreOperations(value);
      return;
    }
    if (value == Btn.cal) {
      calculate();
      setState(() {
        isCalculator = true;
      });
      return;
    }
    numberValue(value);
  }

  void delete() {
    if (isCalculator) {
      clearAll();
    }
    setState(() {
      if (number1.isNotEmpty) {
        number1 = number1.substring(0, number1.length - 1);
      } else if (operand.isNotEmpty) {
        operand = "";
      } else if (number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
      }
    });
  }

  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
      finalResult = "";
      isCalculator = false;
    });
  }

  void moreOperations(String value) {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();

      if (value == Btn.per) {
        setState(() {
          final number = double.parse(finalResult);
          finalResult = "${(number / 100)}";
          number1 = "($number1";
          number2 += ")%";
          isCalculator = true;
        });
      } else if (value == Btn.sin) {
        setState(() {
          final number = double.parse(finalResult);
          finalResult = "${math.sin(number)}";
          number1 = "sin($number1";
          number2 += ")";
          isCalculator = true;
        });
      } else if (value == Btn.cos) {
        setState(() {
          final number = double.parse(finalResult);
          finalResult = "${math.cos(number)}";
          number1 = "cos($number1";
          number2 += ")";
          isCalculator = true;
        });
      } else if (value == Btn.tan) {
        setState(() {
          final number = double.parse(finalResult);
          finalResult = "${math.tan(number)}";
          number1 = "tan($number1";
          number2 += ")";
          isCalculator = true;
        });
      }
    }
    if (number1.isNotEmpty && operand.isEmpty && number2.isEmpty) {
      if (value == Btn.per) {
        setState(() {
          final number = double.parse(number1);
          finalResult = "${(number / 100)}";
          number1 = "($number1)%";
          isCalculator = true;
        });
      } else if (value == Btn.sin) {
        setState(() {
          final number = double.parse(number1);
          finalResult = "${math.sin(number)}";
          number1 = "sin($number1)";
          isCalculator = true;
        });
      } else if (value == Btn.cos) {
        setState(() {
          final number = double.parse(number1);
          finalResult = "${math.cos(number)}";
          number1 = "cos($number1)";
          isCalculator = true;
        });
      } else if (value == Btn.tan) {
        setState(() {
          final number = double.parse(number1);
          finalResult = "${math.tan(number)}";
          number1 = "tan($number1)";
          isCalculator = true;
        });
      }
    }
    if (operand.isNotEmpty) {
      return;
    }
  }

  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    double result = 0.0;
    switch (operand) {
      case Btn.plus:
        result = num1 + num2;
        break;
      case Btn.sub:
        result = num1 - num2;
        break;
      case Btn.mul:
        result = num1 * num2;
        break;
      case Btn.div:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      finalResult = result.toString();
      finalResult = result.toStringAsPrecision(3);

      if (finalResult.endsWith(".0")) {
        finalResult = finalResult.substring(0, finalResult.length - 2);
      }
    });
  }

  void numberValue(String value) {
    setState(() {
      if (isCalculator) {
        clearAll();
      }

      // number1 opernad number2
      // 234       +      5343

      // if is operand and not "."
      if (value != Btn.dot && int.tryParse(value) == null) {
        // operand pressed
        if (operand.isNotEmpty && number2.isNotEmpty) {
          // TODO calculate the equation before assigning new operand
          calculate();
        }
        if (operand.isNotEmpty) {
          number1 = finalResult;
          number2 = "";
        }

        operand = value;
      }
      // assign value to number1 variable
      else if (number1.isEmpty || operand.isEmpty) {
        // check if value is "." | ex: number1 = "1.2"
        if (value == Btn.dot && number1.contains(Btn.dot)) return;
        if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
          // ex: number1 = "" | "0"
          value = "0.";
        }
        number1 += value;
      }
      // assign value to number2 variable
      else if (number2.isEmpty || operand.isNotEmpty) {
        // check if value is "." | ex: number1 = "1.2"
        if (value == Btn.dot && number2.contains(Btn.dot)) return;
        if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
          // number1 = "" | "0"
          value = "0.";
        }
        number2 += value;
        calculate();
      }
    });
  }
}
