// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 6;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      name: fields[0] as String,
      email: fields[1] as String,
      avatar: fields[2] as String,
      token: fields[3] as String,
      phone: fields[4] as String,
      id: fields[5] as String,
      createdAt: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.avatar)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    name: json['name'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    token: json['token'] as String,
    phone: json['phone'] as String,
    id: json['id'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'token': instance.token,
      'phone': instance.phone,
      'id': instance.id,
      'createdAt': instance.createdAt,
    };
