import 'package:farmbot_admin/controller/fallbackdb.dart';
import 'package:farmbot_admin/controller/kisandb.dart';
import 'package:farmbot_admin/model/category.dart';

import 'package:farmbot_admin/model/fallback.dart';
import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:farmbot_admin/model/mystate.dart';

import 'package:farmbot_admin/model/sector.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddResponse extends StatefulWidget {
  Fallback fallback;

  KisanQuery kisanQuery;
  bool flag; //0 for Fallback, 1 for Kisan
  AddResponse({this.fallback, this.kisanQuery, this.flag});
  @override
  _AddResponseState createState() => _AddResponseState();
}

class _AddResponseState extends State<AddResponse> {
  String alert;
  String sector,
      category,
      crop,
      queryType,
      response,
      queryText,
      state,
      district,
      block;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Farmbot Admin')),
      body: ListView(
        children: [
          showAlert(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('Select Sector'),
                        ),
                      ),
                      askSector(),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('Select Cateory'),
                        ),
                      ),
                      askCategory(),
                    ],
                  ),
                  Row(children: [
                    SizedBox(
                        width: 140,
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text('Select State'))),
                    askState(),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'query text'),
                      initialValue: (widget.fallback != null)
                          ? widget.fallback.query
                          : widget.kisanQuery.query_text,
                      onSaved: (value) {
                        setState(() {
                          this.queryText = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'crop'),
                      initialValue: (widget.kisanQuery != null)
                          ? widget.kisanQuery.crop
                          : '',
                      onSaved: (value) {
                        setState(() {
                          crop = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Query Type'),
                      initialValue: (widget.kisanQuery != null)
                          ? widget.kisanQuery.query_type
                          : '',
                      onSaved: (value) {
                        setState(() {
                          queryType = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Response'),
                      initialValue: (widget.kisanQuery != null)
                          ? widget.kisanQuery.response
                          : '',
                      onSaved: (value) {
                        setState(() {
                          response = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'District'),
                      initialValue: (widget.kisanQuery != null)
                          ? widget.kisanQuery.district
                          : '',
                      onSaved: (value) {
                        setState(() {
                          district = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'block'),
                      initialValue: (widget.kisanQuery != null)
                          ? widget.kisanQuery.block
                          : '',
                      onSaved: (value) {
                        setState(() {
                          block = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return '*required field';
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.deepPurple,
                    child: Container(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      if (this.sector == null ||
                          this.category == null ||
                          this.state == null) {
                        // Fluttertoast.showToast(
                        //     msg: "Internal error accoured",
                        //     timeInSecForIosWeb: 4);
                        setState(() {
                          alert = 'All fields are required';
                        });
                      }
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(response);
                        KisanQuery kisanQuery = new KisanQuery(
                            query_text: queryText,
                            query_type: queryType,
                            response: response,
                            sector: sector,
                            state: state,
                            district: district,
                            category: category,
                            crop: crop,
                            block: block);
                        if (widget.flag == false) {
                          bool res = await KisanDb().addQuery(kisanQuery);
                          if (res) {
                            bool del = await FallbackDb()
                                .delete(id: widget.fallback.id);
                            print(del);
                            setState(() {
                              alert = 'Response Added Succsessfully';
                            });
                          } else {
                            setState(() {
                              alert = 'Internal Error Accoured';
                            });
                          }
                        } else {
                          bool res = await KisanDb()
                              .update(kisanQuery, widget.kisanQuery.id);
                          if (res) {
                            setState(() {
                              alert = 'Response Updated Succsessfully';
                            });
                          } else {
                            setState(() {
                              alert = 'Internal Error Accoured';
                            });
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showAlert() {
    if (this.alert == null) {
      return Container();
    } else {
      return SizedBox(
        //height: 40,
        child: Container(
          color: Colors.yellowAccent,
          child: ListTile(
            leading: Icon(Icons.error_outline),
            title: Container(
              child: Text(alert),
            ),
            trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    alert = null;
                  });
                }),
          ),
        ),
      );
    }
  }

  Widget askSector() {
    List<String> sectors = Sector().getSectors();
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: DropdownButton<String>(
        hint: Text("Sector"),
        value: this.sector,
        isExpanded: true,
        onChanged: (String value) {
          setState(() {
            this.sector = value;
            this.category = null;
          });
        },
        items: sectors.map((String sector) {
          return DropdownMenuItem<String>(
            value: sector,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  sector,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget askCategory() {
    List<String> categories = Category().getCategory(this.sector);
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        child: DropdownButton<String>(
          hint: Text("Category"),
          value: this.category,
          isExpanded: true,
          onChanged: (String value) {
            setState(() {
              this.category = value;
            });
          },
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    category,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ));
  }

  Widget askState() {
    List<String> states = MyState().getState();
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text("State"),
        value: this.state,
        onChanged: (String value) {
          setState(() {
            this.state = value;
            this.district = null;
          });
        },
        items: states.map((String text) {
          return DropdownMenuItem<String>(
            value: text,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
