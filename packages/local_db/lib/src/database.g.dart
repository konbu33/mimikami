// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _uriStringMeta =
      const VerificationMeta('uriString');
  @override
  late final GeneratedColumn<String> uriString = GeneratedColumn<String>(
      'uri_string', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentsMeta =
      const VerificationMeta('contents');
  @override
  late final GeneratedColumn<String> contents = GeneratedColumn<String>(
      'contents', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, uriString, title, contents];
  @override
  String get aliasedName => _alias ?? 'articles';
  @override
  String get actualTableName => 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uri_string')) {
      context.handle(_uriStringMeta,
          uriString.isAcceptableOrUnknown(data['uri_string']!, _uriStringMeta));
    } else if (isInserting) {
      context.missing(_uriStringMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('contents')) {
      context.handle(_contentsMeta,
          contents.isAcceptableOrUnknown(data['contents']!, _contentsMeta));
    } else if (isInserting) {
      context.missing(_contentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uriString: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uri_string'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contents: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contents'])!,
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final String id;
  final String uriString;
  final String title;
  final String contents;
  const Article(
      {required this.id,
      required this.uriString,
      required this.title,
      required this.contents});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uri_string'] = Variable<String>(uriString);
    map['title'] = Variable<String>(title);
    map['contents'] = Variable<String>(contents);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      uriString: Value(uriString),
      title: Value(title),
      contents: Value(contents),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<String>(json['id']),
      uriString: serializer.fromJson<String>(json['uriString']),
      title: serializer.fromJson<String>(json['title']),
      contents: serializer.fromJson<String>(json['contents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uriString': serializer.toJson<String>(uriString),
      'title': serializer.toJson<String>(title),
      'contents': serializer.toJson<String>(contents),
    };
  }

  Article copyWith(
          {String? id, String? uriString, String? title, String? contents}) =>
      Article(
        id: id ?? this.id,
        uriString: uriString ?? this.uriString,
        title: title ?? this.title,
        contents: contents ?? this.contents,
      );
  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('uriString: $uriString, ')
          ..write('title: $title, ')
          ..write('contents: $contents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uriString, title, contents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.uriString == this.uriString &&
          other.title == this.title &&
          other.contents == this.contents);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<String> id;
  final Value<String> uriString;
  final Value<String> title;
  final Value<String> contents;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.uriString = const Value.absent(),
    this.title = const Value.absent(),
    this.contents = const Value.absent(),
  });
  ArticlesCompanion.insert({
    required String id,
    required String uriString,
    required String title,
    required String contents,
  })  : id = Value(id),
        uriString = Value(uriString),
        title = Value(title),
        contents = Value(contents);
  static Insertable<Article> custom({
    Expression<String>? id,
    Expression<String>? uriString,
    Expression<String>? title,
    Expression<String>? contents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uriString != null) 'uri_string': uriString,
      if (title != null) 'title': title,
      if (contents != null) 'contents': contents,
    });
  }

  ArticlesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uriString,
      Value<String>? title,
      Value<String>? contents}) {
    return ArticlesCompanion(
      id: id ?? this.id,
      uriString: uriString ?? this.uriString,
      title: title ?? this.title,
      contents: contents ?? this.contents,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uriString.present) {
      map['uri_string'] = Variable<String>(uriString.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contents.present) {
      map['contents'] = Variable<String>(contents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('uriString: $uriString, ')
          ..write('title: $title, ')
          ..write('contents: $contents')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(e);
  late final $ArticlesTable articles = $ArticlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articles];
}
