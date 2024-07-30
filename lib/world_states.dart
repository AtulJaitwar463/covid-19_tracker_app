import 'dart:async';

import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/countries_list.dart';
import 'package:covid_tracker/model/world_statesmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/worldstatesmodel.dart';

class WorlsStatesScreen extends StatefulWidget {
  const WorlsStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorlsStatesScreen> createState() => _WorlsStatesScreenState();
}

class _WorlsStatesScreenState extends State<WorlsStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorlsStatesScreen())));
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices  statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesmodel> snapshot){
                if(snapshot.hasData){
                  return Expanded(
                      flex: 1,

                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      )


                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total':
                          100,
                          //double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': 75,
                          //double.parse(snapshot.data!.recovered.toString()),
                          'Deaths': 25,
                      //double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ) ,
                        chartRadius: MediaQuery.of(context).size.height / 3.2,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              //Reusable(title: 'Total', value: snapshot.data!.cases.toString()),
                              Reusable(title: 'Total', value: '200'),
                              Reusable(title: 'Total', value: '200'),
                              Reusable(title: 'Total', value: '200'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap : (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=> CountriesList()));

                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Center(
                            child: Text('Track Countries'),
                          ) ,
                        ),
                      )

                    ],
                  );

                }

              }),

            ],
          ),
        ),
      ),
    );
  }
}

class Reusable extends StatelessWidget {
  String title, value;
  Reusable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          //Divider(),
        ],
      ),
    );
  }
}
