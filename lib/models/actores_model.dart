class Cast{

  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    jsonList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath
  });

  Actor.fromJsonMap(Map<String, dynamic> map){
    castId      = map['cast_id'];
    character   = map['character'];
    creditId    = map['credit_id'];
    gender      = map['gender'];
    id          = map['id'];
    name        = map['name'];
    order       = map['order'];
    profilePath = map['profile_path'];
  }

  getFoto(){
    if(profilePath == null){
      return 'https://slcp.lk/wp-content/uploads/2020/02/no-profile-photo.png';
    } else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

