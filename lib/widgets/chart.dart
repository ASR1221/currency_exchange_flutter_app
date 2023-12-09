import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import '../constants/colors.dart' as colors;

class CustomChart extends StatefulWidget {
  const CustomChart({super.key});

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  final List<FlSpot> dummyData1 = List.generate(10, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 260,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          backgroundColor: Colors.transparent,  // test bg color
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: colors.bottomNavBarActiveColor.withOpacity(0.5),
              tooltipRoundedRadius: 13,
              maxContentWidth: 90,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  const textStyle = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  );
                  return LineTooltipItem(touchedSpot.y.toString(), textStyle);
                }).toList();
              }
            )
          ),
          lineBarsData: [
            LineChartBarData(
              dotData: const FlDotData(show: false),
              isStrokeCapRound: true,
              spots: dummyData1,
              isCurved: true,
              barWidth: 3,
              color: colors.bottomNavBarActiveColor,
              belowBarData: BarAreaData(  // test if fills with color
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.bottomNavBarActiveColor.withOpacity(.7), colors.bottomNavBarActiveColor.withOpacity(.05)],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      ),
    );
  }
}
