// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedAccountCollection on Isar {
  IsarCollection<CachedAccount> get cachedAccounts => this.collection();
}

const CachedAccountSchema = CollectionSchema(
  name: r'CachedAccount',
  id: -795090644293319567,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'cacheKey': PropertySchema(
      id: 1,
      name: r'cacheKey',
      type: IsarType.string,
    ),
    r'cachedAt': PropertySchema(
      id: 2,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'payloadJson': PropertySchema(
      id: 3,
      name: r'payloadJson',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(id: 4, name: r'userId', type: IsarType.string),
  },

  estimateSize: _cachedAccountEstimateSize,
  serialize: _cachedAccountSerialize,
  deserialize: _cachedAccountDeserialize,
  deserializeProp: _cachedAccountDeserializeProp,
  idName: r'id',
  indexes: {
    r'accountId': IndexSchema(
      id: -1591555361937770434,
      name: r'accountId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'cacheKey': IndexSchema(
      id: 5885332021012296610,
      name: r'cacheKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'cacheKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedAccountGetId,
  getLinks: _cachedAccountGetLinks,
  attach: _cachedAccountAttach,
  version: '3.3.2',
);

int _cachedAccountEstimateSize(
  CachedAccount object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accountId.length * 3;
  bytesCount += 3 + object.cacheKey.length * 3;
  bytesCount += 3 + object.payloadJson.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedAccountSerialize(
  CachedAccount object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.cacheKey);
  writer.writeDateTime(offsets[2], object.cachedAt);
  writer.writeString(offsets[3], object.payloadJson);
  writer.writeString(offsets[4], object.userId);
}

CachedAccount _cachedAccountDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedAccount();
  object.accountId = reader.readString(offsets[0]);
  object.cacheKey = reader.readString(offsets[1]);
  object.cachedAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.payloadJson = reader.readString(offsets[3]);
  object.userId = reader.readString(offsets[4]);
  return object;
}

P _cachedAccountDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedAccountGetId(CachedAccount object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedAccountGetLinks(CachedAccount object) {
  return [];
}

void _cachedAccountAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedAccount object,
) {
  object.id = id;
}

extension CachedAccountByIndex on IsarCollection<CachedAccount> {
  Future<CachedAccount?> getByAccountId(String accountId) {
    return getByIndex(r'accountId', [accountId]);
  }

  CachedAccount? getByAccountIdSync(String accountId) {
    return getByIndexSync(r'accountId', [accountId]);
  }

  Future<bool> deleteByAccountId(String accountId) {
    return deleteByIndex(r'accountId', [accountId]);
  }

  bool deleteByAccountIdSync(String accountId) {
    return deleteByIndexSync(r'accountId', [accountId]);
  }

  Future<List<CachedAccount?>> getAllByAccountId(List<String> accountIdValues) {
    final values = accountIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'accountId', values);
  }

  List<CachedAccount?> getAllByAccountIdSync(List<String> accountIdValues) {
    final values = accountIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'accountId', values);
  }

  Future<int> deleteAllByAccountId(List<String> accountIdValues) {
    final values = accountIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'accountId', values);
  }

  int deleteAllByAccountIdSync(List<String> accountIdValues) {
    final values = accountIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'accountId', values);
  }

  Future<Id> putByAccountId(CachedAccount object) {
    return putByIndex(r'accountId', object);
  }

  Id putByAccountIdSync(CachedAccount object, {bool saveLinks = true}) {
    return putByIndexSync(r'accountId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAccountId(List<CachedAccount> objects) {
    return putAllByIndex(r'accountId', objects);
  }

  List<Id> putAllByAccountIdSync(
    List<CachedAccount> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'accountId', objects, saveLinks: saveLinks);
  }
}

extension CachedAccountQueryWhereSort
    on QueryBuilder<CachedAccount, CachedAccount, QWhere> {
  QueryBuilder<CachedAccount, CachedAccount, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedAccountQueryWhere
    on QueryBuilder<CachedAccount, CachedAccount, QWhereClause> {
  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause>
  accountIdEqualTo(String accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'accountId', value: [accountId]),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause>
  accountIdNotEqualTo(String accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'accountId',
                lower: [],
                upper: [accountId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'accountId',
                lower: [accountId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'accountId',
                lower: [accountId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'accountId',
                lower: [],
                upper: [accountId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> userIdEqualTo(
    String userId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause>
  userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause> cacheKeyEqualTo(
    String cacheKey,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'cacheKey', value: [cacheKey]),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterWhereClause>
  cacheKeyNotEqualTo(String cacheKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cacheKey',
                lower: [],
                upper: [cacheKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cacheKey',
                lower: [cacheKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cacheKey',
                lower: [cacheKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'cacheKey',
                lower: [],
                upper: [cacheKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedAccountQueryFilter
    on QueryBuilder<CachedAccount, CachedAccount, QFilterCondition> {
  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accountId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'accountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'accountId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'accountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cacheKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cacheKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cacheKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cacheKey', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cacheKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cacheKey', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'payloadJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'payloadJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'payloadJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'payloadJson', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  payloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'payloadJson', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterFilterCondition>
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension CachedAccountQueryObject
    on QueryBuilder<CachedAccount, CachedAccount, QFilterCondition> {}

extension CachedAccountQueryLinks
    on QueryBuilder<CachedAccount, CachedAccount, QFilterCondition> {}

extension CachedAccountQuerySortBy
    on QueryBuilder<CachedAccount, CachedAccount, QSortBy> {
  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByCacheKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  sortByCacheKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  sortByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedAccountQuerySortThenBy
    on QueryBuilder<CachedAccount, CachedAccount, QSortThenBy> {
  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByCacheKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  thenByCacheKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy>
  thenByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedAccountQueryWhereDistinct
    on QueryBuilder<CachedAccount, CachedAccount, QDistinct> {
  QueryBuilder<CachedAccount, CachedAccount, QDistinct> distinctByAccountId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QDistinct> distinctByCacheKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QDistinct> distinctByPayloadJson({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payloadJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedAccount, CachedAccount, QDistinct> distinctByUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedAccountQueryProperty
    on QueryBuilder<CachedAccount, CachedAccount, QQueryProperty> {
  QueryBuilder<CachedAccount, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedAccount, String, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<CachedAccount, String, QQueryOperations> cacheKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheKey');
    });
  }

  QueryBuilder<CachedAccount, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedAccount, String, QQueryOperations> payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payloadJson');
    });
  }

  QueryBuilder<CachedAccount, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
