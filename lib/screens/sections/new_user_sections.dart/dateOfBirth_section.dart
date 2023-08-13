import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../models/user.dart';

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({super.key});

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController date = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd/MM/yyyy');
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Qual a sua data de nascimento?',
              style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible),
            ),
          ),
        ),
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24),
        //     child: SingleChildScrollView(
        //       child: DateTimeField(
        //         controller: date,
        //         validator: (value) {
        //           if (toBeOfAgeTwelve(value)) {
        //             return null;
        //           }
        //           return 'Verifique a data insirida.\nVocê precisa ter pelo menos 12 para ter uma conta.';
        //         },
        //         decoration: const InputDecoration(hintText: 'xx/xx/xxx'),
        //         format: format,
        //         onChanged: (value) {
        //           User.addAttr("dateOfBirth", "$value");
        //         },
        //         onShowPicker: (context, currentValue) async {
        //           final date = showDatePicker(
        //             locale: const Locale('pt'),
        //             useRootNavigator: false,
        //             context: context,
        //             initialDate: currentValue ?? DateTime.now(),
        //             firstDate: DateTime(1900),
        //             lastDate: DateTime(2100),
        //           );

        //           return date;
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'xx/xx/xxxx'),
                controller: date,
                onChanged: (value) {
                  User.addAttr("dateOfBirth", value);
                },
                inputFormatters: [maskFormatter],
              )),
        )
      ],
    );
  }

  bool toBeOfAgeTwelve(DateTime? value) {
    if (value != null) {
      DateTime twelve = DateTime.now();
      twelve = twelve.subtract(const Duration(days: 4380));
      if (value.isAfter(twelve)) {
        // print('Você precisa ter 12 anos para fazer uma conta');
        return false;
      }
      return true;
    }
    return false;
  }
}
