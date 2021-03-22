import 'package:farmbot_admin/controller/fallbackdb.dart';
import 'package:farmbot_admin/model/fallback.dart';
import 'package:farmbot_admin/view/addresponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FallbackList extends StatefulWidget {
  FallbackList({this.fallbacks});
  final List<Fallback> fallbacks;
  @override
  _FallbackListState createState() => _FallbackListState();
}

class _FallbackListState extends State<FallbackList> {
  @override
  Widget build(BuildContext context) {
    List<Fallback> list = widget.fallbacks;

    // final List<Fallback> fallbacks = Provider.of<List<Fallback>>(context);
    if (list == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Farmbot Admin'),
        ),
        body: Container(
          child: Text('No Data'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Farmbot Admin'),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            if (list[index] != null) {
              return Card(
                child: ListTile(
                  title: Text(list[index].query),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    Text('Delete ' + list[index].query + ' ?'),
                                content: Text('Fallback will be deleted'),
                                actions: <Widget>[
                                  MaterialButton(
                                      child: Text('Cancel'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      }),
                                  MaterialButton(
                                      child: Text('Delete'),
                                      onPressed: () async {
                                        bool res = await FallbackDb()
                                            .delete(id: list[index].id);
                                        if (res) {
                                          setState(() {
                                            list.removeAt(index);
                                          });
                                          // print(index.toString() + "deleted");
                                        }
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      }),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddResponse(
                              fallback: list[index],
                              flag: false,
                            )));
                  },
                ),
              );
            }
          },
        ),
      );
    }
  }
}
