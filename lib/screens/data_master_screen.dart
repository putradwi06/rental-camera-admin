import 'package:flutter/material.dart';
import 'package:rental_camera_admin/models/users_model.dart';
import 'package:rental_camera_admin/repository/admin_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DataMasterScreen extends StatefulWidget {
  const DataMasterScreen({Key? key}) : super(key: key);

  @override
  State<DataMasterScreen> createState() => _DataMasterScreenState();
}

class _DataMasterScreenState extends State<DataMasterScreen> {
  late AdminRepository adminRepository;

  @override
  void initState() {
    adminRepository = AdminRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: adminRepository.getUsers(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final List<UserModel> listUsers = (snapshot.data ?? []);

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Master",
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
                            "User ID",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child: Text("Nama",
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child: Text("Email",
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child:
                            Text("Nomor Telp", overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        DataColumn(
                          label: Flexible(
                            child: Text("Status",
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        listUsers.length,
                            (index) => bookingDataRow(listUsers[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  DataRow bookingDataRow(UserModel userModel) {
    return DataRow(
      cells: [
        DataCell(Flexible(
            child: Text(userModel.id, overflow: TextOverflow.ellipsis))),
        DataCell(Flexible(
          child: Text(userModel.fullName,
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Flexible(
          child: Text(userModel.email,
              overflow: TextOverflow.ellipsis),
        )),
        DataCell(Flexible(
          child:
          Text(userModel.phoneNumber, overflow: TextOverflow.ellipsis),
        )),
        const DataCell(Flexible(
          child: Text("Aktif",
              overflow: TextOverflow.ellipsis),
        )),
      ],
    );
  }
}
