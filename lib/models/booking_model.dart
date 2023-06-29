import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String bookingId;
  final CameraModel cameraBooking;
  final int rentalDay;
  final Timestamp? startRentalTime;
  final Timestamp? endRentalTime;
  final int totalPrice;
  final String userBookingId;
  final String userBookingName;
  final int userBookingNoTlpn;
  final Timestamp createdAt;
  final String status;
  final String buktiTransfer;

  Booking({
    required this.bookingId,
    required this.cameraBooking,
    required this.rentalDay,
    required this.startRentalTime,
    required this.endRentalTime,
    required this.totalPrice,
    required this.userBookingId,
    required this.userBookingName,
    required this.userBookingNoTlpn,
    required this.createdAt,
    required this.status,
    required this.buktiTransfer
  });

  Booking copyWith({
    String? bookingId,
    CameraModel? cameraBooking,
    int? rentalDay,
    Timestamp? startRentalTime,
    Timestamp? endRentalTime,
    int? totalPrice,
    String? userBookingId,
    String? userBookingName,
    int? userBookingNoTlpn,
    Timestamp? createdAt,
    String? status,
    String? buktiTransfer
  }) {
    return Booking(
      bookingId: bookingId ?? this.bookingId,
      cameraBooking: cameraBooking ?? this.cameraBooking,
      rentalDay: rentalDay ?? this.rentalDay,
      startRentalTime: startRentalTime ?? this.startRentalTime,
      endRentalTime: endRentalTime ?? this.endRentalTime,
      totalPrice: totalPrice ?? this.totalPrice,
      userBookingId: userBookingId ?? this.userBookingId,
      userBookingName: userBookingName ?? this.userBookingName,
      userBookingNoTlpn: userBookingNoTlpn ?? this.userBookingNoTlpn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      buktiTransfer: buktiTransfer ?? this.buktiTransfer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'booking_id': this.bookingId,
      'camera_booking': this.cameraBooking.toMap(),
      'rental_day': this.rentalDay,
      'start_rental_time': this.startRentalTime,
      'end_rental_time': this.endRentalTime,
      'total_price': this.totalPrice,
      'user_booking_id': this.userBookingId,
      'user_booking_name': this.userBookingName,
      'user_booking_noTlpn': this.userBookingNoTlpn,
      'created_at': this.createdAt,
      'status': this.status,
      'bukti_transfer': this.buktiTransfer,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['booking_id'],
      cameraBooking: CameraModel.fromMap(map['camera_booking']),
      rentalDay: map['rental_day'],
      startRentalTime: map['start_rental_time'] ,
      endRentalTime: map['end_rental_time'],
      totalPrice: map['total_price'],
      userBookingId: map['user_booking_id'],
      userBookingName: map['user_booking_name'] ,
      userBookingNoTlpn: map['user_booking_noTlpn'],
      createdAt: map['created_at'],
      status: map['status'] ,
      buktiTransfer: map['bukti_transfer'] ,
    );
  }

  @override
  List<Object?> get props =>
      [
        bookingId,
        cameraBooking,
        rentalDay,
        startRentalTime,
        endRentalTime,
        totalPrice,
        userBookingId,
        userBookingName,
        userBookingNoTlpn,
        createdAt,
        status,
        buktiTransfer,
      ];
}

class CameraModel extends Equatable {
  final String? cameraId;
  final String title;
  final String subTitle;
  final String description;
  final String picture;
  final String type;
  final int stock;
  int price;
  int? quantity;

  CameraModel({
    required this.cameraId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.picture,
    required this.type,
    required this.stock,
    required this.price,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'camera_id': cameraId,
      'title': title,
      'sub_title': subTitle,
      'description': description,
      'picture': picture,
      'type': type,
      'stock': stock,
      'price': price,
      'quantity' : quantity,
    };
  }

  Map<String, dynamic> toCameraBooking() {
    return {
      'camera_id': cameraId,
      'title': title,
      'sub_title': subTitle,
      'description': description,
      'picture': picture,
      'type': type,
      'stock': stock,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(
      cameraId: map['camera_id'] as String,
      title: map['title'] as String,
      subTitle: map['sub_title'] as String,
      description: map['description'] as String,
      picture: map['picture'] as String,
      type: map['type'] as String,
      stock: map['stock'] as int,
      price: map['price'] as int,
      quantity: map['quantity'],
    );
  }

  factory CameraModel.fromCameraBooking(Map<String, dynamic> map) {
    return CameraModel(
      cameraId: map['camera_id'] as String,
      title: map['title'] as String,
      subTitle: map['sub_title'] as String,
      description: map['description'] as String,
      picture: map['picture'] as String,
      type: map['type'] as String,
      stock: map['stock'] as int,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }

  CameraModel copyWith({
    String? cameraId,
    String? title,
    String? subTitle,
    String? description,
    String? picture,
    String? type,
    int? stock,
    int? price,
    int? quantity,
  }) {
    return CameraModel(
      cameraId: cameraId ?? this.cameraId,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      type: type ?? this.type,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props =>
      [cameraId, title, subTitle, description, picture, type, stock,];
}
