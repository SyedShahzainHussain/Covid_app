import 'package:calculator_app/extension/media_query.dart';
import 'package:calculator_app/view/home_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.screenHeight * .067),
                    child: Card(
                      child: Column(children: [
                        SizedBox(
                          height: context.screenHeight * .06,
                        ),
                        ReusableRow(
                            title: "Cases", text: totalCases.toString()),
                        ReusableRow(
                          title: 'Recovered',
                          text: totalRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Death',
                          text: totalDeaths.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical',
                          text: critical.toString(),
                        ),
                        ReusableRow(
                          title: 'Today Recovered',
                          text: totalRecovered.toString(),
                        ),
                      ]),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: 50,
                  )
                ],
              )
            ]),
      ),
    );
  }
}
