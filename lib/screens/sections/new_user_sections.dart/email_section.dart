import 'package:flutter/material.dart';

class EmailSection extends StatelessWidget {
  const EmailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text(
                  'Digita aí o seu melhor e-mail, por favor.',
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                style: const TextStyle(fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  hintText: 'Email de contato',
                ),
              ),
            )),
          ],
        ),
      );
  }
}