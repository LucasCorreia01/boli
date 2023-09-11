import 'package:flutter/material.dart';

import '../../../../components/icon_picker.dart';

class IconSaving extends StatefulWidget {
  const IconSaving({super.key});

  @override
  State<IconSaving> createState() => _IconSavingState();
}

class _IconSavingState extends State<IconSaving> {
  IconData? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Escolha um ícone para a poupança:',
              style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                final IconData? result = await showIconPicker(
                    context: context, defalutIcon: selectedIcon);
                setState(() {
                  selectedIcon = result;
                });
              },
              child: (selectedIcon != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ícone selecionado:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(selectedIcon),
                        )
                      ],
                    )
                  : const Text(
                      'Selecione um ícone',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
