
class PopularTvShows {
  List<PopularTvShows>? results;

  PopularTvShows(
    {
      this.results
    }
  );
  PopularTvShows.fromJson(Map<String, dynamic> json) {

  } 
}

class PopularMovies {
  int? page;
  int? totalResults;
  int? totalPages;
  List<Results> ?results;
  int? id;
  String? title;

  PopularMovies(
      {this.title,
      this.id,
      this.page,
      this.totalResults,
      this.totalPages,
      this.results});

  PopularMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    id = json['id'];
    title = json['title'];
    results =
        List<Results>.from(json['results'].map((it) => Results.fromJson(it)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  // double popularity;
  int? voteCount;
  bool? video;
  String? posterPath;
  int? id;
  bool? adult;
  String? backdropPath;
  String? originalLanguage;
  String? originalTitle;
  List<int>? genreIds;
  String? title;
  double? voteAverage;
  String? overview;
  String? releaseDate;

  Results(
      {
        // this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    // popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}

class MovieDetails {
  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? overview;
  final String? title;
  final String? status;
  final String? posterPath;
  final num? voteAverage;
  final String? releaseDate;
  final num? duration;

  MovieDetails({
    this.duration,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.posterPath,
    this.status,
    this.overview,
    this.adult,
    this.backdropPath,
    this.budget,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      // originalTitle: json['original_title'],
      overview: json['overview'],
      status: json['status'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'],
      title: json['title'],
      releaseDate: json['release_date'],
      duration: json['runtime'],
    );
  }
}
