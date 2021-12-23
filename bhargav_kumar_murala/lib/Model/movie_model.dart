class Search {
  List<int>? genreIds;
  String? posterPath;
  String? title;
  String? voteAverage;

  Search(this.genreIds, this.posterPath, this.title, this.voteAverage);

  Search.fromJson(Map<String, dynamic> json) {
    genreIds = json['genre_ids'].cast<int>();
    posterPath = json['poster_path'];
    title = json['title'];
    voteAverage = json['vote_average'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genre_ids'] = genreIds;
    data['poster_path'] = posterPath;
    data['title'] = title;
    data['vote_average'] = voteAverage;
    return data;
  }
}
