// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinboard_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinboardPin _$PinboardPinFromJson(Map<String, dynamic> json) => PinboardPin(
      href: json['href'] as String,
      description: json['description'] as String,
      extended: json['extended'] as String,
      meta: json['meta'] as String,
      hash: json['hash'] as String,
      time: json['time'] as String,
      shared: json['shared'] as String,
      toread: json['toread'] as String,
      tags: json['tags'] as String,
    );

Map<String, dynamic> _$PinboardPinToJson(PinboardPin instance) =>
    <String, dynamic>{
      'href': instance.href,
      'time': instance.time,
      'meta': instance.meta,
      'description': instance.description,
      'extended': instance.extended,
      'tags': instance.tags,
      'shared': instance.shared,
      'toread': instance.toread,
      'hash': instance.hash,
    };
