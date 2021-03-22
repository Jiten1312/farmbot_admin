import 'dart:io';

import 'package:csv/csv.dart';
import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class CSV extends StatefulWidget {
  final List<KisanQuery> list;
  CSV({this.list});
  @override
  _CSVState createState() => _CSVState();
}

class _CSVState extends State<CSV> {
  List<KisanQuery> list;
  @override
  Widget build(BuildContext context) {
    list = widget.list;
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmbot Admin'),
      ),
      body: FutureBuilder(
          future: getCsv(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              String filePath = snapShot.data;
              if (filePath != "") {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Open File'),
                                      SizedBox(height: 25),
                                      Text(filePath.split('/').last)
                                    ],
                                  ))),
                          onTap: () async {
                            print(filePath);
                            final result = await OpenFile.open(filePath);
                            print(result.type);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                    height: 200,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Error in generating file ')));
              }
            }
            return Row(
              children: [
                Text('Please Wait...csv file is being generated'),
                CircularProgressIndicator(),
              ],
            );
          }),
    );
  }

  Future<String> getCsv() async {
    //create an element rows of type list of list. All the above data set are stored in associate list
    //Let associate be a model class with attributes name,gender and age and list be a list of associate model class.

    List<List<dynamic>> rows = List<List<dynamic>>();
    List<dynamic> row = List();
    row.add("Sector");
    row.add("Category");
    row.add("Crop");
    row.add("Query Type");
    row.add("Query Text");
    row.add("Response");
    row.add("State");
    row.add("District");
    row.add("Block");
    rows.add(row);
    for (int i = 0; i < list.length; i++) {
      //row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(list[i].sector);
      row.add(list[i].category);
      row.add(list[i].crop);
      row.add(list[i].query_type);
      row.add(list[i].query_text);
      row.add(list[i].response);
      row.add(list[i].state);
      row.add(list[i].district);
      row.add(list[i].block);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    // print(csv);

    try {
      String dir = (await getExternalStorageDirectory()).absolute.path + "/";

      print(dir);
      String filePath =
          dir + "csv_" + DateTime.now().toIso8601String() + '.csv';
      File f = new File(filePath);
      print(filePath);
      f.writeAsString(csv);

      return filePath;
    } catch (e) {
      print(e);
    }
    return '';
  }
}
