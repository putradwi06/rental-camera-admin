import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rental_camera_admin/models/detail_camera_model.dart';
import 'package:rental_camera_admin/repository/admin_repository.dart';
import 'package:rental_camera_admin/screens/dashboard_screen.dart';
import 'package:rental_camera_admin/utils/image_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../styles.dart';

class AddPostCameraScreen extends StatefulWidget {
  const AddPostCameraScreen({Key? key}) : super(key: key);

  @override
  State<AddPostCameraScreen> createState() => _AddPostCameraScreenState();
}

class _AddPostCameraScreenState extends State<AddPostCameraScreen> {
  String? _imagePath;
  PlatformFile? imageFile;
  late AdminRepository adminRepository;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController cameraTypeController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    adminRepository = AdminRepository();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFfffff),
      body: LoadingOverlay(
        isLoading: isLoading,
        color: const Color(0xFFFfffff),
        opacity: 0.7,
        progressIndicator: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      "Buat Postingan",
                      style: blackTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  style: blackTextStyle,
                  decoration: InputDecoration(
                    hintText: "Judul",
                    hintStyle: greyTextStyle,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: subTitleController,
                  style: blackTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Sub Title",
                    hintStyle: greyTextStyle,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: descriptionController,
                  style: blackTextStyle,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 10,
                  onTap: () {},
                  decoration: InputDecoration(
                      hintText: "Deskripsi", hintStyle: greyTextStyle),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: stockController,
                  style: blackTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Stok",
                    hintStyle: greyTextStyle,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: priceController,
                  style: blackTextStyle,
                  decoration: InputDecoration(
                      hintText: "Harga", hintStyle: greyTextStyle),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: cameraTypeController,
                  style: blackTextStyle,
                  decoration: InputDecoration(
                      hintText: "Camera Type", hintStyle: greyTextStyle),
                ),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFA5A5A5)))),
                  child: Row(
                    children: [
                      Text(
                        _imagePath == null ? "Tambahkan gambar" : _imagePath!,
                        style:
                            _imagePath == null ? greyTextStyle : blackTextStyle,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          var picked = await FilePicker.platform.pickFiles();
                          if (picked != null) {
                            imageFile = picked.files.first;
                            setState(
                                () => _imagePath = picked.files.first.name);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: const Color(0xFFA5A5A5)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: Text(
                            'Pilih Gambar',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: kGreyHintColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: Size(35.w, 7.h)),
                      child: const Text("Buat Post"),
                      onPressed: () async {
                        final imagePath =
                            await FirebaseStorageHelper.uploadImageNews(
                                imageFile!);

                        final detailCameraModel = DetailCameraModel(
                          cameraId: null,
                          title: titleController.text,
                          subTitle: subTitleController.text,
                          description: descriptionController.text,
                          type: cameraTypeController.text,
                          picture: imagePath,
                          stock: int.parse(stockController.text),
                          price: int.parse(priceController.text),
                        );

                        final result = await adminRepository.postCamera(detailCameraModel);
                        if (result == 1) {
                          titleController.clear();
                          subTitleController.clear();
                          descriptionController.clear();
                          cameraTypeController.clear();
                          stockController.clear();
                          priceController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
