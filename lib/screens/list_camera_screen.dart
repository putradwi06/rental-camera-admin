import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_camera_admin/models/booking_model.dart';
import 'package:rental_camera_admin/repository/admin_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles.dart';

class ListCameraScreen extends StatefulWidget {
  const ListCameraScreen({Key? key}) : super(key: key);

  @override
  State<ListCameraScreen> createState() => _ListCameraScreenState();
}

class _ListCameraScreenState extends State<ListCameraScreen> {
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
          final List<Booking> listCamera = snapshot.data?.where((element) => element.status != "Pending").toList() ?? [];
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
                  "List Camera On Rental",
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
                          child: Text("Status",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Text("Waktu Berakhir",
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
          child: Text(booking.status.toString(),
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Flexible(
          child: Text(getDateParse(booking.endRentalTime!.toDate().toString(), 'EEEE, dd MMMM yyyy'),
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Padding(
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
              const SizedBox(height: 4),
              Text(booking.cameraBooking.title, overflow: TextOverflow.ellipsis),
              Text(
                "Quantity: ${booking.cameraBooking.quantity.toString()}",
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                whatsappShare(booking.userBookingNoTlpn.toString());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kRedBgColor,
                fixedSize: Size(100, 25),
              ),
              child: const Text("Hubungi"),
            ),
            const SizedBox(height: 10),
            if(booking.status != "Completed")
    ElevatedButton(
              onPressed: () {
               AdminRepository().completedRental(booking);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreenBgColor,
                fixedSize: Size(100, 25),
              ),
              child: const Text("Selesai"),
            ),
          ],
        )),
      ],
    );
  }
  String getDateParse(String parse, String formatDate) {
    final dateTime = DateTime.parse(parse);

    // print('dateParse: ${dateTime.toString()}');
    // print('isValidDate: ${isValidDateOnly(parse)}');

    final format = DateFormat(formatDate, "id");
    final clockString = format.format(dateTime);
    return clockString;
  }

  Future<void> whatsappShare(String number) async {
    var url = Uri.parse("https://wa.me/$number");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

}
