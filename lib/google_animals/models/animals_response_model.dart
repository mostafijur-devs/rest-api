// import 'package:rest_api/google_animals/models/animals.dart';
//
// class AnimalsResponseModel{
//   String? kind;
//   int? totalItems;
//   List<Animals>? items;
//   AnimalsResponseModel({this.kind,this.totalItems,this.items});
//
//   factory AnimalsResponseModel.fromJson(Map<String,dynamic>json){
//     var animalsResponseModel = AnimalsResponseModel();
//     animalsResponseModel.kind = json['kind'];
//     animalsResponseModel.totalItems = json['totalItems'];
//     animalsResponseModel.items = [];
//     for(var item in json['items']) {
//       animalsResponseModel.items?.add(Animals.fromJson(item));
//     }
//     return animalsResponseModel;
//     }
//   }

class AnimalsRespons {
  String? kind;
  int? totalItems;
  List<Items>? items;

  AnimalsRespons({this.kind, this.totalItems, this.items});

  AnimalsRespons.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['totalItems'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;

  Items({this.kind, this.id, this.etag, this.selfLink, this.volumeInfo});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    etag = json['etag'];
    selfLink = json['selfLink'];
    volumeInfo = json['volumeInfo'] != null
        ? new VolumeInfo.fromJson(json['volumeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['id'] = this.id;
    data['etag'] = this.etag;
    data['selfLink'] = this.selfLink;
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo!.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  String? title;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  ReadingModes? readingModes;
  int? pageCount;
  String? printType;
  List<String>? categories;
  String? maturityRating;
  bool? allowAnonLogging;
  String? contentVersion;
  PanelizationSummary? panelizationSummary;
  ImageLinks? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;
  String? canonicalVolumeLink;

  VolumeInfo(
      {this.title,
        this.authors,
        this.publisher,
        this.publishedDate,
        this.description,
        this.readingModes,
        this.pageCount,
        this.printType,
        this.categories,
        this.maturityRating,
        this.allowAnonLogging,
        this.contentVersion,
        this.panelizationSummary,
        this.imageLinks,
        this.language,
        this.previewLink,
        this.infoLink,
        this.canonicalVolumeLink});

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authors = json['authors'] !=null?List.from(json['authors']):null;
    publisher = json['publisher'];
    publishedDate = json['publishedDate'];
    description = json['description'];
    readingModes = json['readingModes'] != null
        ? new ReadingModes.fromJson(json['readingModes'])
        : null;
    pageCount = json['pageCount'];
    printType = json['printType'];

    // single List casting in dart List name = ['polok']
    categories = json['categories'] !=null?List.from(json['categories']):null;
    maturityRating = json['maturityRating'];
    allowAnonLogging = json['allowAnonLogging'];
    contentVersion = json['contentVersion'];
    panelizationSummary = json['panelizationSummary'] != null
        ? new PanelizationSummary.fromJson(json['panelizationSummary'])
        : null;
    imageLinks = json['imageLinks'] != null
        ? new ImageLinks.fromJson(json['imageLinks'])
        : null;
    language = json['language'];
    previewLink = json['previewLink'];
    infoLink = json['infoLink'];
    canonicalVolumeLink = json['canonicalVolumeLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['publisher'] = this.publisher;
    data['publishedDate'] = this.publishedDate;
    data['description'] = this.description;
    if (this.readingModes != null) {
      data['readingModes'] = this.readingModes!.toJson();
    }
    data['pageCount'] = this.pageCount;
    data['printType'] = this.printType;
    data['categories'] = this.categories;
    data['maturityRating'] = this.maturityRating;
    data['allowAnonLogging'] = this.allowAnonLogging;
    data['contentVersion'] = this.contentVersion;
    if (this.panelizationSummary != null) {
      data['panelizationSummary'] = this.panelizationSummary!.toJson();
    }
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.toJson();
    }
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['infoLink'] = this.infoLink;
    data['canonicalVolumeLink'] = this.canonicalVolumeLink;
    return data;
  }
}

class ReadingModes {
  bool? text;
  bool? image;

  ReadingModes({this.text, this.image});

  ReadingModes.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['image'] = this.image;
    return data;
  }
}

class PanelizationSummary {
  bool? containsEpubBubbles;
  bool? containsImageBubbles;

  PanelizationSummary({this.containsEpubBubbles, this.containsImageBubbles});

  PanelizationSummary.fromJson(Map<String, dynamic> json) {
    containsEpubBubbles = json['containsEpubBubbles'];
    containsImageBubbles = json['containsImageBubbles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['containsEpubBubbles'] = this.containsEpubBubbles;
    data['containsImageBubbles'] = this.containsImageBubbles;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
