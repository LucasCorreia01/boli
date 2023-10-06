import 'package:boli/screens/transfer_voucher/receiver_section.dart';
import 'package:boli/screens/transfer_voucher/send_section.dart';
import 'package:boli/screens/transfer_voucher/voucher_header_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TransferVoucherScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_share_alt))
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: VoucherHeaderSection(valueToTransfer, date),
          ),
          SliverToBoxAdapter(
            child: ReceiverSection(userReceiver),
          ),
          SliverToBoxAdapter(
            child: SendSectionVoucher(userSend),
          ),
        ],
      ),
    );
  }
}
