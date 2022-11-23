// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinboard_pin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PinboardPinAdapter extends TypeAdapter<PinboardPin> {
  @override
  final int typeId = 6;

  @override
  PinboardPin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PinboardPin(
      href: fields[0] as String,
      description: fields[3] as String,
      extended: fields[4] as String,
      meta: fields[2] as String,
      hash: fields[8] as String,
      time: fields[1] as String,
      shared: fields[6] as String,
      toread: fields[7] as String,
      tags: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PinboardPin obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.href)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.meta)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.extended)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.shared)
      ..writeByte(7)
      ..write(obj.toread)
      ..writeByte(8)
      ..write(obj.hash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinboardPinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetPinboardPinCollection on Isar {
  IsarCollection<PinboardPin> get pinboardPins => this.collection();
}

const PinboardPinSchema = CollectionSchema(
  name: r'PinboardPin',
  id: 267200604924456810,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'extended': PropertySchema(
      id: 1,
      name: r'extended',
      type: IsarType.string,
    ),
    r'hash': PropertySchema(
      id: 2,
      name: r'hash',
      type: IsarType.string,
    ),
    r'href': PropertySchema(
      id: 3,
      name: r'href',
      type: IsarType.string,
    ),
    r'meta': PropertySchema(
      id: 4,
      name: r'meta',
      type: IsarType.string,
    ),
    r'shared': PropertySchema(
      id: 5,
      name: r'shared',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 6,
      name: r'tags',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 7,
      name: r'time',
      type: IsarType.string,
    ),
    r'toread': PropertySchema(
      id: 8,
      name: r'toread',
      type: IsarType.string,
    )
  },
  estimateSize: _pinboardPinEstimateSize,
  serialize: _pinboardPinSerialize,
  deserialize: _pinboardPinDeserialize,
  deserializeProp: _pinboardPinDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pinboardPinGetId,
  getLinks: _pinboardPinGetLinks,
  attach: _pinboardPinAttach,
  version: '3.0.5',
);

int _pinboardPinEstimateSize(
  PinboardPin object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.extended.length * 3;
  bytesCount += 3 + object.hash.length * 3;
  bytesCount += 3 + object.href.length * 3;
  bytesCount += 3 + object.meta.length * 3;
  bytesCount += 3 + object.shared.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  bytesCount += 3 + object.time.length * 3;
  bytesCount += 3 + object.toread.length * 3;
  return bytesCount;
}

void _pinboardPinSerialize(
  PinboardPin object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.extended);
  writer.writeString(offsets[2], object.hash);
  writer.writeString(offsets[3], object.href);
  writer.writeString(offsets[4], object.meta);
  writer.writeString(offsets[5], object.shared);
  writer.writeString(offsets[6], object.tags);
  writer.writeString(offsets[7], object.time);
  writer.writeString(offsets[8], object.toread);
}

PinboardPin _pinboardPinDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PinboardPin(
    description: reader.readString(offsets[0]),
    extended: reader.readString(offsets[1]),
    hash: reader.readString(offsets[2]),
    href: reader.readString(offsets[3]),
    meta: reader.readString(offsets[4]),
    shared: reader.readString(offsets[5]),
    tags: reader.readString(offsets[6]),
    time: reader.readString(offsets[7]),
    toread: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _pinboardPinDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pinboardPinGetId(PinboardPin object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pinboardPinGetLinks(PinboardPin object) {
  return [];
}

void _pinboardPinAttach(
    IsarCollection<dynamic> col, Id id, PinboardPin object) {
  object.id = id;
}

extension PinboardPinQueryWhereSort
    on QueryBuilder<PinboardPin, PinboardPin, QWhere> {
  QueryBuilder<PinboardPin, PinboardPin, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PinboardPinQueryWhere
    on QueryBuilder<PinboardPin, PinboardPin, QWhereClause> {
  QueryBuilder<PinboardPin, PinboardPin, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PinboardPinQueryFilter
    on QueryBuilder<PinboardPin, PinboardPin, QFilterCondition> {
  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> extendedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> extendedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extended',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extended',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> extendedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extended',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extended',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      extendedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extended',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'href',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'href',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'href',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> hrefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'href',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      hrefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'href',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> metaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meta',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      metaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meta',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      sharedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shared',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      sharedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shared',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> sharedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shared',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      sharedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shared',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      sharedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shared',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'time',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> timeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      timeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      toreadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toread',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      toreadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toread',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition> toreadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toread',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      toreadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toread',
        value: '',
      ));
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterFilterCondition>
      toreadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toread',
        value: '',
      ));
    });
  }
}

extension PinboardPinQueryObject
    on QueryBuilder<PinboardPin, PinboardPin, QFilterCondition> {}

extension PinboardPinQueryLinks
    on QueryBuilder<PinboardPin, PinboardPin, QFilterCondition> {}

extension PinboardPinQuerySortBy
    on QueryBuilder<PinboardPin, PinboardPin, QSortBy> {
  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByExtended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extended', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByExtendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extended', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByHref() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'href', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByHrefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'href', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByShared() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shared', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortBySharedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shared', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByTagsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByToread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toread', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> sortByToreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toread', Sort.desc);
    });
  }
}

extension PinboardPinQuerySortThenBy
    on QueryBuilder<PinboardPin, PinboardPin, QSortThenBy> {
  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByExtended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extended', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByExtendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extended', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByHref() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'href', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByHrefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'href', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByShared() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shared', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenBySharedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shared', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByTagsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByToread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toread', Sort.asc);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QAfterSortBy> thenByToreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toread', Sort.desc);
    });
  }
}

extension PinboardPinQueryWhereDistinct
    on QueryBuilder<PinboardPin, PinboardPin, QDistinct> {
  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByExtended(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extended', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByHref(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'href', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByMeta(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meta', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByShared(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shared', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByTags(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinboardPin, PinboardPin, QDistinct> distinctByToread(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toread', caseSensitive: caseSensitive);
    });
  }
}

extension PinboardPinQueryProperty
    on QueryBuilder<PinboardPin, PinboardPin, QQueryProperty> {
  QueryBuilder<PinboardPin, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> extendedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extended');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hash');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> hrefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'href');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> metaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meta');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> sharedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shared');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<PinboardPin, String, QQueryOperations> toreadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toread');
    });
  }
}
