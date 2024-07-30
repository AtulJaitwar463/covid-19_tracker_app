
import 'dart:js';

import 'package:covid_tracker/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalRecovered, totalDeaths, active, critical, todayRecovered, test;
   DetailScreen({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,

   }) ;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height *.06,),
                      Reusable(title: 'Cases', value: widget.totalCases.toString()),
                      Reusable(title: 'Recovered', value: widget.totalRecovered.toString()),
                      Reusable(title: 'Deaths', value: widget.totalDeaths.toString()),
                      Reusable(title: 'Critical', value: widget.critical.toString()),Reusable(title: 'Cases', value: widget.totalCases.toString()),
                      Reusable(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      //Reusable(title: 'Cases', value: widget.totalCases.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      ),
    );
  }
}
