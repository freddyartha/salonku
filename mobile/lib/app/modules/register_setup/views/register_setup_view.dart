import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/register_setup_controller.dart';

class RegisterSetupView extends GetView<RegisterSetupController> {
  const RegisterSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "Registrasi Data ${controller.isOwner ? "Owner" : "Staff"}",
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            TextComponent(value: "Isi data diri kamu dulu ya..."),
            //TODO: Tambahkan kondisi view jika dia salon owner atau staff
            InputTextComponent(
              controller: controller.namaCon,
              placeHolder: "Masukkan nama kamu",
            ),
            InputTextComponent(
              controller: controller.telpCon,
              placeHolder: "Masukkan nomor HP kamu",
            ),
            InputTextComponent(
              controller: controller.nikCon,
              placeHolder: "Masukkan nomor ID Card kamu",
            ),
            InputRadioComponent(
              controller: controller.jenisKelaminCon,
              label: "Pilih Jenis Kelamin",
            ),
            InputDatetimeComponent(
              controller: controller.tanggalLahirCon,
              placeHolder: "Tanggal lahir kamu",
            ),
            InputTextComponent(
              controller: controller.alamatCon,
              placeHolder: "Masukkan alamat kamu",
            ),
          ],
        ),
      ),
    );
  }
}
