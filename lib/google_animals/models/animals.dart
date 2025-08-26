// import 'package:rest_api/google_animals/models/volumeInfo.dart';
// import 'Image_links.dart';
//
// class Animals {
//   String? selfLink;
//   VolumeInfo? volumeInfo;
//   Animals({
//     this.selfLink,
//     this.volumeInfo,
//   });
//
//   factory Animals.fromJson(Map<String,dynamic>json){
//     Animals animals = Animals();
//     animals.selfLink = json['selfLink'];
//     animals.volumeInfo = VolumeInfo.fromJson(json['volumeInfo']);
//
//     return animals;
//   }
// }
// // class Animals {
// //   String? selfLink;
// //   VolumeInfo? volumeInfo;
// //
// //   Animals({this.selfLink, this.volumeInfo});
// //
// //   factory Animals.fromJson(Map<String, dynamic> json) {
// //     return Animals(
// //       selfLink: json['selfLink'],
// //       volumeInfo: json['volumeInfo'] != null
// //           ? VolumeInfo.fromJson(json['volumeInfo'])
// //           : null,
// //     );
// //   }
// // }