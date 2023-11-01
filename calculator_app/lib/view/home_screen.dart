import 'package:calculator_app/data/response/status.dart';
import 'package:calculator_app/extension/media_query.dart';
import 'package:calculator_app/utils/utils.dart';
import 'package:calculator_app/view/countries_list.dart';
import 'package:calculator_app/viewmodel/covid_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CovidViewModel covidViewModel = CovidViewModel();

  @override
  void initState() {
    super.initState();
    covidViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    final colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   ChangeNotifierProvider(
        //     create: (context) => covidViewModel,
        //     child: Consumer<CovidViewModel>(
        //       builder: (context, value, child) {
        //         switch (value.apiResponse.status) {
        //           case (Status.Loading):
        //             return const  Center(
        //               child: Text("Loading"),
        //             );
        //           case (Status.Complete):
        //             return DropdownButton(
        //               items: [value.apiResponse.data!.deaths]
        //                   .map((e) =>
        //                       DropdownMenuItem(child: Text(e.toString()),),)
        //                   .toList(),
        //               onChanged: (value) {},
        //             );

        //           default:
        //             return  const SizedBox();
        //         }
        //       },
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => covidViewModel,
          child: Consumer<CovidViewModel>(
            builder: (context, value, child) {
              switch (value.apiResponse.status) {
                case (Status.Loading):
                  return const Center(
                    child: SpinKitFadingCircle(color: Colors.white),
                  );
                case (Status.Error):
                  return ShowMessage(
                    message: value.apiResponse.message,
                  );
                case (Status.Complete):
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(children: [
                      SizedBox(
                        height: context.screenHeight * .01,
                      ),
                      PieChart(
                        animationDuration: const Duration(milliseconds: 1200),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: context.screenWidth / 3.2,
                        dataMap: {
                          "Total": double.parse(
                              value.apiResponse.data!.cases.toString()),
                          "Recovered": double.parse(
                              value.apiResponse.data!.recovered.toString()),
                          "Deaths": double.parse(
                              value.apiResponse.data!.deaths.toString()),
                        },
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.screenHeight * .06),
                        child: Card(
                          child: Column(children: [
                            ReusableRow(
                                title: "Total",
                                text: value.apiResponse.data!.cases.toString()),
                            ReusableRow(
                                title: "Recovered",
                                text: value.apiResponse.data!.recovered
                                    .toString()),
                            ReusableRow(
                                title: "Deaths",
                                text:
                                    value.apiResponse.data!.deaths.toString()),
                            ReusableRow(
                                title: "Active",
                                text:
                                    value.apiResponse.data!.active.toString()),
                            ReusableRow(
                                title: "Critical",
                                text: value.apiResponse.data!.critical
                                    .toString()),
                            ReusableRow(
                                title: "Today Recovered",
                                text: value.apiResponse.data!.todayRecovered
                                    .toString()),
                          ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountriesList()));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      )
                    ]),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, text;
  const ReusableRow({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(text),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
