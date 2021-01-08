// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 0;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[9] as String,
      createdAt: fields[10] as String,
      customerId: fields[0] as String,
      artisanId: fields[1] as String,
      category: fields[2] as String,
      imageUrl: fields[3] as String,
      description: fields[4] as String,
      position: fields[5] as LocationMetadata,
      cost: fields[6] as double,
      progress: fields[7] as double,
      dueDate: fields[8] as String,
      currentState: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.customerId)
      ..writeByte(1)
      ..write(obj.artisanId)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.cost)
      ..writeByte(7)
      ..write(obj.progress)
      ..writeByte(8)
      ..write(obj.dueDate)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.currentState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    id: json['id'] as String,
    createdAt: json['created_at'] as String,
    customerId: json['customer_id'] as String,
    artisanId: json['artisan_id'] as String,
    category: json['category'] as String,
    imageUrl: json['image_url'] as String,
    description: json['description'] as String,
    position: json['position'] == null
        ? null
        : LocationMetadata.fromJson(json['position'] as Map<String, dynamic>),
    cost: (json['cost'] as num)?.toDouble(),
    progress: (json['progress'] as num)?.toDouble(),
    dueDate: json['due_date'] as String,
    currentState: json['current_state'] as String,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'customer_id': instance.customerId,
      'artisan_id': instance.artisanId,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'position': instance.position,
      'cost': instance.cost,
      'progress': instance.progress,
      'due_date': instance.dueDate,
      'id': instance.id,
      'created_at': instance.createdAt,
      'current_state': instance.currentState,
    };
