class Genre {
  int id;
  String name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json) : this(json["id"], json["name"]);

  static List<Genre> fromJsonToList(List<dynamic> json) =>
      List<Genre>.from(json.map((genre) => Genre.fromJson(genre)));
}
