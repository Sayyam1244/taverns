import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'quality_of_life_cubit.dart';
import 'quality_of_life_state.dart';

class QualityOfLifePage extends StatefulWidget {
  final QualityOfLifeCubit cubit;

  const QualityOfLifePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<QualityOfLifePage> createState() => _QualityOfLifeState();
}

class _QualityOfLifeState extends State<QualityOfLifePage> {
  QualityOfLifeCubit get cubit => widget.cubit;
  int diceNum = 1;
  int sideNum = 1;
  int modifiedNum = 1;
  String result = '';
  @override
  void initState() {
    super.initState();
  }

  // Function to simulate dice rolling and generate result string
  void rollDice() {
    // Initialize random number generator
    final random = Random();
    // Initialize variable to store the total result
    int totalResult = 0;
    // Initialize list to store individual dice roll results
    List<int> individualResults = [];

    // Generate individual dice roll results and calculate total result
    for (int i = 0; i < diceNum; i++) {
      int diceRoll = random.nextInt(sideNum) + 1;
      individualResults.add(diceRoll + modifiedNum);
      totalResult += diceRoll + modifiedNum;
    }

    // Generate the result string
    setState(() {
      result = '$diceNum d$sideNum + $modifiedNum\nTotal = $totalResult\n(';
      result += individualResults.map((result) => '$result').join(',');
      result += ')';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Quality of life"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: appTheme.yellow50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Dice Roller',
                  style: CustomTextStyles.titleMediumPrimary,
                ),
                SizedBox(height: 40),
                DiceItem(
                  title: 'Number of dice',
                  val: '$diceNum',
                  plus: () {
                    if (diceNum < 100) {
                      setState(() {
                        diceNum++;
                      });
                    }
                  },
                  minus: () {
                    if (diceNum > 1) {
                      setState(() {
                        diceNum--;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                DiceItem(
                  title: 'Number of sides',
                  val: '$sideNum',
                  plus: () {
                    if (sideNum < 100) {
                      setState(() {
                        sideNum++;
                      });
                    }
                  },
                  minus: () {
                    if (sideNum > 1) {
                      setState(() {
                        sideNum--;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                DiceItem(
                  title: 'Modifier to add',
                  val: '$modifiedNum',
                  plus: () {
                    if (modifiedNum < 100) {
                      setState(() {
                        modifiedNum++;
                      });
                    }
                  },
                  minus: () {
                    if (modifiedNum > 1) {
                      setState(() {
                        modifiedNum--;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        rollDice();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Role',
                          style: CustomTextStyles.titleMedium16
                              .copyWith(color: appTheme.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Text(
                  'Results',
                  style: CustomTextStyles.titleMediumPrimary,
                ),
                Text(
                  result,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumPrimary,
                ),
                //here resultss..
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DiceItem extends StatelessWidget {
  const DiceItem({
    Key? key,
    required this.title,
    required this.val,
    required this.plus,
    required this.minus,
  }) : super(key: key);
  final String title;
  final String val;
  final VoidCallback plus;
  final VoidCallback minus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: CustomTextStyles.titleMedium16,
        ),
        Spacer(),
        GestureDetector(
          onTap: plus,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appTheme.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            child: Text(
              '+',
              style: CustomTextStyles.titlelarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            val,
            style: CustomTextStyles.titlelarge,
          ),
        ),
        GestureDetector(
          onTap: minus,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appTheme.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            child: Text(
              '-',
              style: CustomTextStyles.titlelarge,
            ),
          ),
        )
      ],
    );
  }
}
