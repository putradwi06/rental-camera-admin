import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String bookingId;
  final List<CameraBooking> listCameraBooking;
  final int rentalDay;
  final Timestamp startRentalTime;
  final Timestamp endRentalTime;
  final int totalPrice;
  final String userBookingId;
  final String userBookingName;
  final int userBookingNoTlpn;
  final Timestamp createdAt;
  final String status;

  Booking({
    required this.bookingId,
    required this.listCameraBooking,
    required this.rentalDay,
    required this.startRentalTime,
    required this.endRentalTime,
    required this.totalPrice,
    required this.userBookingId,
    required this.userBookingName,
    required this.userBookingNoTlpn,
    required this.createdAt,
    required this.status,
  });

  Booking copyWith({
    String? bookingId,
    List<CameraBooking>? listCameraBooking,
    int? rentalDay,
    Timestamp? startRentalTime,
    Timestamp? endRentalTime,
    int? totalPrice,
    String? userBookingId,
    String? userBookingName,
    int? userBookingNoTlpn,
    Timestamp? createdAt,
    String? status,
  }) {
    return Booking(
      bookingId: bookingId ?? this.bookingId,
      listCameraBooking: listCameraBooking ?? this.listCameraBooking,
      rentalDay: rentalDay ?? this.rentalDay,
      startRentalTime: startRentalTime ?? this.startRentalTime,
      endRentalTime: endRentalTime ?? this.endRentalTime,
      totalPrice: totalPrice ?? this.totalPrice,
      userBookingId: userBookingId ?? this.userBookingId,
      userBookingName: userBookingName ?? this.userBookingName,
      userBookingNoTlpn: userBookingNoTlpn ?? this.userBookingNoTlpn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': this.bookingId,
      'listCameraBooking': this.listCameraBooking,
      'rentalDay': this.rentalDay,
      'startRentalTime': this.startRentalTime,
      'endRentalTime': this.endRentalTime,
      'totalPrice': this.totalPrice,
      'userBookingId': this.userBookingId,
      'userBookingName': this.userBookingName,
      'userBookingNoTlpn': this.userBookingNoTlpn,
      'createdAt': this.createdAt,
      'status': this.status,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['bookingId'] as String,
      listCameraBooking: map['listCameraBooking'] as List<CameraBooking>,
      rentalDay: map['rentalDay'] as int,
      startRentalTime: map['startRentalTime'] as Timestamp,
      endRentalTime: map['endRentalTime'] as Timestamp,
      totalPrice: map['totalPrice'] as int,
      userBookingId: map['userBookingId'] as String,
      userBookingName: map['userBookingName'] as String,
      userBookingNoTlpn: map['userBookingNoTlpn'] as int,
      createdAt: map['createdAt'] as Timestamp,
      status: map['status'] as String,
    );
  }
}

class CameraBooking {
  final String cameraBookingId;
  final String title;
  final String subtitle;
  final String picture;
  final int quantity;
  final int price;

  CameraBooking({
    required this.cameraBookingId,
    required this.title,
    required this.subtitle,
    required this.picture,
    required this.quantity,
    required this.price,
  });

  factory CameraBooking.fromMap(Map<String, dynamic> map) => CameraBooking(
        cameraBookingId: map['camera_booking_id'],
        title: map['title'],
        subtitle: map['sub_title'],
        picture: map['picture'],
        quantity: map['quantity'],
        price: map['price'],
      );
}
