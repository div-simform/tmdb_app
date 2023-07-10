import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  createToJson: false,
  createFactory: true,
)
class APIResponse<T> {
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "results")
  T? data;
  @JsonKey(name: "total_results")
  int? totalResults;
  int? page;

  APIResponse({
    this.totalPages,
    this.data,
    this.page,
    this.totalResults,
  });

  factory APIResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? fromJsonT) fromJsonT) =>
      _$APIResponseFromJson(json, fromJsonT);
}
