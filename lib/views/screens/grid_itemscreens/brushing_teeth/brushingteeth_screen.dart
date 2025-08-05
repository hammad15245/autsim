import 'package:autism_fyp/views/screens/grid_itemscreens/brushing_teeth/brushingteeth_controller.dart';
import 'package:autism_fyp/views/screens/progressheader.dart';
import 'package:autism_fyp/views/widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BrushingteethScreen extends StatefulWidget {
  const BrushingteethScreen({super.key});

  @override
  State<BrushingteethScreen> createState() => _BrushingteethScreenState();
}

class _BrushingteethScreenState extends State<BrushingteethScreen> {
final GlobalKey<ColorChangingButtonState> buttonKey = GlobalKey();

  void handleAnswer(bool isCorrect) {
    final buttonState = buttonKey.currentState;
    if (buttonState != null) {
      buttonState.changeColor(isCorrect ? Colors.green : Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StepProgressHeader(
                  currentStep: 1,
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Consumer<BrushingTeethController>(
                    builder: (context, controller, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: controller.getStars(size: 28.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'What does this picture refers to?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: Image.asset(
                  'lib/assets/learning_module_ASSETS/toothbrush.png',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2.5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ColorChangingButton(
                        key: buttonKey,
                        text: 'Toothbrush',
                        onPressed: () {
                          handleAnswer(true);
                        },
                      ),
                      ColorChangingButton(
                        text: 'spoon',
                        onPressed: () {
                          handleAnswer(false);
                        },
                      ),
                      ColorChangingButton(
                        text: 'Comb',
                        onPressed: () {
                          handleAnswer(false);
                        },
                      ),
                      ColorChangingButton(
                        text: 'Towel',
                        onPressed: () {
                          handleAnswer(false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: screenHeight * 0.07),
              Align(
                                  alignment: Alignment.bottomCenter,

                child: Center(
                
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E83AD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      text: 'Next',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
