import 'dart:io';
import 'dart:typed_data';
import 'package:boli/screens/transfer_voucher/receiver_section.dart';
import 'package:boli/screens/transfer_voucher/send_section.dart';
import 'package:boli/screens/transfer_voucher/voucher_header_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class TransferVoucherScreen extends StatefulWidget {
  final String userSend;
  final String userReceiver;
  final String valueToTransfer;
  final DateTime date;
  const TransferVoucherScreen(
      {required this.userReceiver,
      required this.userSend,
      required this.valueToTransfer,
      required this.date,
      super.key});

  @override
  State<TransferVoucherScreen> createState() => _TransferVoucherScreenState();
}

class _TransferVoucherScreenState extends State<TransferVoucherScreen> {
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: () async{
              final image = await controller.capture();
              if(image == null) return;

              await saveImage(image);
              saveAndShare(image);
            }, icon: const Icon(BoxIcons.bx_share_alt))
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: VoucherHeaderSection(widget.valueToTransfer, widget.date),
            ),
            SliverToBoxAdapter(
              child: ReceiverSection(widget.userReceiver),
            ),
            SliverToBoxAdapter(
              child: SendSectionVoucher(widget.userSend),
            ),
          ],
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path]);
  }

  Future<String> saveImage(Uint8List bytes) async {
     await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = 'screenShot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    
    return result['filePath'];
  }
}
