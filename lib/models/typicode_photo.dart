import 'package:json_annotation/json_annotation.dart';


part 'typicode_photo.g.dart';

@JsonSerializable()
class TypiCodePhoto {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  TypiCodePhoto({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl
  });



   factory TypiCodePhoto.fromJson(Map<String, dynamic> json) => _$TypiCodePhotoFromJson(json);
  Map<String, dynamic> toJson() => _$TypiCodePhotoToJson(this);
}
