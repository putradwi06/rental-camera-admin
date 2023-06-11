import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_camera_admin/models/booking_model.dart';
import 'package:rental_camera_admin/models/detail_camera_model.dart';

class AdminRepository {
  final FirebaseFirestore _firestore;

  static final AdminRepository _singleton = AdminRepository._internal();

  factory AdminRepository() => _singleton;

  AdminRepository._internal() : _firestore = FirebaseFirestore.instance;

  Stream<List<Booking>> getBookings() {
    final getBookings = _firestore.collection("Booking"); // Bookings

    return getBookings
        .snapshots()
        .map((documents) => documents.docs.map((document) {
              return Booking.fromMap(document.data());
            }).toList());
  }

  Future approvalCamera(Booking booking, bool isApprove) async {
    if (isApprove) {
      _firestore.collection("Booking").doc(booking.bookingId).update(
          booking.copyWith(status: "OnRental").toMap());
    } else {
      _firestore.collection("Booking").doc(booking.bookingId).delete();
    }
  }

  Future<int> postCamera(DetailCameraModel detailCameraModel) async {
    final cameraRef = _firestore.collection("Cameras");
    cameraRef.doc(cameraRef.id).set(detailCameraModel.copyWith(cameraId: cameraRef.id).toMap());
    return 1;
  }


}
