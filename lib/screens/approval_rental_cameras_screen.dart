import 'package:flutter/material.dart';
import 'package:rental_camera_admin/repository/admin_repository.dart';
import 'package:rental_camera_admin/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/booking_model.dart';

class ApprovalRentalCamerasScreen extends StatefulWidget {
  const ApprovalRentalCamerasScreen({Key? key}) : super(key: key);

  @override
  State<ApprovalRentalCamerasScreen> createState() =>
      _ApprovalRentalCamerasScreenState();
}

class _ApprovalRentalCamerasScreenState
    extends State<ApprovalRentalCamerasScreen> {
  late AdminRepository adminRepository;

  @override
  void initState() {
    adminRepository = AdminRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: adminRepository.getBookings(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final List<Booking> listCamera = snapshot.data?.where((element) => element.status == "Pending").toList() ?? [];
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Approval Rental Cameras",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: 12,
                    sortAscending: true,
                    dataRowHeight: 18.h,
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Booking ID",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text("Rentail Day",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text("Total Price",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text("Camera Booking",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text("Bukti Transfer",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                            child: Text("Action",
                                overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                    rows: List.generate(
                      listCamera.length,
                      (index) => bookingDataRow(listCamera[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  DataRow bookingDataRow(Booking booking) {
    return DataRow(
      cells: [
        DataCell(Flexible(
            child: Text(booking.bookingId, overflow: TextOverflow.ellipsis))),
        DataCell(Flexible(
          child: Text(booking.rentalDay.toString(),
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Flexible(
          child: Text(booking.totalPrice.toString(),
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    booking.cameraBooking.picture,
                    width: 10.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(booking.cameraBooking.title, overflow: TextOverflow.ellipsis),
                Text(
                  "Quantity: ${booking.cameraBooking.quantity.toString()}",
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )),
        DataCell(Flexible(
          child:ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              booking.buktiTransfer,
              width: 10.w,
              height: 10.h,
              fit: BoxFit.cover,
            ),
          ),
        )),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                adminRepository.approvalCamera(booking, false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kRedBgColor,
                fixedSize: Size(80, 25),
              ),
              child: const Text("Batal"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                adminRepository.approvalCamera(booking, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreenBgColor,
                fixedSize: Size(80, 25),
              ),
              child: const Text("Terima"),
            ),
          ],
        )),
      ],
    );
  }
}
