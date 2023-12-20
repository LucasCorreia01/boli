import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:boli/main.dart' as app;

void main() {
  //Garante que o app irá rodar no emulador durante os testes
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'New account - Test',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Criar conta'), findsOneWidget);


      await tester.tap(find.text('Criar conta'));
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('Nova conta'), findsOneWidget);

      //Insere o nome do novo usuário.
      await tester.enterText(find.byType(TextFormField), 'Lucas Correia Damasceno');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Insere o e-mail do novo usuário
      await tester.enterText(find.byType(TextFormField), 'lucascorreiadamaceno@gmail.com');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Insere a senha do usuário
      await tester.enterText(find.byType(TextFormField), '12345678');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Data de nacimento do usuário
      await tester.enterText(find.byType(TextFormField), '29062006');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Desliza para abrir a conta nova do app
      await tester.drag(find.text('Deslize'), const Offset(50, 0));
      await tester.pumpAndSettle();


      //Vai até a abra de perfil 
      await tester.tap(find.byIcon(Icons.person_2_outlined));
      await tester.pumpAndSettle();

      //Encontra o nome da conta 
      expect(find.text('Lucas Correia Damasceno'), findsOneWidget);

    },
  );
}
