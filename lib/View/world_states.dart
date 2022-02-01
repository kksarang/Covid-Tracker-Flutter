import 'package:covid/Model/world_states_model.dart';
import 'package:covid/Services/state_services.dart';
import 'package:covid/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285D4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
    const Color(0xff7e5242)
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    //fetchWorledStatesRecords

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [


              SizedBox(height:  MediaQuery.of(context).size.height * .01,),

           //fetch api
              FutureBuilder(
                  future: statesServices.fetchWorledStatesRecords(),
                  builder: (context ,AsyncSnapshot<World_cases> snapshot){

                if(!snapshot.hasData)
                  {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  }
                else
                  {
                    return Column(
                      children: [
                        //   Divider(),
                        PieChart(
                          dataMap :
                          {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                        //  "active": double.parse(snapshot.data!.active.toString()),
                          },

                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),

                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList:colorList,
                        ),
                        //   Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [

                                ReusableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                                ReusableRow(title: 'Active',value: snapshot.data!.active.toString(),),
                                ReusableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                                ReusableRow(title: 'Today Cases',value: snapshot.data!.todayCases.toString(),),
                                ReusableRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString(),),
                                ReusableRow(title: 'Today Deaths',value: snapshot.data!.todayDeaths.toString(),),
                                ReusableRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),

                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const CountriesListScrren()));
                          },
                          child: Container(
                            height: 50,
                            decoration:  BoxDecoration(
                              color:const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text('Track Countries'),

                            ),
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


class ReusableRow extends StatelessWidget {

  String title, value;

   ReusableRow({Key? key , required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
