import 'package:coinedone_screening/bloc/home_bloc.dart';
import 'package:coinedone_screening/data_layer/data_repo.dart';
import 'package:coinedone_screening/data_layer/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DataRepo(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeBloc(dataRepo: RepositoryProvider.of<DataRepo>(context))
              ..add(LoadDataEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is Loading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Failed) {
            return const Material(
                child: Center(child: Text("Something went wrong")));
          }
          state as Success;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/png/avatar.png"),
                  )),
              title: const Text(
                'Micheal',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/svg/settings.svg',
                    height: 25,
                    width: 25,
                  ),
                )
              ],
            ),
            body: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Center(
                    child: Text(
                      "Dashboard",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: 177,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
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
                              value: state.data.data.screenTime.screenTimeClass
                                  .toDouble(),
                              showTitle: false,
                              color: Colors.blue,
                              radius: 10,
                            ),
                            PieChartSectionData(
                                value:
                                    state.data.data.screenTime.study.toDouble(),
                                showTitle: false,
                                color: Colors.orange,
                                radius: 10),
                            PieChartSectionData(
                                value:
                                    state.data.data.screenTime.free.toDouble(),
                                showTitle: false,
                                color: Colors.green,
                                radius: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ScreenTimeWidget(
                            title: "Class",
                            duration: state.classDuration,
                            color: Colors.blue),
                        ScreenTimeWidget(
                            title: "Study",
                            duration: state.studyDuration,
                            color: Colors.orange),
                        ScreenTimeWidget(
                            title: "Free-time",
                            duration: state.freeTime,
                            color: Colors.green)
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      "Free-time Usage",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Used",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(state.usedfreeTime,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.green))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Max",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(state.freeTimeLimit,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blue.withOpacity(.2),
                      color: Colors.green,
                      value: state.data.data.freeTime.usage /
                          state.data.data.freeTime.limit,
                      minHeight: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 39,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Center(
                            child: Text("Extend Free-time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.blue)))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text("Change Time Restrictions",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.blue)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text("By Devices",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: List.generate(
                        state.data.data.devices.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: DeviceWidget(
                                  title: state.data.data.devices[index].name,
                                  duration: durationToString(
                                      state.data.data.devices[index].usage)),
                            )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text("See All Devices",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.blue)),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class ScreenTimeWidget extends StatelessWidget {
  const ScreenTimeWidget(
      {Key? key,
      required this.title,
      required this.duration,
      required this.color})
      : super(key: key);
  final String title;
  final String duration;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 8),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: color,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(duration),
          ],
        )
      ],
    );
  }
}

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({Key? key, required this.title, required this.duration})
      : super(key: key);
  final String title;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Center(
            child: SvgPicture.asset(title.contains("Phone")
                ? "assets/svg/phone.svg"
                : "assets/svg/laptop.svg"),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Text(
                  duration,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.blue),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
