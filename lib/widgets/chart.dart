import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../constants/colors.dart' as colors;

class CustomChart extends StatefulWidget {
  CustomChart({super.key, required this.data});

  dynamic data;

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {

  List<FlSpot> chartSpots = [];

  @override
  void initState() {
    if (widget.data == null) {
      chartSpots = [
        const FlSpot(0, 0),
        const FlSpot(0, 0),
      ];
      return;
    }
    
    for (var i = 0; i < widget.data.length; i++) {
      chartSpots.add(FlSpot(i.toDouble(), widget.data[i]['rate'].toDouble()));
    }

    super.initState();
  }

  @override
  didUpdateWidget(CustomChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.data != oldWidget.data) {
      setState(() {
        chartSpots.clear();
        for (var i = 0; i < widget.data.length; i++) {
          chartSpots.add(FlSpot(i.toDouble(), widget.data[i]['rate'].toDouble()));
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 260,
      child: widget.data == null ? const Text("Loading") : LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 4,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (widget.data != null && index < widget.data.length) {
                    return Text(widget.data[index]['date'], style: const TextStyle(fontSize: 8));
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
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
              spots: chartSpots,
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
