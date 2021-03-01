class KisanQuery {
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

  KisanQuery(
      {this.block,
      this.category,
      this.crop,
      this.district,
      this.id,
      this.query_text,
      this.query_type,
      this.response,
      this.sector,
      this.state});
}
