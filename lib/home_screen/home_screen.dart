import 'package:coinedone_screening/constants/text_constants.dart';
import 'package:coinedone_screening/data_layer/data_repo.dart';
import 'package:coinedone_screening/data_layer/utils.dart';
import 'package:coinedone_screening/home_screen/bloc/home_bloc.dart';
import 'package:coinedone_screening/home_screen/widgets/appbar.dart';
import 'package:coinedone_screening/home_screen/widgets/chart_widget.dart';
import 'package:coinedone_screening/home_screen/widgets/device_widget.dart';
import 'package:coinedone_screening/home_screen/widgets/primary_button.dart';
import 'package:coinedone_screening/home_screen/widgets/screen_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                child: Center(child: Text(TextConstants.someThingWentWrong)));
          }
          state as Success;
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(54),
              child: CustomAppBar(),
            ),
            body: ListView(
              children: [
                const SizedBox(
                  height: 28,
                ),
                const Center(
                  child: Text(
                    TextConstants.dashboard,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const ChartWidget(),
                const SizedBox(
                  height: 44,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ScreenTimeWidget(
                            title: TextConstants.classtext,
                            duration: state.classDuration,
                            color: Colors.blue),
                        ScreenTimeWidget(
                            title: TextConstants.study,
                            duration: state.studyDuration,
                            color: Colors.orange),
                        ScreenTimeWidget(
                            title: TextConstants.freetime,
                            duration: state.freeTime,
                            color: Colors.green)
                      ]),
                ),
                const SizedBox(
                  height: 33,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                const Center(
                  child: Text(
                    TextConstants.freetimeUsage,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                            TextConstants.used,
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
                            TextConstants.max,
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
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
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
                const SizedBox(
                  height: 21,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: PrimaryButton(),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: Text(TextConstants.changeTimeRestriction,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.blue)),
                ),
                const SizedBox(
                  height: 26,
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
                    child: Text(TextConstants.byDevices,
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
                    child: Text(TextConstants.seeAllDevices,
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
