import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.width,
    required this.progress,
    required this.percent,
  });

  final double width;
  final String progress;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('    $progress'),
          const SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            width: width * 0.23,
            lineHeight: 8,
            percent: percent,
            progressColor: kPrimaryColor,
            barRadius: const Radius.circular(6),
          )
        ],
      ),
    );
  }
}
