import 'package:json_annotation/json_annotation.dart';
part 'movie_model.g.dart';

@JsonSerializable(
  createToJson: false,
  createFactory: true,
)
class MovieModel {
  bool? adult;
  int? id;
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;
  @JsonKey(name: 'vote_average')
  double? voteAverage;

  MovieModel({
    this.adult,
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) =>
      _$MovieModelFromJson(map);
}
