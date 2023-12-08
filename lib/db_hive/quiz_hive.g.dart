// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHiveAdapter extends TypeAdapter<QuizHive> {
  @override
  final int typeId = 0;

  @override
  QuizHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHive(
      key: fields[0] as String,
      title: fields[1] as String,
      grade: fields[2] as int,
      questions: (fields[3] as List).cast<Question>(),
      lastRevised: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.questions)
      ..writeByte(4)
      ..write(obj.lastRevised);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizHive _$QuizHiveFromJson(Map<String, dynamic> json) => QuizHive(
      key: json['key'] as String,
      title: json['title'] as String,
      grade: json['grade'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastRevised: QuizHive._dateFromString(json['lastRevised'] as String),
    );

Map<String, dynamic> _$QuizHiveToJson(QuizHive instance) => <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'grade': instance.grade,
      'questions': instance.questions,
      'lastRevised': instance.lastRevised.toIso8601String(),
    };
