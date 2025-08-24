class DragonBallModel {
  List<Character> items;
  Meta? meta;
  Links? links;

  DragonBallModel({required this.items, this.meta, this.links});

  factory DragonBallModel.fromJson(Map<String, dynamic> json) {
    return DragonBallModel(
      items: (json['items'] as List)
          .map((item) => Character.fromJson(item))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }
}

class Character {
  int id;
  String name;
  String ki;
  String maxKi;
  String race;
  String gender;
  String description;
  String image;
  String affiliation;
  String? deletedAt;

  Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    this.deletedAt,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      ki: json['ki'],
      maxKi: json['maxKi'],
      race: json['race'],
      gender: json['gender'],
      description: json['description'],
      image: json['image'],
      affiliation: json['affiliation'],
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ki': ki,
      'maxKi': maxKi,
      'race': race,
      'gender': gender,
      'description': description,
      'image': image,
      'affiliation': affiliation,
      'deletedAt': deletedAt,
    };
  }
}

class Meta {
  int totalItems;
  int itemCount;
  int itemsPerPage;
  int currentPage;
  int totalPages;

  Meta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
      itemsPerPage: json['itemsPerPage'],
      currentPage: json['currentPage'],
      totalPages: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'itemCount': itemCount,
      'itemsPerPage': itemsPerPage,
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }
}

class Links {
  String first;
  String previous;
  String next;
  String last;

  Links({
    required this.first,
    required this.previous,
    required this.next,
    required this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      previous: json['previous'],
      next: json['next'],
      last: json['last'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'first': first, 'previous': previous, 'next': next, 'last': last};
  }
}
