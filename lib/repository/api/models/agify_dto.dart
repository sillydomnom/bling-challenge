
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agify_dto.g.dart';

@JsonSerializable(
  createToJson: false,
)
class AgifyDTO extends Equatable{
  final String name;
  final int age;
  final int count;

  const AgifyDTO({
    required this.name,
    required this.age,
    required this.count,
  });

  factory AgifyDTO.fromJson(Map<String, dynamic> json) => _$AgifyDTOFromJson(json);

  @override
  List<Object?> get props => [
    name,
    age,
    count,
  ];
}
