class ImageLinks{
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail,this.thumbnail});

  factory ImageLinks.fromJson(Map<String,dynamic>json){
    var imageLinks = ImageLinks();
    imageLinks.smallThumbnail = json['smallThumbnail'];
    imageLinks.thumbnail = json['thumbnail'];
    return imageLinks;
  }


}
// class ImageLinks {
//   String? smallThumbnail;
//   String? thumbnail;
//
//   ImageLinks({this.smallThumbnail, this.thumbnail});
//
//   factory ImageLinks.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return ImageLinks();
//     return ImageLinks(
//       smallThumbnail: json['smallThumbnail'],
//       thumbnail: json['thumbnail'],
//     );
//   }
// }
