class Peliculas{
  List<Pelicula> items = new List();
  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var item in jsonList){
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}


class Pelicula {
  String uniqueId;

  int votecCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.votecCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate
  });

  Pelicula.fromJsonMap(Map<String, dynamic> map){
    votecCount        = map["vote_count"];
    id                = map["id"];
    video             = map["video"];
    voteAverage       = map["vote_average"] / 1;
    title             = map["title"];
    popularity        = map["popularity"] / 1;
    posterPath        = map["poster_path"];
    originalLanguage  = map["original_language"];
    originalTitle     = map["original_title"];
    genreIds          = map["genre_ids"].cast<int>();
    backdropPath      = map["backdrop_path"];
    adult             = map["adult"];
    overview          = map["overview"];
    releaseDate       = map["release_date"];
  }

  getPosterImg(){
    if(posterPath == null){
      return 'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-stock-vector-no-image-available-icon-flat-vector.jpg?ver=6';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackdropImg(){
    if(posterPath == null){
      return 'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-stock-vector-no-image-available-icon-flat-vector.jpg?ver=6';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}