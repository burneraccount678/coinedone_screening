import 'package:coinedone_screening/constants/text_constants.dart';
import 'package:coinedone_screening/home_screen/bloc/home_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        state as Success;
        return SizedBox(
          height: 177,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    TextConstants.total,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Text(
                    state.totalDuration,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ],
              ),
              PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value:
                          state.data.data.screenTime.screenTimeClass.toDouble(),
                      showTitle: false,
                      color: Colors.blue,
                      radius: 10,
                    ),
                    PieChartSectionData(
                        value: state.data.data.screenTime.study.toDouble(),
                        showTitle: false,
                        color: Colors.orange,
                        radius: 10),
                    PieChartSectionData(
                        value: state.data.data.screenTime.free.toDouble(),
                        showTitle: false,
                        color: Colors.green,
                        radius: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
