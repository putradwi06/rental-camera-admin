import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_camera_admin/models/booking_model.dart';
import 'package:rental_camera_admin/models/detail_camera_model.dart';

import '../models/users_model.dart';

class AdminRepository {
  final FirebaseFirestore _firestore;

  static final AdminRepository _singleton = AdminRepository._internal();

  factory AdminRepository() => _singleton;

  AdminRepository._internal() : _firestore = FirebaseFirestore.instance;

  Stream<List<Booking>> getBookings() {
    final getBookings = _firestore.collection("Booking").orderBy('created_at', descending: true); // Bookings

    return getBookings.snapshots().map((documents) {
      final data = documents.docs.map((document) {
        return Booking.fromMap(document.data());
      }).toList();

      return data;
    });
  }

  Stream<List<UserModel>> getUsers() {
    final getUsers = _firestore.collection("Users"); // Bookings

    return getUsers.snapshots().map((documents) {
      final data = documents.docs.map((document) {
        return UserModel.fromMap(document.data());
      }).toList();

      return data;
    });
  }

  Future approvalCamera(Booking booking, bool isApprove) async {
    if (isApprove) {
      final cameraRef = await _firestore
          .collection("Cameras")
          .doc(booking.cameraBooking.cameraId)
          .get();

      final stockCamera = CameraModel.fromMap(cameraRef.data()!);

      Timestamp currentTime = Timestamp.now();
      int daysInSecond = booking.rentalDay * 24 * 60 * 60;
      int futureTimeInSeconds = currentTime.seconds + daysInSecond;
      Timestamp futureTimestamp = Timestamp(futureTimeInSeconds, 0);

      final newBooking = booking.copyWith(status: "OnRental",
            startRentalTime: Timestamp.now(), endRentalTime: futureTimestamp);

      _firestore
          .collection("Cameras")
          .doc(booking.cameraBooking.cameraId)
          .update(booking.cameraBooking.copyWith(stock: stockCamera.stock - booking.cameraBooking.quantity!).toMap());

      _firestore
          .collection("Booking")
          .doc(booking.bookingId)
          .update(newBooking.toMap());
    } else {
      _firestore.collection("Booking").doc(booking.bookingId).delete();
    }
  }

  Future<void> completedRental(Booking booking) async {
    await _firestore
        .collection("Booking")
        .doc(booking.bookingId)
        .update(booking.copyWith(status: "Completed").toMap());

    final cameraRef = await _firestore
        .collection("Cameras")
        .doc(booking.cameraBooking.cameraId)
        .get();

    final stockCamera = CameraModel.fromMap(cameraRef.data()!);

    await _firestore
        .collection("Cameras")
        .doc(booking.cameraBooking.cameraId)
        .update(booking.cameraBooking.copyWith(stock: stockCamera.stock + booking.cameraBooking.quantity!).toMap());
  }

  Future<int> postCamera(DetailCameraModel detailCameraModel) async {
    final cameraId = _firestore.collection("Cameras").doc().id;

    await _firestore
        .collection("Cameras")
        .doc(cameraId)
        .set(detailCameraModel.copyWith(cameraId: cameraId).toMap());
    return 1;
  }
}
