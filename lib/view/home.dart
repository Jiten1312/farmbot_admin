import 'package:farmbot_admin/controller/fallbackdb.dart';
import 'package:farmbot_admin/controller/kisandb.dart';
import 'package:farmbot_admin/model/fallback.dart';
import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:farmbot_admin/view/fallbacklist.dart';
import 'package:farmbot_admin/view/querylist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Fallback> fallbacks;
  List<KisanQuery> queryList;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Farmbot Admin'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(child: Image(image: AssetImage('assets/robot.jpg'))),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: RaisedButton(
                        child: Text('Get Kisan Query'),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic result = await KisanDb().getQuery();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => Provider.value(
                          //         value: fallbacks, child: FallbackList())));
                          dynamic plantlist = await KisanDb().getPlants();
                          List<String> plants = plantlist;
                          plants.add('All');
                          // print(plantlist);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QueryList(
                                    queryList: queryList,
                                    plantList: plants,
                                  )));
                          setState(() {
                            isLoading = false;
                            queryList = result;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 40),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: RaisedButton(
                        child: Text('Get Fallbacks'),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic result = await FallbackDb().getFallBacks();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => Provider.value(
                          //         value: fallbacks, child: FallbackList())));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FallbackList(fallbacks: fallbacks)));
                          setState(() {
                            isLoading = false;
                            fallbacks = result;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              load(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget load(bool flag) {
    if (flag == true) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }
}
