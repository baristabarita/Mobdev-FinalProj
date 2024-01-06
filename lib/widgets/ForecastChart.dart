import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:weather_weather/models/forecast.dart'; // Ensure this path is correct
import 'package:intl/intl.dart';

class ForecastChartWidget extends StatelessWidget {
  final List<Forecast> forecastData;

  ForecastChartWidget({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set a fixed height
      width: 300, // Set a fixed width
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(18), // Optional for rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the container
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              // Configure the Right-axis labels
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true, // Set showTitles to true for right side
                  reservedSize: 25, // Reserve space for the right side labels
                  getTitlesWidget: (value, meta) {
                    // Format the value as an integer and minimize the font size
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0), // Add padding to the right side labels
                      child: Text(
                        '${value.toInt()}',
                        style: TextStyle(
                          fontSize:
                              8, // Smaller font size for right side labels
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Remove the Y-axis labels
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false), // Set showTitles to false for left side
              ),
              // Remove the Top-axis labels
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false), // Set showTitles to false for top
              ),
              // Retain the X-axis labels
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Assuming value is an index of the forecastData list
                    if (value.toInt() < forecastData.length) {
                      DateTime date = forecastData[value.toInt()].date;
                      // Format the date as you prefer
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          DateFormat.MMMd().format(date), // e.g., Jan 1
                          style: TextStyle(
                              fontSize: 10), // Font size for bottom labels
                        ),
                      );
                    }
                    return Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                  color: Colors.blueGrey, width: 1), // Border for the chart
            ),
            minX: 0,
            maxX: forecastData.length.toDouble() - 1,
            minY: forecastData.map((data) => data.temperature).reduce(min),
            maxY: forecastData.map((data) => data.temperature).reduce(max),
            lineBarsData: [
              LineChartBarData(
                spots: forecastData.asMap().entries.map((e) {
                  return FlSpot(e.key.toDouble(), e.value.temperature);
                }).toList(),
                isCurved: true,
                color: Colors.blueAccent,
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
