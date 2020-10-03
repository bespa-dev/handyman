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
  final bool isAvailable;
  final String category;
  final int startWorkingHours;
  final int completedBookingsCount;
  final int ongoingBookingsCount;
  final int cancelledBookingsCount;
  final int requestsCount;
  final int endWorkingHours;
  final String avatar;
  final String aboutMe;
  final double price;
  final double rating;
  Artisan(
      {@required this.id,
      @required this.name,
      this.business,
      this.phone,
      @required this.email,
      @required this.isCertified,
      @required this.isAvailable,
      @required this.category,
      @required this.startWorkingHours,
      @required this.completedBookingsCount,
      @required this.ongoingBookingsCount,
      @required this.cancelledBookingsCount,
      @required this.requestsCount,
      @required this.endWorkingHours,
      this.avatar,
      this.aboutMe,
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
      isAvailable:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}available']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      startWorkingHours: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}start_working_hours']),
      completedBookingsCount: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}completed_bookings_count']),
      ongoingBookingsCount: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}ongoing_bookings_count']),
      cancelledBookingsCount: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}cancelled_bookings_count']),
      requestsCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}requests_count']),
      endWorkingHours: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_working_hours']),
      avatar:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      aboutMe: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}about_me']),
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
    if (!nullToAbsent || isAvailable != null) {
      map['available'] = Variable<bool>(isAvailable);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || startWorkingHours != null) {
      map['start_working_hours'] = Variable<int>(startWorkingHours);
    }
    if (!nullToAbsent || completedBookingsCount != null) {
      map['completed_bookings_count'] = Variable<int>(completedBookingsCount);
    }
    if (!nullToAbsent || ongoingBookingsCount != null) {
      map['ongoing_bookings_count'] = Variable<int>(ongoingBookingsCount);
    }
    if (!nullToAbsent || cancelledBookingsCount != null) {
      map['cancelled_bookings_count'] = Variable<int>(cancelledBookingsCount);
    }
    if (!nullToAbsent || requestsCount != null) {
      map['requests_count'] = Variable<int>(requestsCount);
    }
    if (!nullToAbsent || endWorkingHours != null) {
      map['end_working_hours'] = Variable<int>(endWorkingHours);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || aboutMe != null) {
      map['about_me'] = Variable<String>(aboutMe);
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
      isAvailable: isAvailable == null && nullToAbsent
          ? const Value.absent()
          : Value(isAvailable),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      startWorkingHours: startWorkingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(startWorkingHours),
      completedBookingsCount: completedBookingsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(completedBookingsCount),
      ongoingBookingsCount: ongoingBookingsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(ongoingBookingsCount),
      cancelledBookingsCount: cancelledBookingsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledBookingsCount),
      requestsCount: requestsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(requestsCount),
      endWorkingHours: endWorkingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(endWorkingHours),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      aboutMe: aboutMe == null && nullToAbsent
          ? const Value.absent()
          : Value(aboutMe),
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
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      category: serializer.fromJson<String>(json['category']),
      startWorkingHours: serializer.fromJson<int>(json['startWorkingHours']),
      completedBookingsCount:
          serializer.fromJson<int>(json['completedBookingsCount']),
      ongoingBookingsCount:
          serializer.fromJson<int>(json['ongoingBookingsCount']),
      cancelledBookingsCount:
          serializer.fromJson<int>(json['cancelledBookingsCount']),
      requestsCount: serializer.fromJson<int>(json['requestsCount']),
      endWorkingHours: serializer.fromJson<int>(json['endWorkingHours']),
      avatar: serializer.fromJson<String>(json['avatar']),
      aboutMe: serializer.fromJson<String>(json['aboutMe']),
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
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'category': serializer.toJson<String>(category),
      'startWorkingHours': serializer.toJson<int>(startWorkingHours),
      'completedBookingsCount': serializer.toJson<int>(completedBookingsCount),
      'ongoingBookingsCount': serializer.toJson<int>(ongoingBookingsCount),
      'cancelledBookingsCount': serializer.toJson<int>(cancelledBookingsCount),
      'requestsCount': serializer.toJson<int>(requestsCount),
      'endWorkingHours': serializer.toJson<int>(endWorkingHours),
      'avatar': serializer.toJson<String>(avatar),
      'aboutMe': serializer.toJson<String>(aboutMe),
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
          bool isAvailable,
          String category,
          int startWorkingHours,
          int completedBookingsCount,
          int ongoingBookingsCount,
          int cancelledBookingsCount,
          int requestsCount,
          int endWorkingHours,
          String avatar,
          String aboutMe,
          double price,
          double rating}) =>
      Artisan(
        id: id ?? this.id,
        name: name ?? this.name,
        business: business ?? this.business,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        isCertified: isCertified ?? this.isCertified,
        isAvailable: isAvailable ?? this.isAvailable,
        category: category ?? this.category,
        startWorkingHours: startWorkingHours ?? this.startWorkingHours,
        completedBookingsCount:
            completedBookingsCount ?? this.completedBookingsCount,
        ongoingBookingsCount: ongoingBookingsCount ?? this.ongoingBookingsCount,
        cancelledBookingsCount:
            cancelledBookingsCount ?? this.cancelledBookingsCount,
        requestsCount: requestsCount ?? this.requestsCount,
        endWorkingHours: endWorkingHours ?? this.endWorkingHours,
        avatar: avatar ?? this.avatar,
        aboutMe: aboutMe ?? this.aboutMe,
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
          ..write('isAvailable: $isAvailable, ')
          ..write('category: $category, ')
          ..write('startWorkingHours: $startWorkingHours, ')
          ..write('completedBookingsCount: $completedBookingsCount, ')
          ..write('ongoingBookingsCount: $ongoingBookingsCount, ')
          ..write('cancelledBookingsCount: $cancelledBookingsCount, ')
          ..write('requestsCount: $requestsCount, ')
          ..write('endWorkingHours: $endWorkingHours, ')
          ..write('avatar: $avatar, ')
          ..write('aboutMe: $aboutMe, ')
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
                              isAvailable.hashCode,
                              $mrjc(
                                  category.hashCode,
                                  $mrjc(
                                      startWorkingHours.hashCode,
                                      $mrjc(
                                          completedBookingsCount.hashCode,
                                          $mrjc(
                                              ongoingBookingsCount.hashCode,
                                              $mrjc(
                                                  cancelledBookingsCount
                                                      .hashCode,
                                                  $mrjc(
                                                      requestsCount.hashCode,
                                                      $mrjc(
                                                          endWorkingHours
                                                              .hashCode,
                                                          $mrjc(
                                                              avatar.hashCode,
                                                              $mrjc(
                                                                  aboutMe
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      price
                                                                          .hashCode,
                                                                      rating
                                                                          .hashCode))))))))))))))))));
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
          other.isAvailable == this.isAvailable &&
          other.category == this.category &&
          other.startWorkingHours == this.startWorkingHours &&
          other.completedBookingsCount == this.completedBookingsCount &&
          other.ongoingBookingsCount == this.ongoingBookingsCount &&
          other.cancelledBookingsCount == this.cancelledBookingsCount &&
          other.requestsCount == this.requestsCount &&
          other.endWorkingHours == this.endWorkingHours &&
          other.avatar == this.avatar &&
          other.aboutMe == this.aboutMe &&
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
  final Value<bool> isAvailable;
  final Value<String> category;
  final Value<int> startWorkingHours;
  final Value<int> completedBookingsCount;
  final Value<int> ongoingBookingsCount;
  final Value<int> cancelledBookingsCount;
  final Value<int> requestsCount;
  final Value<int> endWorkingHours;
  final Value<String> avatar;
  final Value<String> aboutMe;
  final Value<double> price;
  final Value<double> rating;
  const ServiceProviderCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.business = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.isCertified = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.category = const Value.absent(),
    this.startWorkingHours = const Value.absent(),
    this.completedBookingsCount = const Value.absent(),
    this.ongoingBookingsCount = const Value.absent(),
    this.cancelledBookingsCount = const Value.absent(),
    this.requestsCount = const Value.absent(),
    this.endWorkingHours = const Value.absent(),
    this.avatar = const Value.absent(),
    this.aboutMe = const Value.absent(),
    this.price = const Value.absent(),
    this.rating = const Value.absent(),
  });
  ServiceProviderCompanion.insert({
    @required String id,
    @required String name,
    this.business = const Value.absent(),
    this.phone = const Value.absent(),
    @required String email,
    this.isCertified = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.category = const Value.absent(),
    this.startWorkingHours = const Value.absent(),
    this.completedBookingsCount = const Value.absent(),
    this.ongoingBookingsCount = const Value.absent(),
    this.cancelledBookingsCount = const Value.absent(),
    this.requestsCount = const Value.absent(),
    this.endWorkingHours = const Value.absent(),
    this.avatar = const Value.absent(),
    this.aboutMe = const Value.absent(),
    this.price = const Value.absent(),
    this.rating = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email);
  static Insertable<Artisan> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> business,
    Expression<String> phone,
    Expression<String> email,
    Expression<bool> isCertified,
    Expression<bool> isAvailable,
    Expression<String> category,
    Expression<int> startWorkingHours,
    Expression<int> completedBookingsCount,
    Expression<int> ongoingBookingsCount,
    Expression<int> cancelledBookingsCount,
    Expression<int> requestsCount,
    Expression<int> endWorkingHours,
    Expression<String> avatar,
    Expression<String> aboutMe,
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
      if (isAvailable != null) 'available': isAvailable,
      if (category != null) 'category': category,
      if (startWorkingHours != null) 'start_working_hours': startWorkingHours,
      if (completedBookingsCount != null)
        'completed_bookings_count': completedBookingsCount,
      if (ongoingBookingsCount != null)
        'ongoing_bookings_count': ongoingBookingsCount,
      if (cancelledBookingsCount != null)
        'cancelled_bookings_count': cancelledBookingsCount,
      if (requestsCount != null) 'requests_count': requestsCount,
      if (endWorkingHours != null) 'end_working_hours': endWorkingHours,
      if (avatar != null) 'avatar': avatar,
      if (aboutMe != null) 'about_me': aboutMe,
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
      Value<bool> isAvailable,
      Value<String> category,
      Value<int> startWorkingHours,
      Value<int> completedBookingsCount,
      Value<int> ongoingBookingsCount,
      Value<int> cancelledBookingsCount,
      Value<int> requestsCount,
      Value<int> endWorkingHours,
      Value<String> avatar,
      Value<String> aboutMe,
      Value<double> price,
      Value<double> rating}) {
    return ServiceProviderCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      business: business ?? this.business,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isCertified: isCertified ?? this.isCertified,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
      startWorkingHours: startWorkingHours ?? this.startWorkingHours,
      completedBookingsCount:
          completedBookingsCount ?? this.completedBookingsCount,
      ongoingBookingsCount: ongoingBookingsCount ?? this.ongoingBookingsCount,
      cancelledBookingsCount:
          cancelledBookingsCount ?? this.cancelledBookingsCount,
      requestsCount: requestsCount ?? this.requestsCount,
      endWorkingHours: endWorkingHours ?? this.endWorkingHours,
      avatar: avatar ?? this.avatar,
      aboutMe: aboutMe ?? this.aboutMe,
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
    if (isAvailable.present) {
      map['available'] = Variable<bool>(isAvailable.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (startWorkingHours.present) {
      map['start_working_hours'] = Variable<int>(startWorkingHours.value);
    }
    if (completedBookingsCount.present) {
      map['completed_bookings_count'] =
          Variable<int>(completedBookingsCount.value);
    }
    if (ongoingBookingsCount.present) {
      map['ongoing_bookings_count'] = Variable<int>(ongoingBookingsCount.value);
    }
    if (cancelledBookingsCount.present) {
      map['cancelled_bookings_count'] =
          Variable<int>(cancelledBookingsCount.value);
    }
    if (requestsCount.present) {
      map['requests_count'] = Variable<int>(requestsCount.value);
    }
    if (endWorkingHours.present) {
      map['end_working_hours'] = Variable<int>(endWorkingHours.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (aboutMe.present) {
      map['about_me'] = Variable<String>(aboutMe.value);
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
          ..write('isAvailable: $isAvailable, ')
          ..write('category: $category, ')
          ..write('startWorkingHours: $startWorkingHours, ')
          ..write('completedBookingsCount: $completedBookingsCount, ')
          ..write('ongoingBookingsCount: $ongoingBookingsCount, ')
          ..write('cancelledBookingsCount: $cancelledBookingsCount, ')
          ..write('requestsCount: $requestsCount, ')
          ..write('endWorkingHours: $endWorkingHours, ')
          ..write('avatar: $avatar, ')
          ..write('aboutMe: $aboutMe, ')
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
      true,
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

  final VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  GeneratedBoolColumn _isAvailable;
  @override
  GeneratedBoolColumn get isAvailable =>
      _isAvailable ??= _constructIsAvailable();
  GeneratedBoolColumn _constructIsAvailable() {
    return GeneratedBoolColumn('available', $tableName, false,
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

  final VerificationMeta _completedBookingsCountMeta =
      const VerificationMeta('completedBookingsCount');
  GeneratedIntColumn _completedBookingsCount;
  @override
  GeneratedIntColumn get completedBookingsCount =>
      _completedBookingsCount ??= _constructCompletedBookingsCount();
  GeneratedIntColumn _constructCompletedBookingsCount() {
    return GeneratedIntColumn('completed_bookings_count', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _ongoingBookingsCountMeta =
      const VerificationMeta('ongoingBookingsCount');
  GeneratedIntColumn _ongoingBookingsCount;
  @override
  GeneratedIntColumn get ongoingBookingsCount =>
      _ongoingBookingsCount ??= _constructOngoingBookingsCount();
  GeneratedIntColumn _constructOngoingBookingsCount() {
    return GeneratedIntColumn('ongoing_bookings_count', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _cancelledBookingsCountMeta =
      const VerificationMeta('cancelledBookingsCount');
  GeneratedIntColumn _cancelledBookingsCount;
  @override
  GeneratedIntColumn get cancelledBookingsCount =>
      _cancelledBookingsCount ??= _constructCancelledBookingsCount();
  GeneratedIntColumn _constructCancelledBookingsCount() {
    return GeneratedIntColumn('cancelled_bookings_count', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _requestsCountMeta =
      const VerificationMeta('requestsCount');
  GeneratedIntColumn _requestsCount;
  @override
  GeneratedIntColumn get requestsCount =>
      _requestsCount ??= _constructRequestsCount();
  GeneratedIntColumn _constructRequestsCount() {
    return GeneratedIntColumn('requests_count', $tableName, false,
        defaultValue: Constant(0));
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

  final VerificationMeta _aboutMeMeta = const VerificationMeta('aboutMe');
  GeneratedTextColumn _aboutMe;
  @override
  GeneratedTextColumn get aboutMe => _aboutMe ??= _constructAboutMe();
  GeneratedTextColumn _constructAboutMe() {
    return GeneratedTextColumn('about_me', $tableName, true,
        maxTextLength: 5000);
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
        isAvailable,
        category,
        startWorkingHours,
        completedBookingsCount,
        ongoingBookingsCount,
        cancelledBookingsCount,
        requestsCount,
        endWorkingHours,
        avatar,
        aboutMe,
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
    if (data.containsKey('available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['available'], _isAvailableMeta));
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
    if (data.containsKey('completed_bookings_count')) {
      context.handle(
          _completedBookingsCountMeta,
          completedBookingsCount.isAcceptableOrUnknown(
              data['completed_bookings_count'], _completedBookingsCountMeta));
    }
    if (data.containsKey('ongoing_bookings_count')) {
      context.handle(
          _ongoingBookingsCountMeta,
          ongoingBookingsCount.isAcceptableOrUnknown(
              data['ongoing_bookings_count'], _ongoingBookingsCountMeta));
    }
    if (data.containsKey('cancelled_bookings_count')) {
      context.handle(
          _cancelledBookingsCountMeta,
          cancelledBookingsCount.isAcceptableOrUnknown(
              data['cancelled_bookings_count'], _cancelledBookingsCountMeta));
    }
    if (data.containsKey('requests_count')) {
      context.handle(
          _requestsCountMeta,
          requestsCount.isAcceptableOrUnknown(
              data['requests_count'], _requestsCountMeta));
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
    if (data.containsKey('about_me')) {
      context.handle(_aboutMeMeta,
          aboutMe.isAcceptableOrUnknown(data['about_me'], _aboutMeMeta));
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
  final String createdAt;
  Customer(
      {@required this.id,
      @required this.name,
      @required this.email,
      this.avatar,
      this.createdAt});
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
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
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
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
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
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
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
      createdAt: serializer.fromJson<String>(json['createdAt']),
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
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Customer copyWith(
          {String id,
          String name,
          String email,
          String avatar,
          String createdAt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(email.hashCode, $mrjc(avatar.hashCode, createdAt.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.avatar == this.avatar &&
          other.createdAt == this.createdAt);
}

class UserCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> avatar;
  final Value<String> createdAt;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatar = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserCompanion.insert({
    @required String id,
    @required String name,
    @required String email,
    this.avatar = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email);
  static Insertable<Customer> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> email,
    Expression<String> avatar,
    Expression<String> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> email,
      Value<String> avatar,
      Value<String> createdAt}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatar: $avatar, ')
          ..write('createdAt: $createdAt')
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
      false,
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

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedTextColumn _createdAt;
  @override
  GeneratedTextColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, email, avatar, createdAt];
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
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
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

class Gallery extends DataClass implements Insertable<Gallery> {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime createdAt;
  Gallery(
      {@required this.id,
      @required this.userId,
      @required this.imageUrl,
      @required this.createdAt});
  factory Gallery.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Gallery(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      imageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  PhotoGalleryCompanion toCompanion(bool nullToAbsent) {
    return PhotoGalleryCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Gallery.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Gallery(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Gallery copyWith(
          {String id, String userId, String imageUrl, DateTime createdAt}) =>
      Gallery(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        imageUrl: imageUrl ?? this.imageUrl,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Gallery(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(userId.hashCode, $mrjc(imageUrl.hashCode, createdAt.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Gallery &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt);
}

class PhotoGalleryCompanion extends UpdateCompanion<Gallery> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> imageUrl;
  final Value<DateTime> createdAt;
  const PhotoGalleryCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PhotoGalleryCompanion.insert({
    @required String id,
    @required String userId,
    @required String imageUrl,
    this.createdAt = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        imageUrl = Value(imageUrl);
  static Insertable<Gallery> custom({
    Expression<String> id,
    Expression<String> userId,
    Expression<String> imageUrl,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PhotoGalleryCompanion copyWith(
      {Value<String> id,
      Value<String> userId,
      Value<String> imageUrl,
      Value<DateTime> createdAt}) {
    return PhotoGalleryCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoGalleryCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PhotoGalleryTable extends PhotoGallery
    with TableInfo<$PhotoGalleryTable, Gallery> {
  final GeneratedDatabase _db;
  final String _alias;
  $PhotoGalleryTable(this._db, [this._alias]);
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

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn(
      'image_url',
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
  List<GeneratedColumn> get $columns => [id, userId, imageUrl, createdAt];
  @override
  $PhotoGalleryTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'photo_gallery';
  @override
  final String actualTableName = 'photo_gallery';
  @override
  VerificationContext validateIntegrity(Insertable<Gallery> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url'], _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, userId};
  @override
  Gallery map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Gallery.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PhotoGalleryTable createAlias(String alias) {
    return $PhotoGalleryTable(_db, alias);
  }
}

class Booking extends DataClass implements Insertable<Booking> {
  final int id;
  final String customerId;
  final String providerId;
  final String description;
  final String reason;
  final double locationLat;
  final double locationLng;
  final double value;
  final double progress;
  final int createdAt;
  final int dueDate;
  Booking(
      {@required this.id,
      @required this.customerId,
      @required this.providerId,
      this.description,
      @required this.reason,
      @required this.locationLat,
      @required this.locationLng,
      @required this.value,
      @required this.progress,
      @required this.createdAt,
      @required this.dueDate});
  factory Booking.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Booking(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      customerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      providerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}provider_id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      reason:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}reason']),
      locationLat:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}lat']),
      locationLng:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}lng']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      progress: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}progress']),
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      dueDate:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
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
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || locationLat != null) {
      map['lat'] = Variable<double>(locationLat);
    }
    if (!nullToAbsent || locationLng != null) {
      map['lng'] = Variable<double>(locationLng);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || progress != null) {
      map['progress'] = Variable<double>(progress);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<int>(dueDate);
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
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      locationLat: locationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLat),
      locationLng: locationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLng),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      progress: progress == null && nullToAbsent
          ? const Value.absent()
          : Value(progress),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Booking(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      description: serializer.fromJson<String>(json['description']),
      reason: serializer.fromJson<String>(json['reason']),
      locationLat: serializer.fromJson<double>(json['lat']),
      locationLng: serializer.fromJson<double>(json['lng']),
      value: serializer.fromJson<double>(json['value']),
      progress: serializer.fromJson<double>(json['progress']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      dueDate: serializer.fromJson<int>(json['dueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<String>(customerId),
      'providerId': serializer.toJson<String>(providerId),
      'description': serializer.toJson<String>(description),
      'reason': serializer.toJson<String>(reason),
      'lat': serializer.toJson<double>(locationLat),
      'lng': serializer.toJson<double>(locationLng),
      'value': serializer.toJson<double>(value),
      'progress': serializer.toJson<double>(progress),
      'created_at': serializer.toJson<int>(createdAt),
      'dueDate': serializer.toJson<int>(dueDate),
    };
  }

  Booking copyWith(
          {int id,
          String customerId,
          String providerId,
          String description,
          String reason,
          double locationLat,
          double locationLng,
          double value,
          double progress,
          int createdAt,
          int dueDate}) =>
      Booking(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        providerId: providerId ?? this.providerId,
        description: description ?? this.description,
        reason: reason ?? this.reason,
        locationLat: locationLat ?? this.locationLat,
        locationLng: locationLng ?? this.locationLng,
        value: value ?? this.value,
        progress: progress ?? this.progress,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
      );
  @override
  String toString() {
    return (StringBuffer('Booking(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('description: $description, ')
          ..write('reason: $reason, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('value: $value, ')
          ..write('progress: $progress, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          customerId.hashCode,
          $mrjc(
              providerId.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      reason.hashCode,
                      $mrjc(
                          locationLat.hashCode,
                          $mrjc(
                              locationLng.hashCode,
                              $mrjc(
                                  value.hashCode,
                                  $mrjc(
                                      progress.hashCode,
                                      $mrjc(createdAt.hashCode,
                                          dueDate.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Booking &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.providerId == this.providerId &&
          other.description == this.description &&
          other.reason == this.reason &&
          other.locationLat == this.locationLat &&
          other.locationLng == this.locationLng &&
          other.value == this.value &&
          other.progress == this.progress &&
          other.createdAt == this.createdAt &&
          other.dueDate == this.dueDate);
}

class BookingsCompanion extends UpdateCompanion<Booking> {
  final Value<int> id;
  final Value<String> customerId;
  final Value<String> providerId;
  final Value<String> description;
  final Value<String> reason;
  final Value<double> locationLat;
  final Value<double> locationLng;
  final Value<double> value;
  final Value<double> progress;
  final Value<int> createdAt;
  final Value<int> dueDate;
  const BookingsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.description = const Value.absent(),
    this.reason = const Value.absent(),
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.value = const Value.absent(),
    this.progress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dueDate = const Value.absent(),
  });
  BookingsCompanion.insert({
    this.id = const Value.absent(),
    @required String customerId,
    @required String providerId,
    this.description = const Value.absent(),
    @required String reason,
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.value = const Value.absent(),
    this.progress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dueDate = const Value.absent(),
  })  : customerId = Value(customerId),
        providerId = Value(providerId),
        reason = Value(reason);
  static Insertable<Booking> custom({
    Expression<int> id,
    Expression<String> customerId,
    Expression<String> providerId,
    Expression<String> description,
    Expression<String> reason,
    Expression<double> locationLat,
    Expression<double> locationLng,
    Expression<double> value,
    Expression<double> progress,
    Expression<int> createdAt,
    Expression<int> dueDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (providerId != null) 'provider_id': providerId,
      if (description != null) 'description': description,
      if (reason != null) 'reason': reason,
      if (locationLat != null) 'lat': locationLat,
      if (locationLng != null) 'lng': locationLng,
      if (value != null) 'value': value,
      if (progress != null) 'progress': progress,
      if (createdAt != null) 'created_at': createdAt,
      if (dueDate != null) 'due_date': dueDate,
    });
  }

  BookingsCompanion copyWith(
      {Value<int> id,
      Value<String> customerId,
      Value<String> providerId,
      Value<String> description,
      Value<String> reason,
      Value<double> locationLat,
      Value<double> locationLng,
      Value<double> value,
      Value<double> progress,
      Value<int> createdAt,
      Value<int> dueDate}) {
    return BookingsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      providerId: providerId ?? this.providerId,
      description: description ?? this.description,
      reason: reason ?? this.reason,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      value: value ?? this.value,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (locationLat.present) {
      map['lat'] = Variable<double>(locationLat.value);
    }
    if (locationLng.present) {
      map['lng'] = Variable<double>(locationLng.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<int>(dueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('description: $description, ')
          ..write('reason: $reason, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('value: $value, ')
          ..write('progress: $progress, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueDate: $dueDate')
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

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        maxTextLength: 1000,
        defaultValue: Constant(
            "Ipsum suspendisse ultrices gravida dictum fusce ut placerat. Cursus sit amet dictum sit amet. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique"));
  }

  final VerificationMeta _reasonMeta = const VerificationMeta('reason');
  GeneratedTextColumn _reason;
  @override
  GeneratedTextColumn get reason => _reason ??= _constructReason();
  GeneratedTextColumn _constructReason() {
    return GeneratedTextColumn(
      'reason',
      $tableName,
      false,
    );
  }

  final VerificationMeta _locationLatMeta =
      const VerificationMeta('locationLat');
  GeneratedRealColumn _locationLat;
  @override
  GeneratedRealColumn get locationLat =>
      _locationLat ??= _constructLocationLat();
  GeneratedRealColumn _constructLocationLat() {
    return GeneratedRealColumn('lat', $tableName, false,
        defaultValue: Constant(5.11));
  }

  final VerificationMeta _locationLngMeta =
      const VerificationMeta('locationLng');
  GeneratedRealColumn _locationLng;
  @override
  GeneratedRealColumn get locationLng =>
      _locationLng ??= _constructLocationLng();
  GeneratedRealColumn _constructLocationLng() {
    return GeneratedRealColumn('lng', $tableName, false,
        defaultValue: Constant(-0.122));
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn('value', $tableName, false,
        defaultValue: Constant(10.99));
  }

  final VerificationMeta _progressMeta = const VerificationMeta('progress');
  GeneratedRealColumn _progress;
  @override
  GeneratedRealColumn get progress => _progress ??= _constructProgress();
  GeneratedRealColumn _constructProgress() {
    return GeneratedRealColumn('progress', $tableName, false,
        defaultValue: Constant(0.45));
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn('created_at', $tableName, false,
        defaultValue: Constant(DateTime.now().millisecondsSinceEpoch));
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedIntColumn _dueDate;
  @override
  GeneratedIntColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedIntColumn _constructDueDate() {
    return GeneratedIntColumn('due_date', $tableName, false,
        defaultValue:
            Constant(DateTime.now().millisecondsSinceEpoch + 430000000));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        providerId,
        description,
        reason,
        locationLat,
        locationLng,
        value,
        progress,
        createdAt,
        dueDate
      ];
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason'], _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(_locationLatMeta,
          locationLat.isAcceptableOrUnknown(data['lat'], _locationLatMeta));
    }
    if (data.containsKey('lng')) {
      context.handle(_locationLngMeta,
          locationLng.isAcceptableOrUnknown(data['lng'], _locationLngMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress'], _progressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
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
  final String id;
  final String review;
  final String customerId;
  final String providerId;
  final double rating;
  final DateTime createdAt;
  CustomerReview(
      {@required this.id,
      @required this.review,
      @required this.customerId,
      @required this.providerId,
      this.rating,
      @required this.createdAt});
  factory CustomerReview.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CustomerReview(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      review:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}review']),
      customerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      providerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}provider_id']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
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
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
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
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory CustomerReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CustomerReview(
      id: serializer.fromJson<String>(json['id']),
      review: serializer.fromJson<String>(json['review']),
      customerId: serializer.fromJson<String>(json['customerId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      rating: serializer.fromJson<double>(json['rating']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'review': serializer.toJson<String>(review),
      'customerId': serializer.toJson<String>(customerId),
      'providerId': serializer.toJson<String>(providerId),
      'rating': serializer.toJson<double>(rating),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerReview copyWith(
          {String id,
          String review,
          String customerId,
          String providerId,
          double rating,
          DateTime createdAt}) =>
      CustomerReview(
        id: id ?? this.id,
        review: review ?? this.review,
        customerId: customerId ?? this.customerId,
        providerId: providerId ?? this.providerId,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CustomerReview(')
          ..write('id: $id, ')
          ..write('review: $review, ')
          ..write('customerId: $customerId, ')
          ..write('providerId: $providerId, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          review.hashCode,
          $mrjc(
              customerId.hashCode,
              $mrjc(providerId.hashCode,
                  $mrjc(rating.hashCode, createdAt.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CustomerReview &&
          other.id == this.id &&
          other.review == this.review &&
          other.customerId == this.customerId &&
          other.providerId == this.providerId &&
          other.rating == this.rating &&
          other.createdAt == this.createdAt);
}

class ReviewCompanion extends UpdateCompanion<CustomerReview> {
  final Value<String> id;
  final Value<String> review;
  final Value<String> customerId;
  final Value<String> providerId;
  final Value<double> rating;
  final Value<DateTime> createdAt;
  const ReviewCompanion({
    this.id = const Value.absent(),
    this.review = const Value.absent(),
    this.customerId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReviewCompanion.insert({
    @required String id,
    @required String review,
    @required String customerId,
    @required String providerId,
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : id = Value(id),
        review = Value(review),
        customerId = Value(customerId),
        providerId = Value(providerId);
  static Insertable<CustomerReview> custom({
    Expression<String> id,
    Expression<String> review,
    Expression<String> customerId,
    Expression<String> providerId,
    Expression<double> rating,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (review != null) 'review': review,
      if (customerId != null) 'customer_id': customerId,
      if (providerId != null) 'provider_id': providerId,
      if (rating != null) 'rating': rating,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReviewCompanion copyWith(
      {Value<String> id,
      Value<String> review,
      Value<String> customerId,
      Value<String> providerId,
      Value<double> rating,
      Value<DateTime> createdAt}) {
    return ReviewCompanion(
      id: id ?? this.id,
      review: review ?? this.review,
      customerId: customerId ?? this.customerId,
      providerId: providerId ?? this.providerId,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
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
          ..write('rating: $rating, ')
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

  final VerificationMeta _reviewMeta = const VerificationMeta('review');
  GeneratedTextColumn _review;
  @override
  GeneratedTextColumn get review => _review ??= _constructReview();
  GeneratedTextColumn _constructReview() {
    return GeneratedTextColumn('review', $tableName, false,
        maxTextLength: 5000);
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

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedRealColumn _rating;
  @override
  GeneratedRealColumn get rating => _rating ??= _constructRating();
  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn('rating', $tableName, true,
        defaultValue: Constant(1.5));
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
      [id, review, customerId, providerId, rating, createdAt];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, customerId, providerId};
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
  final int artisans;
  ServiceCategory(
      {@required this.id,
      @required this.name,
      @required this.avatar,
      @required this.groupName,
      @required this.artisans});
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
      artisans:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}artisans']),
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
    if (!nullToAbsent || artisans != null) {
      map['artisans'] = Variable<int>(artisans);
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
      artisans: artisans == null && nullToAbsent
          ? const Value.absent()
          : Value(artisans),
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
      artisans: serializer.fromJson<int>(json['artisans']),
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
      'artisans': serializer.toJson<int>(artisans),
    };
  }

  ServiceCategory copyWith(
          {String id,
          String name,
          String avatar,
          int groupName,
          int artisans}) =>
      ServiceCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        groupName: groupName ?? this.groupName,
        artisans: artisans ?? this.artisans,
      );
  @override
  String toString() {
    return (StringBuffer('ServiceCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('groupName: $groupName, ')
          ..write('artisans: $artisans')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              avatar.hashCode, $mrjc(groupName.hashCode, artisans.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ServiceCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.groupName == this.groupName &&
          other.artisans == this.artisans);
}

class CategoryItemCompanion extends UpdateCompanion<ServiceCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> avatar;
  final Value<int> groupName;
  final Value<int> artisans;
  const CategoryItemCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.groupName = const Value.absent(),
    this.artisans = const Value.absent(),
  });
  CategoryItemCompanion.insert({
    @required String id,
    @required String name,
    @required String avatar,
    this.groupName = const Value.absent(),
    this.artisans = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        avatar = Value(avatar);
  static Insertable<ServiceCategory> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> avatar,
    Expression<int> groupName,
    Expression<int> artisans,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (groupName != null) 'groupName': groupName,
      if (artisans != null) 'artisans': artisans,
    });
  }

  CategoryItemCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> avatar,
      Value<int> groupName,
      Value<int> artisans}) {
    return CategoryItemCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      groupName: groupName ?? this.groupName,
      artisans: artisans ?? this.artisans,
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
    if (artisans.present) {
      map['artisans'] = Variable<int>(artisans.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryItemCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('groupName: $groupName, ')
          ..write('artisans: $artisans')
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

  final VerificationMeta _artisansMeta = const VerificationMeta('artisans');
  GeneratedIntColumn _artisans;
  @override
  GeneratedIntColumn get artisans => _artisans ??= _constructArtisans();
  GeneratedIntColumn _constructArtisans() {
    return GeneratedIntColumn('artisans', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, avatar, groupName, artisans];
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
    if (data.containsKey('artisans')) {
      context.handle(_artisansMeta,
          artisans.isAcceptableOrUnknown(data['artisans'], _artisansMeta));
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
      createdAt: serializer.fromJson<String>(json['created_at']),
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
      'created_at': serializer.toJson<String>(createdAt),
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
  $PhotoGalleryTable _photoGallery;
  $PhotoGalleryTable get photoGallery =>
      _photoGallery ??= $PhotoGalleryTable(this);
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
  CustomerDao _customerDao;
  CustomerDao get customerDao =>
      _customerDao ??= CustomerDao(this as LocalDatabase);
  GalleryDao _galleryDao;
  GalleryDao get galleryDao =>
      _galleryDao ??= GalleryDao(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        serviceProvider,
        user,
        photoGallery,
        bookings,
        review,
        categoryItem,
        message
      ];
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

  Selectable<Artisan> artisans(String var1) {
    return customSelect(
        'SELECT * FROM service_provider WHERE category = ? ORDER BY id desc',
        variables: [Variable.withString(var1)],
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
        'SELECT * FROM bookings WHERE customer_id = ? ORDER BY due_date DESC',
        variables: [Variable.withString(var1)],
        readsFrom: {bookings}).map(bookings.mapFromRow);
  }

  Selectable<Booking> bookingsForProvider(String var1) {
    return customSelect(
        'SELECT * FROM bookings WHERE provider_id = ? ORDER BY due_date DESC',
        variables: [Variable.withString(var1)],
        readsFrom: {bookings}).map(bookings.mapFromRow);
  }

  Selectable<Booking> bookingsForCustomerAndProvider(String var1, String var2) {
    return customSelect(
        'SELECT * FROM bookings WHERE customer_id = ? AND provider_id = ? ORDER BY due_date DESC',
        variables: [Variable.withString(var1), Variable.withString(var2)],
        readsFrom: {bookings}).map(bookings.mapFromRow);
  }
}
mixin _$ReviewDaoMixin on DatabaseAccessor<LocalDatabase> {
  $ReviewTable get review => attachedDatabase.review;
  Selectable<CustomerReview> reviewsForProvider(String var1) {
    return customSelect(
        'SELECT * FROM review WHERE provider_id = ? ORDER BY created_at DESC',
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
}
mixin _$CustomerDaoMixin on DatabaseAccessor<LocalDatabase> {
  $UserTable get user => attachedDatabase.user;
  Selectable<Customer> customerById(String var1) {
    return customSelect('SELECT * FROM user WHERE id = ?',
        variables: [Variable.withString(var1)],
        readsFrom: {user}).map(user.mapFromRow);
  }
}
mixin _$GalleryDaoMixin on DatabaseAccessor<LocalDatabase> {
  $PhotoGalleryTable get photoGallery => attachedDatabase.photoGallery;
  Selectable<Gallery> photosForUser(String var1) {
    return customSelect(
        'SELECT * FROM photo_gallery WHERE user_id = ? ORDER BY created_at DESC',
        variables: [Variable.withString(var1)],
        readsFrom: {photoGallery}).map(photoGallery.mapFromRow);
  }
}
