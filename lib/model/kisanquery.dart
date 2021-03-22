import 'package:flutter/cupertino.dart';

class KisanQuery extends ChangeNotifier {
  String id,
      sector,
      category,
      crop,
      query_type,
      query_text,
      response,
      state,
      district,
      block;
  bool isExpanded;
  KisanQuery(
      {this.isExpanded,
      this.block,
      this.category,
      this.crop,
      this.district,
      this.id,
      this.query_text,
      this.query_type,
      this.response,
      this.sector,
      this.state});
  void update(KisanQuery k) {
    this.category = k.category;
    this.crop = k.crop;
    this.district = k.district;
    this.query_text = k.query_text;
    this.query_type = k.query_type;
    this.response = k.response;
    this.sector = k.sector;
    this.state = k.state;
    this.block = k.block;
    notifyListeners();
  }
}
