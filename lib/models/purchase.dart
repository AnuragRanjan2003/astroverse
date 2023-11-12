import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase.g.dart';

typedef Json = Map<String, dynamic>;

@JsonSerializable(anyMap: true)
class Purchase {
  final String itemId;
  String purchaseId;
  final String itemPrice;
  final String totalPrice;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String sellerName;
  final String itemImage;
  final String itemName;
  @JsonKey(fromJson: _dateFromTimeStamp, toJson: _dateAsIs)
  DateTime boughtOn;
  final bool delivered;
  final int? review;
  @JsonKey(fromJson: _nullableDateFromTimeStamp, toJson: _nullableDateAsIs)
  final DateTime? deliveredOn;
  final String paymentId;

  Purchase(
      {required this.itemId,
      required this.purchaseId,
      required this.paymentId,
      required this.itemPrice,
      required this.totalPrice,
      required this.itemImage,
      required this.itemName,
      required this.buyerId,
      required this.buyerName,
      required this.sellerId,
      required this.sellerName,
      required this.boughtOn,
      required this.delivered,
      required this.review,
      required this.deliveredOn});

  static DateTime _dateFromTimeStamp(Timestamp timestamp) =>
      DateTime.parse(timestamp.toDate().toString());

  static DateTime _dateAsIs(DateTime dateTime) => dateTime;

  static DateTime? _nullableDateFromTimeStamp(Timestamp? timestamp) {
    if (timestamp == null) return null;
    return DateTime.parse(timestamp.toDate().toString());
  }

  Json toJson() => _$PurchaseToJson(this);

  factory Purchase.fromJson(Json json) => _$PurchaseFromJson(json);

  static DateTime? _nullableDateAsIs(DateTime? dateTime) => dateTime;

  factory Purchase.dummy() => Purchase(
      boughtOn: DateTime.now(),
      buyerId: 'xdae8lMC4DXqjz3DkoOSHeW0fdC3',
      buyerName: 'Anurag Testing',
      delivered: false,
      deliveredOn: DateTime.now(),
      itemId: '0bf28f0e-3640-4742-bd2a-9b97b9e58925',
      itemPrice: '23',
      purchaseId: '1',
      paymentId: '1',
      review: 0,
      itemImage:
          "https://firebasestorage.googleapis.com/v0/b/astroverse-5f2ae.appspot.com/o/serviceImage%2Fplanet.png?alt=media&token=7587f430-3ff2-41d4-8c47-6899db4b2db0",
      sellerId: '2dbSVMhJgjaUUqXxD6ryXjOBzOl2',
      sellerName: 'testing',
      totalPrice: '123',
      itemName: 'asdsa');
}

class PurchaseSave {}