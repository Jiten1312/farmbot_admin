import 'dart:math';

import 'package:farmbot_admin/controller/kisandb.dart';
import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:farmbot_admin/view/addresponse.dart';
import 'package:farmbot_admin/view/csv.dart';
import 'package:farmbot_admin/view/querytile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QueryList extends StatefulWidget {
  final List<KisanQuery> queryList;
  final List<String> plantList;
  QueryList({this.queryList, this.plantList});
  @override
  _QueryListState createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {
  int cnt = 1;
  String plant_name;
  @override
  Widget build(BuildContext context) {
    List<KisanQuery> list = getList(plant_name);
    // List<KisanQuery> list = widget.queryList;
    List<String> header = [
      'Sector',
      'Category',
      'Crop',
      'Type',
      'Text',
      'Response',
      'State',
      'District',
      'Block',
      'edit'
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('Farmbot Admin'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    askPlant(),
                    SizedBox(width: 5),
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {});
                        })
                  ],
                ),
                Container(height: 650, child: QueryTile(list: list)),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(list.length.toString() + ' queries returned',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CSV(list: list)));
                        print(list.length);
                      },
                      child: Row(
                        children: [
                          Text('export',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.file_download)
                        ],
                      ),
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //         icon: Icon(Icons.skip_previous),
                //         onPressed: () {
                //           setState(() {
                //             if (cnt != 1) {
                //               this.cnt = this.cnt - 1;
                //             }
                //           });
                //         }),
                //     Text(cnt.toString()),
                //     IconButton(
                //         icon: Icon(Icons.skip_next),
                //         onPressed: () {
                //           setState(() {
                //             // print(list.length);
                //             if (list.length > (cnt) * 10) {
                //               cnt = cnt + 1;
                //             }
                //           });
                //         }),
                //   ],
                // )
              ],
            ),
          ),
        ));
    // body: Column(
    //   children: [
    //     askPlant(),
    //     DataTable(
    //         columns: header.map((e) => DataColumn(label: Text(e))).toList(),
    //         rows: list
    //             .getRange((cnt - 1) * 10, min(cnt * 10, list.length - 1))
    //             .map((e) => DataRow(cells: [
    //                   DataCell(Text(e.category)),
    //                   DataCell(Text(e.crop)),
    //                   DataCell(Text(e.crop)),
    //                   DataCell(Text(e.query_type)),
    //                   DataCell(Text(e.query_text)),
    //                   DataCell(Text(e.response)),
    //                   DataCell(Text(e.state)),
    //                   DataCell(Text(e.district)),
    //                   DataCell(Text(e.block)),
    //                   DataCell(IconButton(
    //                       icon: Icon(Icons.edit),
    //                       onPressed: () {
    //                         Navigator.of(context).push(MaterialPageRoute(
    //                             builder: (context) => AddResponse(
    //                                   kisanQuery: e,
    //                                   flag: true,
    //                                 )));
    //                       }))
    //                 ]))
    //             .toList()),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         IconButton(
    //             icon: Icon(Icons.skip_previous),
    //             onPressed: () {
    //               setState(() {
    //                 if (cnt != 1) {
    //                   this.cnt = this.cnt - 1;
    //                 }
    //               });
    //             }),
    //         Text(cnt.toString()),
    //         IconButton(
    //             icon: Icon(Icons.skip_next),
    //             onPressed: () {
    //               setState(() {
    //                 // print(list.length);
    //                 if (list.length > (cnt) * 10) {
    //                   cnt = cnt + 1;
    //                 }
    //               });
    //             }),
    //       ],
    //     )
    //   ],
    // ));
  }

  List<KisanQuery> getList(String plant) {
    if (plant == null) {
      List<KisanQuery> nList = widget.queryList
          .where((e) => e.query_text != "સામાન્ય માહિતી")
          .toList();
      return nList;
    } else {
      List<KisanQuery> nList = widget.queryList
          .where((e) =>
              RegExp(plant).hasMatch(e.crop) &&
              e.query_text != "સામાન્ય માહિતી")
          .toList();
      return nList;
    }
  }

  Widget askPlant() {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        child: DropdownButton<String>(
          hint: Text("Crop"),
          value: this.plant_name,
          isExpanded: true,
          onChanged: (String value) {
            setState(() {
              cnt = 1;
              this.plant_name = value;
            });
          },
          items: widget.plantList.map((String plant) {
            return DropdownMenuItem<String>(
              value: (plant == 'All') ? '' : plant,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    plant,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ));
  }
}
