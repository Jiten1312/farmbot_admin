import 'package:farmbot_admin/controller/kisandb.dart';
import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:farmbot_admin/view/addresponse.dart';
import 'package:flutter/material.dart';

class QueryTile extends StatefulWidget {
  final List<KisanQuery> list;
  QueryTile({this.list});
  @override
  _QueryTileState createState() => _QueryTileState();
}

class _QueryTileState extends State<QueryTile> {
  @override
  Widget build(BuildContext context) {
    List<KisanQuery> list = widget.list;
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          // print(list.length);
          return Container(
            decoration: BoxDecoration(border: Border.all()),
            child: ExpansionTile(
              //title: Text(''),
              leading: Text(list[index].query_text,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(list[index].crop,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "જવાબ:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child:
                                  SizedBox(child: Text(list[index].response))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "પ્રકાર:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                                  child: Text(list[index].query_type))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "ક્ષેત્ર:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(child: Text(list[index].sector))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "વર્ગ:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child:
                                  SizedBox(child: Text(list[index].category))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "રાજ્ય:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(child: Text(list[index].state))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "જીલ્લો:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child:
                                  SizedBox(child: Text(list[index].district))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "બ્લોક:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(child: Text(list[index].block))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddResponse(
                                          kisanQuery: list[index],
                                          flag: true,
                                        )));
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete ' +
                                            list[index].query_text +
                                            ' ?'),
                                        content: Text('Query will be deleted'),
                                        actions: <Widget>[
                                          MaterialButton(
                                              child: Text('Cancel'),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              }),
                                          MaterialButton(
                                              child: Text('Delete'),
                                              onPressed: () async {
                                                bool res = await KisanDb()
                                                    .delete(id: list[index].id);
                                                if (res) {
                                                  setState(() {
                                                    list.removeAt(index);
                                                  });
                                                }
                                                setState(() {
                                                  list.removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      );
                                    });
                              })
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
