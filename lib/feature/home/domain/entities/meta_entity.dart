import 'package:equatable/equatable.dart';

class MetaEntity extends Equatable {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  const MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];
}