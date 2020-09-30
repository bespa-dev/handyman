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
  final String phone;
  final String email;
  final bool isCertified;
  final String category;
  final int startWorkingHours;
  final int endWorkingHours;
  final String avatar;
  final double price;
  final double rating;
  Artisan(
      {@required this.id,
      @required this.name,
      @required this.business,
      this.phone,
      @required this.email,
      @required this.isCertified,
      @required this.category,
      @required this.startWorkingHours,
      @required this.endWorkingHours,
      this.avatar,
      @required this.price,
      @required this.rating});
  factory Artisan.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Artisan(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      business: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      isCertified:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}certified']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      startWorkingHours: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}start_working_hours']),
      endWorkingHours: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_working_hours']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
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
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || isCertified != null) {
      map['certified'] = Variable<bool>(isCertified);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || startWorkingHours != null) {
      map['start_working_hours'] = Variable<int>(startWorkingHours);
    }
    if (!nullToAbsent || endWorkingHours != null) {
      map['end_working_hours'] = Variable<int>(endWorkingHours);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
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
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      isCertified: isCertified == null && nullToAbsent
          ? const Value.absent()
          : Value(isCertified),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      startWorkingHours: startWorkingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(startWorkingHours),
      endWorkingHours: endWorkingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(endWorkingHours),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
    );
  }

  factory Artisan.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artisan(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      business: serializer.fromJson<String>(json['business']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      isCertified: serializer.fromJson<bool>(json['isCertified']),
      category: serializer.fromJson<String>(json['category']),
      startWorkingHours: serializer.fromJson<int>(json['startWorkingHours']),
      endWorkingHours: serializer.fromJson<int>(json['endWorkingHours']),
      avatar: serializer.fromJson<String>(json['avatar']),
      price: serializer.fromJson<double>(json['price']),
      rating: serializer.fromJson<double>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'business': serializer.toJson<String>(business),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'isCertified': serializer.toJson<bool>(isCertified),
      'category': serializer.toJson<String>(category),
      'startWorkingHours': serializer.toJson<int>(startWorkingHours),
      'endWorkingHours': serializer.toJson<int>(endWorkingHours),
      'avatar': serializer.toJson<String>(avatar),
      'price': serializer.toJson<double>(price),
      'rating': serializer.toJson<double>(rating),
    };
  }

  Artisan copyWith(
          {String id,
          String name,
          String business,
          String phone,
          String email,
          bool isCertified,
          String category,
          int startWorkingHours,
          int endWorkingHours,
          String avatar,
          double price,
          double rating}) =>
      Artisan(
        id: id ?? this.id,
        name: name ?? this.name,
        business: business ?? this.business,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        isCertified: isCertified ?? this.isCertified,
        category: category ?? this.category,
        startWorkingHours: startWorkingHours ?? this.startWorkingHours,
        endWorkingHours: endWorkingHours ?? this.endWorkingHours,
        avatar: avatar ?? this.avatar,
        price: price ?? this.price,
        rating: rating ?? this.rating,
      );
  @override
  String toString() {
    return (StringBuffer('Artisan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('business: $business, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('isCertified: $isCertified, ')
          ..write('category: $category, ')
          ..write('startWorkingHours: $startWorkingHours, ')
          ..write('endWorkingHours: $endWorkingHours, ')
          ..write('avatar: $avatar, ')
          ..write('price: $price, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              business.hashCode,
              $mrjc(
                  phone.hashCode,
                  $mrjc(
                      email.hashCode,
                      $mrjc(
                          isCertified.hashCode,
                          $mrjc(
                              category.hashCode,
                              $mrjc(
                                  startWorkingHours.hashCode,
                                  $mrjc(
                                      endWorkingHours.hashCode,
                                      $mrjc(
                                          avatar.hashCode,
                                          $mrjc(price.hashCode,
                                              rating.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Artisan &&
          other.id == this.id &&
          other.name == this.name &&
          other.business == this.business &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.isCertified == this.isCertified &&
          other.category == this.category &&
          other.startWorkingHours == this.startWorkingHours &&
          other.endWorkingHours == this.endWorkingHours &&
          other.avatar == this.avatar &&
          other.price == this.price &&
          other.rating == this.rating);
}

class ServiceProviderCompanion extends UpdateCompanion<Artisan> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> business;
  final Value<String> phone;
  final Value<String> email;
  final Value<bool> isCertified;
  final Value<String> category;
  final Value<int> startWorkingHours;
  final Value<int> endWorkingHours;
  final Value<String> avatar;
  final Value<double> price;
  final Value<double> rating;
  const ServiceProviderCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.business = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.isCertified = const Value.absent(),
    this.category = const Value.absent(),
    this.startWorkingHours = const Value.absent(),
    this.endWorkingHours = const Value.absent(),
    this.avatar = const Value.absent(),
    this.price = const Value.absent(),
    this.rating = const Value.absent(),
  });
  ServiceProviderCompanion.insert({
    @required String id,
    @required String name,
    @required String business,
    this.phone = const Value.absent(),
    @required String email,
    this.isCertified = const Value.absent(),
    this.category = const Value.absent(),
    this.startWorkingHours = const Value.absent(),
    this.endWorkingHours = const Value.absent(),
    this.avatar = const Value.absent(),
    this.price = const Value.absent(),
    this.rating = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        business = Value(business),
        email = Value(email);
  static Insertable<Artisan> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> business,
    Expression<String> phone,
    Expression<String> email,
    Expression<bool> isCertified,
    Expression<String> category,
    Expression<int> startWorkingHours,
    Expression<int> endWorkingHours,
    Expression<String> avatar,
    Expression<double> price,
    Expression<double> rating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (business != null) 'business': business,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (isCertified != null) 'certified': isCertified,
      if (category != null) 'category': category,
      if (startWorkingHours != null) 'start_working_hours': startWorkingHours,
      if (endWorkingHours != null) 'end_working_hours': endWorkingHours,
      if (avatar != null) 'avatar': avatar,
      if (price != null) 'price': price,
      if (rating != null) 'rating': rating,
    });
  }

  ServiceProviderCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> business,
      Value<String> phone,
      Value<String> email,
      Value<bool> isCertified,
      Value<String> category,
      Value<int> startWorkingHours,
      Value<int> endWorkingHours,
      Value<String> avatar,
      Value<double> price,
      Value<double> rating}) {
    return ServiceProviderCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      business: business ?? this.business,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isCertified: isCertified ?? this.isCertified,
      category: category ?? this.category,
      startWorkingHours: startWorkingHours ?? this.startWorkingHours,
      endWorkingHours: endWorkingHours ?? this.endWorkingHours,
      avatar: avatar ?? this.avatar,
      price: price ?? this.price,
      rating: rating ?? this.rating,
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isCertified.present) {
      map['certified'] = Variable<bool>(isCertified.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (startWorkingHours.present) {
      map['start_working_hours'] = Variable<int>(startWorkingHours.value);
    }
    if (endWorkingHours.present) {
      map['end_working_hours'] = Variable<int>(endWorkingHours.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceProviderCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('business: $business, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('isCertified: $isCertified, ')
          ..write('category: $category, ')
          ..write('startWorkingHours: $startWorkingHours, ')
          ..write('endWorkingHours: $endWorkingHours, ')
          ..write('avatar: $avatar, ')
          ..write('price: $price, ')
          ..write('rating: $rating')
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
      false,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
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

  final VerificationMeta _isCertifiedMeta =
      const VerificationMeta('isCertified');
  GeneratedBoolColumn _isCertified;
  @override
  GeneratedBoolColumn get isCertified =>
      _isCertified ??= _constructIsCertified();
  GeneratedBoolColumn _constructIsCertified() {
    return GeneratedBoolColumn('certified', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn('category', $tableName, false,
        defaultValue: Constant("598d67f5-b84b-4572-9058-57f36463aeac"));
  }

  final VerificationMeta _startWorkingHoursMeta =
      const VerificationMeta('startWorkingHours');
  GeneratedIntColumn _startWorkingHours;
  @override
  GeneratedIntColumn get startWorkingHours =>
      _startWorkingHours ??= _constructStartWorkingHours();
  GeneratedIntColumn _constructStartWorkingHours() {
    return GeneratedIntColumn('start_working_hours', $tableName, false,
        defaultValue: Constant(DateTime.now().hour));
  }

  final VerificationMeta _endWorkingHoursMeta =
      const VerificationMeta('endWorkingHours');
  GeneratedIntColumn _endWorkingHours;
  @override
  GeneratedIntColumn get endWorkingHours =>
      _endWorkingHours ??= _constructEndWorkingHours();
  GeneratedIntColumn _constructEndWorkingHours() {
    return GeneratedIntColumn('end_working_hours', $tableName, false,
        defaultValue: Constant(DateTime.now().hour + 12));
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

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedRealColumn _rating;
  @override
  GeneratedRealColumn get rating => _rating ??= _constructRating();
  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn('rating', $tableName, false,
        defaultValue: Constant(3.5));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        business,
        phone,
        email,
        isCertified,
        category,
        startWorkingHours,
        endWorkingHours,
        avatar,
        price,
        rating
      ];
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
    } else if (isInserting) {
      context.missing(_businessMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('certified')) {
      context.handle(
          _isCertifiedMeta,
          isCertified.isAcceptableOrUnknown(
              data['certified'], _isCertifiedMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    if (data.containsKey('start_working_hours')) {
      context.handle(
          _startWorkingHoursMeta,
          startWorkingHours.isAcceptableOrUnknown(
              data['start_working_hours'], _startWorkingHoursMeta));
    }
    if (data.containsKey('end_working_hours')) {
      context.handle(
          _endWorkingHoursMeta,
          endWorkingHours.isAcceptableOrUnknown(
              data['end_working_hours'], _endWorkingHoursMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar'], _avatarMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
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

class ServiceCategory extends DataClass implements Insertable<ServiceCategory> {
  final String id;
  final String name;
  final String avatar;
  final int groupName;
  ServiceCategory(
      {@required this.id,
      @required this.name,
      @required this.avatar,
      @required this.groupName});
  factory ServiceCategory.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return ServiceCategory(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      groupName:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}groupName']),
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
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || groupName != null) {
      map['groupName'] = Variable<int>(groupName);
    }
    return map;
  }

  CategoryItemCompanion toCompanion(bool nullToAbsent) {
    return CategoryItemCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
    );
  }

  factory ServiceCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ServiceCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String>(json['avatar']),
      groupName: serializer.fromJson<int>(json['groupName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String>(avatar),
      'groupName': serializer.toJson<int>(groupName),
    };
  }

  ServiceCategory copyWith(
          {String id, String name, String avatar, int groupName}) =>
      ServiceCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        groupName: groupName ?? this.groupName,
      );
  @override
  String toString() {
    return (StringBuffer('ServiceCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(avatar.hashCode, groupName.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ServiceCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.groupName == this.groupName);
}

class CategoryItemCompanion extends UpdateCompanion<ServiceCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> avatar;
  final Value<int> groupName;
  const CategoryItemCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.groupName = const Value.absent(),
  });
  CategoryItemCompanion.insert({
    @required String id,
    @required String name,
    @required String avatar,
    this.groupName = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        avatar = Value(avatar);
  static Insertable<ServiceCategory> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> avatar,
    Expression<int> groupName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (groupName != null) 'groupName': groupName,
    });
  }

  CategoryItemCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> avatar,
      Value<int> groupName}) {
    return CategoryItemCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      groupName: groupName ?? this.groupName,
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
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (groupName.present) {
      map['groupName'] = Variable<int>(groupName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryItemCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }
}

class $CategoryItemTable extends CategoryItem
    with TableInfo<$CategoryItemTable, ServiceCategory> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoryItemTable(this._db, [this._alias]);
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

  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  GeneratedTextColumn _avatar;
  @override
  GeneratedTextColumn get avatar => _avatar ??= _constructAvatar();
  GeneratedTextColumn _constructAvatar() {
    return GeneratedTextColumn(
      'avatar',
      $tableName,
      false,
    );
  }

  final VerificationMeta _groupNameMeta = const VerificationMeta('groupName');
  GeneratedIntColumn _groupName;
  @override
  GeneratedIntColumn get groupName => _groupName ??= _constructGroupName();
  GeneratedIntColumn _constructGroupName() {
    return GeneratedIntColumn('groupName', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, avatar, groupName];
  @override
  $CategoryItemTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'category_item';
  @override
  final String actualTableName = 'category_item';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceCategory> instance,
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
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar'], _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('groupName')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['groupName'], _groupNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceCategory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ServiceCategory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoryItemTable createAlias(String alias) {
    return $CategoryItemTable(_db, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String id;
  final String author;
  final String recipient;
  final String content;
  final String createdAt;
  final String image;
  Conversation(
      {@required this.id,
      @required this.author,
      @required this.recipient,
      @required this.content,
      @required this.createdAt,
      this.image});
  factory Conversation.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Conversation(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      recipient: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}recipient']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || recipient != null) {
      map['recipient'] = Variable<String>(recipient);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  MessageCompanion toCompanion(bool nullToAbsent) {
    return MessageCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      recipient: recipient == null && nullToAbsent
          ? const Value.absent()
          : Value(recipient),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<String>(json['id']),
      author: serializer.fromJson<String>(json['author']),
      recipient: serializer.fromJson<String>(json['recipient']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'author': serializer.toJson<String>(author),
      'recipient': serializer.toJson<String>(recipient),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<String>(createdAt),
      'image': serializer.toJson<String>(image),
    };
  }

  Conversation copyWith(
          {String id,
          String author,
          String recipient,
          String content,
          String createdAt,
          String image}) =>
      Conversation(
        id: id ?? this.id,
        author: author ?? this.author,
        recipient: recipient ?? this.recipient,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('recipient: $recipient, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          author.hashCode,
          $mrjc(
              recipient.hashCode,
              $mrjc(content.hashCode,
                  $mrjc(createdAt.hashCode, image.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.author == this.author &&
          other.recipient == this.recipient &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.image == this.image);
}

class MessageCompanion extends UpdateCompanion<Conversation> {
  final Value<String> id;
  final Value<String> author;
  final Value<String> recipient;
  final Value<String> content;
  final Value<String> createdAt;
  final Value<String> image;
  const MessageCompanion({
    this.id = const Value.absent(),
    this.author = const Value.absent(),
    this.recipient = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.image = const Value.absent(),
  });
  MessageCompanion.insert({
    @required String id,
    @required String author,
    @required String recipient,
    @required String content,
    @required String createdAt,
    this.image = const Value.absent(),
  })  : id = Value(id),
        author = Value(author),
        recipient = Value(recipient),
        content = Value(content),
        createdAt = Value(createdAt);
  static Insertable<Conversation> custom({
    Expression<String> id,
    Expression<String> author,
    Expression<String> recipient,
    Expression<String> content,
    Expression<String> createdAt,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (author != null) 'author': author,
      if (recipient != null) 'recipient': recipient,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (image != null) 'image': image,
    });
  }

  MessageCompanion copyWith(
      {Value<String> id,
      Value<String> author,
      Value<String> recipient,
      Value<String> content,
      Value<String> createdAt,
      Value<String> image}) {
    return MessageCompanion(
      id: id ?? this.id,
      author: author ?? this.author,
      recipient: recipient ?? this.recipient,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (recipient.present) {
      map['recipient'] = Variable<String>(recipient.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageCompanion(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('recipient: $recipient, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $MessageTable extends Message
    with TableInfo<$MessageTable, Conversation> {
  final GeneratedDatabase _db;
  final String _alias;
  $MessageTable(this._db, [this._alias]);
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

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _recipientMeta = const VerificationMeta('recipient');
  GeneratedTextColumn _recipient;
  @override
  GeneratedTextColumn get recipient => _recipient ??= _constructRecipient();
  GeneratedTextColumn _constructRecipient() {
    return GeneratedTextColumn(
      'recipient',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedTextColumn _createdAt;
  @override
  GeneratedTextColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, author, recipient, content, createdAt, image];
  @override
  $MessageTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'message';
  @override
  final String actualTableName = 'message';
  @override
  VerificationContext validateIntegrity(Insertable<Conversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('recipient')) {
      context.handle(_recipientMeta,
          recipient.isAcceptableOrUnknown(data['recipient'], _recipientMeta));
    } else if (isInserting) {
      context.missing(_recipientMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Conversation.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MessageTable createAlias(String alias) {
    return $MessageTable(_db, alias);
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
  $CategoryItemTable _categoryItem;
  $CategoryItemTable get categoryItem =>
      _categoryItem ??= $CategoryItemTable(this);
  $MessageTable _message;
  $MessageTable get message => _message ??= $MessageTable(this);
  ProviderDao _providerDao;
  ProviderDao get providerDao =>
      _providerDao ??= ProviderDao(this as LocalDatabase);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as LocalDatabase);
  BookingDao _bookingDao;
  BookingDao get bookingDao =>
      _bookingDao ??= BookingDao(this as LocalDatabase);
  ReviewDao _reviewDao;
  ReviewDao get reviewDao => _reviewDao ??= ReviewDao(this as LocalDatabase);
  MessageDao _messageDao;
  MessageDao get messageDao =>
      _messageDao ??= MessageDao(this as LocalDatabase);
  Selectable<Customer> customerById(String var1) {
    return customSelect('SELECT * FROM user WHERE id = ?',
        variables: [Variable.withString(var1)],
        readsFrom: {user}).map(user.mapFromRow);
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [serviceProvider, user, bookings, review, categoryItem, message];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ProviderDaoMixin on DatabaseAccessor<LocalDatabase> {
  $ServiceProviderTable get serviceProvider => attachedDatabase.serviceProvider;
  Selectable<Artisan> artisanById(String var1) {
    return customSelect('SELECT * FROM service_provider WHERE id = ?',
        variables: [Variable.withString(var1)],
        readsFrom: {serviceProvider}).map(serviceProvider.mapFromRow);
  }

  Selectable<Artisan> artisans() {
    return customSelect('SELECT * FROM service_provider ORDER BY id desc',
        variables: [],
        readsFrom: {serviceProvider}).map(serviceProvider.mapFromRow);
  }

  Selectable<Artisan> searchFor(String var1, String var2) {
    return customSelect(
        'SELECT * FROM service_provider WHERE name LIKE ? OR category LIKE ? ORDER BY id desc',
        variables: [Variable.withString(var1), Variable.withString(var2)],
        readsFrom: {serviceProvider}).map(serviceProvider.mapFromRow);
  }
}
mixin _$CategoryDaoMixin on DatabaseAccessor<LocalDatabase> {
  $CategoryItemTable get categoryItem => attachedDatabase.categoryItem;
  Selectable<ServiceCategory> categoryById(String var1) {
    return customSelect('SELECT * FROM category_item WHERE id = ?',
        variables: [Variable.withString(var1)],
        readsFrom: {categoryItem}).map(categoryItem.mapFromRow);
  }

  Selectable<ServiceCategory> categoryByGroup(int var1) {
    return customSelect('SELECT * FROM category_item WHERE groupName = ?',
        variables: [Variable.withInt(var1)],
        readsFrom: {categoryItem}).map(categoryItem.mapFromRow);
  }
}
mixin _$BookingDaoMixin on DatabaseAccessor<LocalDatabase> {
  $BookingsTable get bookings => attachedDatabase.bookings;
  Selectable<Booking> bookingsForCustomer(String var1) {
    return customSelect(
        'SELECT * FROM bookings WHERE customer_id = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1)],
        readsFrom: {bookings}).map(bookings.mapFromRow);
  }

  Selectable<Booking> bookingsForCustomerAndProvider(String var1, String var2) {
    return customSelect(
        'SELECT * FROM bookings WHERE customer_id = ? AND provider_id = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1), Variable.withString(var2)],
        readsFrom: {bookings}).map(bookings.mapFromRow);
  }
}
mixin _$ReviewDaoMixin on DatabaseAccessor<LocalDatabase> {
  $ReviewTable get review => attachedDatabase.review;
  Selectable<CustomerReview> reviewsForProvider(String var1) {
    return customSelect(
        'SELECT * FROM review WHERE customer_id = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1)],
        readsFrom: {review}).map(review.mapFromRow);
  }

  Selectable<CustomerReview> reviewsForCustomerAndProvider(
      String var1, String var2) {
    return customSelect(
        'SELECT * FROM review WHERE customer_id = ? AND provider_id = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1), Variable.withString(var2)],
        readsFrom: {review}).map(review.mapFromRow);
  }
}
mixin _$MessageDaoMixin on DatabaseAccessor<LocalDatabase> {
  $MessageTable get message => attachedDatabase.message;
  Selectable<Conversation> conversationWithRecipient(String var1, String var2) {
    return customSelect(
        'SELECT * FROM message WHERE author = ? AND recipient = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1), Variable.withString(var2)],
        readsFrom: {message}).map(message.mapFromRow);
  }
}
