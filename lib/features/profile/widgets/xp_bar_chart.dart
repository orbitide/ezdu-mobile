import 'package:ezdu/core/utils/helpers.dart';
import 'package:ezdu/features/profile/models/progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class XPBarChart extends StatelessWidget {
  const XPBarChart({super.key, required this.data});

  final List<DailyProgress> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    final maxXP =
        ((data.map((e) => e.xp).reduce((a, b) => a > b ? a : b) + 9) ~/ 10) *
        10;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: BarChart(
        BarChartData(
          maxY: maxXP.toDouble() * 1.2,
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final daily = entry.value;
            final isToday = true;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: daily.xp.toDouble(),
                  width: 32,
                  color: isToday
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxXP.toDouble(),
                    color: Colors.grey.shade400.withValues(alpha: 0.2),
                  ),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final daily = data[value.toInt()];
                  return Text(
                    daily.xp.toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final daily = data[value.toInt()].day;
                  final date = TimeHelper.utcToLocalDateTime(daily);
                  final dayName = _getDayName(date.weekday);
                  return Text(
                    dayName,
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}

String _getDayName(int weekday) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[weekday - 1];
}