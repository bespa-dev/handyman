// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Artisan extends DataClass implements Insertable<Artisan> {
  final String id;
  final String name;
  final String business;
  final String email;
  final String avatar;
  final double price;
  Artisan(
      {@required this.id,
      @required this.name,
      this.business,
      @required this.email,
      this.avatar,
      @required this.price});
  factory Artisan.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Artisan(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      business: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || business != null) {
      map['business'] = Variable<String>(business);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    return map;
  }

  ServiceProviderCompanion toCompanion(bool nullToAbsent) {
    return ServiceProviderCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      business: business == null && nullToAbsent
          ? const Value.absent()
          : Value(business),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory Artisan.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artisan(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      business: serializer.fromJson<String>(json['business']),
      email: serializer.fromJson<String>(json['email']),
      avatar: serializer.fromJson<String>(json['avatar']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'business': serializer.toJson<String>(business),
      'email': serializer.toJson<String>(email),
      'avatar': serializer.toJson<String>(avatar),
      'price': serializer.toJson<double>(price),
    };
  }

  Artisan copyWith(
          {String id,
          String name,
          String business,
          String email,
          String avatar,
          double price}) =>
      Artisan(
        id: id ?? this.id,
        name: name ?? this.name,
        business: business ?? this.business,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Artisan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('business: $business, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(business.hashCode,
              $mrjc(email.hashCode, $mrjc(avatar.hashCode, price.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Artisan &&
          other.id == this.id &&
          other.name == this.name &&
          other.business == this.business &&
          other.email == this.email &&
          other.avatar == this.avatar &&
          other.price == this.price);
}

class ServiceProviderCompanion extends UpdateCompanion<Artisan> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> business;
  final Value<String> email;
  final Value<String> avatar;
  final Value<double> price;
  const ServiceProviderCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.business = const Value.absent(),
    this.email = const Value.absent(),
    this.avatar = const Value.absent(),
    this.price = const Value.absent(),
  });
  ServiceProviderCompanion.insert({
    @required String id,
    @required String name,
    this.business = const Value.absent(),
    @required String email,
    this.avatar = const Value.absent(),
    this.price = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email);
  static Insertable<Artisan> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> business,
    Expression<String> email,
    Expression<String> avatar,
    Expression<double> price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (business != null) 'business': business,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (price != null) 'price': price,
    });
  }

  ServiceProviderCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> business,
      Value<String> email,
      Value<String> avatar,
      Value<double> price}) {
    return ServiceProviderCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      business: business ?? this.business,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (business.present) {
      map['business'] = Variable<String>(business.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceProviderCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('business: $business, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $ServiceProviderTable extends ServiceProvider
    with TableInfo<$ServiceProviderTable, Artisan> {
  final GeneratedDatabase _db;
  final String _alias;
  $ServiceProviderTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessMeta = const VerificationMeta('business');
  GeneratedTextColumn _business;
  @override
  GeneratedTextColumn get business => _business ??= _constructBusiness();
  GeneratedTextColumn _constructBusiness() {
    return GeneratedTextColumn(
      'business',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  GeneratedTextColumn _avatar;
  @override
  GeneratedTextColumn get avatar => _avatar ??= _constructAvatar();
  GeneratedTextColumn _constructAvatar() {
    return GeneratedTextColumn(
      'avatar',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn('price', $tableName, false,
        defaultValue: Constant(20.99));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, business, email, avatar, price];
  @override
  $ServiceProviderTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'service_provider';
  @override
  final String actualTableName = 'service_provider';
  @override
  VerificationContext validateIntegrity(Insertable<Artisan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('business')) {
      context.handle(_businessMeta,
          business.isAcceptableOrUnknown(data['business'], _businessMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar'], _avatarMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artisan map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Artisan.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ServiceProviderTable createAlias(String alias) {
    return $ServiceProviderTable(_db, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String name;
  final String email;
  final String avatar;
  Customer({@required this.id, this.name, this.email, this.avatar});
  factory Customer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Customer(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      avatar: serializer.fromJson<String>(json['avatar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'avatar': serializer.toJson<String>(avatar),
    };
  }

  Customer copyWith({String id, String name, String email, String avatar}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(email.hashCode, avatar.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.avatar == this.avatar);
}

class UserCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> avatar;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatar = const Value.absent(),
  });
  UserCompanion.insert({
    @required String id,
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatar = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Customer> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> email,
    Expression<String> avatar,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
    });
  }

  UserCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> email,
      Value<String> avatar}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, Customer> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  GeneratedTextColumn _avatar;
  @override
  GeneratedTextColumn get avatar => _avatar ??= _constructAvatar();
  GeneratedTextColumn _constructAvatar() {
    return GeneratedTextColumn(
      'avatar',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, email, avatar];
  @override
  $UserTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user';
  @override
  final String actualTableName = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar'], _avatarMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Customer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(_db, alias);
  }
}

class Booking extends DataClass implements Insertable<Booking> {
  final int id;
  final String customerId;
  final String providerId;
  final DateTime createdAt;
  Booking(
      {@required this.id,
      @required this.customerId,
      @required this.providerId,
      @required this.createdAt});
  factory Booking.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Booking(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      customerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      providerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}provider_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    if (!nullToAbsent || providerId != null) {
      map['provider_id'] = Variable<String>(providerId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  BookingsCompanion toCompanion(bool nullToAbsent) {
    return BookingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Booking(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<String>(customerId),
      'providerId': serializer.toJson<String>(providerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Booking copyWith(
          {int id, String customerId, String providerId, DateTime createdAt}) =>
      Booking(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        providerId: providerId ?? this.providerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Booking(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(customerId.hashCode,
          $mrjc(providerId.hashCode, createdAt.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Booking &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.providerId == this.providerId &&
          other.createdAt == this.createdAt);
}

class BookingsCompanion extends UpdateCompanion<Booking> {
  final Value<int> id;
  final Value<String> customerId;
  final Value<String> providerId;
  final Value<DateTime> createdAt;
  const BookingsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookingsCompanion.insert({
    this.id = const Value.absent(),
    @required String customerId,
    @required String providerId,
    this.createdAt = const Value.absent(),
  })  : customerId = Value(customerId),
        providerId = Value(providerId);
  static Insertable<Booking> custom({
    Expression<int> id,
    Expression<String> customerId,
    Expression<String> providerId,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (providerId != null) 'provider_id': providerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookingsCompanion copyWith(
      {Value<int> id,
      Value<String> customerId,
      Value<String> providerId,
      Value<DateTime> createdAt}) {
    return BookingsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BookingsTable extends Bookings with TableInfo<$BookingsTable, Booking> {
  final GeneratedDatabase _db;
  final String _alias;
  $BookingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  GeneratedTextColumn _customerId;
  @override
  GeneratedTextColumn get customerId => _customerId ??= _constructCustomerId();
  GeneratedTextColumn _constructCustomerId() {
    return GeneratedTextColumn(
      'customer_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _providerIdMeta = const VerificationMeta('providerId');
  GeneratedTextColumn _providerId;
  @override
  GeneratedTextColumn get providerId => _providerId ??= _constructProviderId();
  GeneratedTextColumn _constructProviderId() {
    return GeneratedTextColumn(
      'provider_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn('created_at', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  @override
  List<GeneratedColumn> get $columns => [id, customerId, providerId, createdAt];
  @override
  $BookingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'bookings';
  @override
  final String actualTableName = 'bookings';
  @override
  VerificationContext validateIntegrity(Insertable<Booking> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id'], _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id'], _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Booking map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Booking.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BookingsTable createAlias(String alias) {
    return $BookingsTable(_db, alias);
  }
}

class CustomerReview extends DataClass implements Insertable<CustomerReview> {
  final int id;
  final String review;
  final String customerId;
  final String providerId;
  final DateTime createdAt;
  CustomerReview(
      {@required this.id,
      @required this.review,
      @required this.customerId,
      @required this.providerId,
      @required this.createdAt});
  factory CustomerReview.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CustomerReview(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      review:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}review']),
      customerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      providerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}provider_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || review != null) {
      map['review'] = Variable<String>(review);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    if (!nullToAbsent || providerId != null) {
      map['provider_id'] = Variable<String>(providerId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ReviewCompanion toCompanion(bool nullToAbsent) {
    return ReviewCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      review:
          review == null && nullToAbsent ? const Value.absent() : Value(review),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory CustomerReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CustomerReview(
      id: serializer.fromJson<int>(json['id']),
      review: serializer.fromJson<String>(json['review']),
      customerId: serializer.fromJson<String>(json['customerId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'review': serializer.toJson<String>(review),
      'customerId': serializer.toJson<String>(customerId),
      'providerId': serializer.toJson<String>(providerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerReview copyWith(
          {int id,
          String review,
          String customerId,
          String providerId,
          DateTime createdAt}) =>
      CustomerReview(
        id: id ?? this.id,
        review: review ?? this.review,
        customerId: customerId ?? this.customerId,
        providerId: providerId ?? this.providerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CustomerReview(')
          ..write('id: $id, ')
          ..write('review: $review, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          review.hashCode,
          $mrjc(customerId.hashCode,
              $mrjc(providerId.hashCode, createdAt.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CustomerReview &&
          other.id == this.id &&
          other.review == this.review &&
          other.customerId == this.customerId &&
          other.providerId == this.providerId &&
          other.createdAt == this.createdAt);
}

class ReviewCompanion extends UpdateCompanion<CustomerReview> {
  final Value<int> id;
  final Value<String> review;
  final Value<String> customerId;
  final Value<String> providerId;
  final Value<DateTime> createdAt;
  const ReviewCompanion({
    this.id = const Value.absent(),
    this.review = const Value.absent(),
    this.customerId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReviewCompanion.insert({
    this.id = const Value.absent(),
    @required String review,
    @required String customerId,
    @required String providerId,
    this.createdAt = const Value.absent(),
  })  : review = Value(review),
        customerId = Value(customerId),
        providerId = Value(providerId);
  static Insertable<CustomerReview> custom({
    Expression<int> id,
    Expression<String> review,
    Expression<String> customerId,
    Expression<String> providerId,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (review != null) 'review': review,
      if (customerId != null) 'customer_id': customerId,
      if (providerId != null) 'provider_id': providerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReviewCompanion copyWith(
      {Value<int> id,
      Value<String> review,
      Value<String> customerId,
      Value<String> providerId,
      Value<DateTime> createdAt}) {
    return ReviewCompanion(
      id: id ?? this.id,
      review: review ?? this.review,
      customerId: customerId ?? this.customerId,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (review.present) {
      map['review'] = Variable<String>(review.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewCompanion(')
          ..write('id: $id, ')
          ..write('review: $review, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewTable extends Review with TableInfo<$ReviewTable, CustomerReview> {
  final GeneratedDatabase _db;
  final String _alias;
  $ReviewTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _reviewMeta = const VerificationMeta('review');
  GeneratedTextColumn _review;
  @override
  GeneratedTextColumn get review => _review ??= _constructReview();
  GeneratedTextColumn _constructReview() {
    return GeneratedTextColumn(
      'review',
      $tableName,
      false,
    );
  }

  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  GeneratedTextColumn _customerId;
  @override
  GeneratedTextColumn get customerId => _customerId ??= _constructCustomerId();
  GeneratedTextColumn _constructCustomerId() {
    return GeneratedTextColumn(
      'customer_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _providerIdMeta = const VerificationMeta('providerId');
  GeneratedTextColumn _providerId;
  @override
  GeneratedTextColumn get providerId => _providerId ??= _constructProviderId();
  GeneratedTextColumn _constructProviderId() {
    return GeneratedTextColumn(
      'provider_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn('created_at', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, review, customerId, providerId, createdAt];
  @override
  $ReviewTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'review';
  @override
  final String actualTableName = 'review';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('review')) {
      context.handle(_reviewMeta,
          review.isAcceptableOrUnknown(data['review'], _reviewMeta));
    } else if (isInserting) {
      context.missing(_reviewMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id'], _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id'], _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerReview map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CustomerReview.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ReviewTable createAlias(String alias) {
    return $ReviewTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ServiceProviderTable _serviceProvider;
  $ServiceProviderTable get serviceProvider =>
      _serviceProvider ??= $ServiceProviderTable(this);
  $UserTable _user;
  $UserTable get user => _user ??= $UserTable(this);
  $BookingsTable _bookings;
  $BookingsTable get bookings => _bookings ??= $BookingsTable(this);
  $ReviewTable _review;
  $ReviewTable get review => _review ??= $ReviewTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [serviceProvider, user, bookings, review];
}
