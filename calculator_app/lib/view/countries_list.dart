import 'package:calculator_app/data/response/status.dart';
import 'package:calculator_app/utils/utils.dart';
import 'package:calculator_app/view/detailScreen.dart';
import 'package:calculator_app/viewmodel/covid_countries_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  CovidCountriesViewModel countriesViewModel = CovidCountriesViewModel();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    countriesViewModel.getDataCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: controller,
            onChanged: (val) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: "Search with country name",
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => countriesViewModel,
          child: Consumer<CovidCountriesViewModel>(
            builder: (context, value, child) {
              switch (value.apiResponse.status) {
                case (Status.Loading):
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, _) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          title: Container(
                            height: 10,
                            color: Colors.white,
                          ),
                          subtitle: Container(height: 10, color: Colors.white),
                          leading: Container(
                              height: 50, width: 50, color: Colors.white),
                        ),
                      ),
                      itemCount: 10,
                    ),
                  );

                case (Status.Error):
                  return ShowMessage(
                    message: value.apiResponse.message,
                  );

                case (Status.Complete):
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.apiResponse.data!.length,
                      itemBuilder: (context, index) {
                        String name =
                            value.apiResponse.data![index].country.toString();

                        if (controller.text.isEmpty) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    image: value.apiResponse.data![index]
                                        .countryInfo!.flag
                                        .toString(),
                                    name: value.apiResponse.data![index].country
                                        .toString(),
                                    totalCases:
                                        value.apiResponse.data![index].cases!,
                                    totalRecovered: value
                                        .apiResponse.data![index].recovered!,
                                    totalDeaths:
                                        value.apiResponse.data![index].deaths!,
                                    active:
                                        value.apiResponse.data![index].active!,
                                    test: value.apiResponse.data![index].tests!,
                                    todayRecovered: value.apiResponse
                                        .data![index].todayRecovered!,
                                    critical: value
                                        .apiResponse.data![index].critical!,
                                  ),
                                ),
                              );
                            },
                            title: Text(value.apiResponse.data![index].country
                                .toString()),
                            subtitle: Text(value.apiResponse.data![index].cases
                                .toString()),
                            leading: Image(
                              width: 50,
                              height: 50,
                              image: NetworkImage(value
                                  .apiResponse.data![index].countryInfo!.flag
                                  .toString()),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(controller.text.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    image: value.apiResponse.data![index]
                                        .countryInfo!.flag
                                        .toString(),
                                    name: value.apiResponse.data![index].country
                                        .toString(),
                                    totalCases:
                                        value.apiResponse.data![index].cases!,
                                    totalRecovered: value
                                        .apiResponse.data![index].recovered!,
                                    totalDeaths:
                                        value.apiResponse.data![index].deaths!,
                                    active:
                                        value.apiResponse.data![index].active!,
                                    test: value.apiResponse.data![index].tests!,
                                    todayRecovered: value.apiResponse
                                        .data![index].todayRecovered!,
                                    critical: value
                                        .apiResponse.data![index].critical!,
                                  ),
                                ),
                              );
                            },
                            title: Text(value.apiResponse.data![index].country
                                .toString()),
                            subtitle: Text(value.apiResponse.data![index].cases
                                .toString()),
                            leading: Image(
                              width: 50,
                              height: 50,
                              image: NetworkImage(value
                                  .apiResponse.data![index].countryInfo!.flag
                                  .toString()),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
        )
      ]),
    );
  }
}
