import 'package:covid/View/world_states.dart';
import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {

  String name;
  String image;
  int totalCase , totalDeaths, totalRecovered,active, critical , todayRecovered , test ;

  DetailScreen(
      {
        required this.name,
        required this.image,
        required this.totalCase,
        required this.totalDeaths,
        required this.totalRecovered,
        required this.active,
        required this.critical,
        required this.todayRecovered,
        required this.test
      });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  backgroundColor: Colors.red,
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
                padding : EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height* .06,),
                      ReusableRow(title: "Cases", value: widget.totalCase.toString()),
                      ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Total Recovered", value: widget.totalRecovered.toString()),
                      ReusableRow(title: "Death", value: widget.totalDeaths.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Active Cases", value: widget.active.toString()),
                      ReusableRow(title: "Test", value: widget.test.toString()),
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
