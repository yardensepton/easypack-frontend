// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripInfoAdapter extends TypeAdapter<TripInfo> {
  @override
  final int typeId = 1;

  @override
  TripInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripInfo(
      tripId: fields[0] as String,
      destination: fields[1] as String,
      departureDate: fields[2] as String,
      returnDate: fields[3] as String,
      cityUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TripInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.destination)
      ..writeByte(2)
      ..write(obj.departureDate)
      ..writeByte(3)
      ..write(obj.returnDate)
      ..writeByte(4)
      ..write(obj.cityUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
