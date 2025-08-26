// import 'Image_links.dart';
//
// class VolumeInfo {
//   String? title;
//   List<String>? authors;
//   List<String>? categories;
//   ImageLinks? imageLinks;
//   String? publisher;
//   String? publishedDate;
//   String? description;
//
//   VolumeInfo({
//     this.title,
//     this.authors,
//     this.categories,
//     this.imageLinks,
//     this.publisher,
//     this.publishedDate,
//     this.description,
//   });
//
//   factory VolumeInfo.fromJson(Map<String, dynamic> json) {
//     VolumeInfo volumeInfo = VolumeInfo();
//
//     volumeInfo.title = json['title'];
//
//     // volumeInfo.categories = json['categories'] != null
//     //     ? List<String>.from(json['categories'])
//     //     : null;
//     // print(volumeInfo.categories);
//
//     volumeInfo.categories = [];
//     if(json['categories'] != null){
//       for( var items in json['categories'] ){
//         volumeInfo.categories?.add(items);
//       }
//     }
//     volumeInfo.authors = json['authors'] !=null ? List.from(json['authors']):null;
//
//
//     volumeInfo.imageLinks = ImageLinks.fromJson(json['imageLinks']);
//     volumeInfo.publisher = json['publisher'];
//     volumeInfo.publishedDate = json['publishedDate'];
//     volumeInfo.description = json['description'];
//
//     return volumeInfo;
//   }
// }
//
// // class VolumeInfo {
// //   String? title;
// //   List<String>? authors;
// //   List<String>? categories;
// //   ImageLinks? imageLinks;
// //   String? publisher;
// //   String? publishedDate;
// //   String? description;
// //
// //   VolumeInfo({
// //     this.title,
// //     this.authors,
// //     this.categories,
// //     this.imageLinks,
// //     this.publisher,
// //     this.publishedDate,
// //     this.description,
// //   });
// //
// //   factory VolumeInfo.fromJson(Map<String, dynamic> json) {
// //     return VolumeInfo(
// //       title: json['title'],
// //       authors: json['authors'] != null
// //           ? List<String>.from(json['authors'])
// //           : null,
// //       categories: json['categories'] != null
// //           ? List<String>.from(json['categories'])
// //           : null,
// //       imageLinks: json['imageLinks'] != null
// //           ? ImageLinks.fromJson(json['imageLinks'])
// //           : null,
// //       publisher: json['publisher'],
// //       publishedDate: json['publishedDate'],
// //       description: json['description'],
// //     );
// //   }
// // }
//
