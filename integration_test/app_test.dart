import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icons_plus/icons_plus.dart';
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
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Lucas Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'lucascorreiadamaceno@gmail.com');
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

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Lucas Correia Damasceno'), findsOneWidget);
      },
    );

    // Sai do conta para criar outra
    testWidgets('Logout account', (tester) async {
      app.main();
      //Cria novo usuário
      {await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Criar conta'), findsOneWidget);

        await tester.tap(find.text('Criar conta'));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Lucas Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'lucascorreiadamaceno@gmail.com');
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

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Lucas Correia Damasceno'), findsOneWidget);}

      // Faz logout da conta atual
      await tester.tap(find.byIcon(Icons.exit_to_app));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      expect(find.text('Trocar de conta'), findsOneWidget);
    });
    
    //Cria duas contas no sistema
    testWidgets('Multiples accounts', (tester) async {
      app.main();

      //Cria o primeiro usuário do app
      {await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Criar conta'), findsOneWidget);

        await tester.tap(find.text('Criar conta'));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Lucas Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'lucascorreiadamaceno@gmail.com');
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

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Lucas Correia Damasceno'), findsOneWidget);}

      // Faz logout da conta atual
      await tester.tap(find.byIcon(Icons.exit_to_app));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));

      //Abre a tela de acessos
      await tester.tap(find.text('Trocar de conta'));
      await tester.pumpAndSettle();

      //Abre tela de novo usuário
      await tester.tap(find.text('ABRIR UMA NOVA CONTA'));
      await tester.pumpAndSettle();


      //Cria o segundo usuário do app
      {await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Leonardo Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'leonardocorreiadamaceno@gmail.com');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere a senha do usuário
        await tester.enterText(find.byType(TextFormField), '12345678');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Data de nacimento do usuário
        await tester.enterText(find.byType(TextFormField), '28072009');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Desliza para abrir a conta nova do app
        await tester.drag(find.text('Deslize'), const Offset(50, 0));
        await tester.pumpAndSettle();

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Leonardo Correia Damasceno'), findsOneWidget);
        }

      //Verifica os usuário existentes
      await tester.tap(find.text('Ver todas as contas'));
      await tester.pumpAndSettle();

      expect(find.text('Lucas Correia Damasceno'), findsOneWidget);
      expect(find.text('Leonardo Correia Damasceno'), findsWidgets);
    });


  testWidgets('Make Transfer', (tester) async{
    app.main();

      //Cria o primeiro usuário do app
      {await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
        
        await tester.pumpAndSettle();
        expect(find.text('Criar conta'), findsOneWidget);

        await tester.tap(find.text('Criar conta'));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Lucas Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'lucascorreiadamaceno@gmail.com');
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

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Lucas Correia Damasceno'), findsOneWidget);}

      // Faz logout da conta atual
      await tester.tap(find.byIcon(Icons.exit_to_app));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));

      //Abre a tela de acessos
      await tester.tap(find.text('Trocar de conta'));
      await tester.pumpAndSettle();

      //Abre tela de novo usuário
      await tester.tap(find.text('ABRIR UMA NOVA CONTA'));
      await tester.pumpAndSettle();


      //Cria o segundo usuário do app
      {await tester.pumpAndSettle();
        expect(find.text('Nova conta'), findsOneWidget);

        //Insere o nome do novo usuário.
        await tester.enterText(
            find.byType(TextFormField), 'Leonardo Correia Damasceno');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere o e-mail do novo usuário
        await tester.enterText(
            find.byType(TextFormField), 'leonardocorreiadamaceno@gmail.com');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Insere a senha do usuário
        await tester.enterText(find.byType(TextFormField), '12345678');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Data de nacimento do usuário
        await tester.enterText(find.byType(TextFormField), '28072009');
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        //Desliza para abrir a conta nova do app
        await tester.drag(find.text('Deslize'), const Offset(50, 0));
        await tester.pumpAndSettle();

        //Vai até a aba de perfil
        await tester.tap(find.byIcon(Icons.person_2_outlined));
        await tester.pumpAndSettle();

        //Encontra o nome da conta
        expect(find.text('Leonardo Correia Damasceno'), findsOneWidget);
        }

      //Volta para tela inicial
      await tester.tap(find.byIcon(BoxIcons.bx_home));
      await tester.pumpAndSettle();

      //Abre tela de receber
      await tester.tap(find.text('Receber'));
      await tester.pumpAndSettle();

      //Digita o valor
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.byType(FloatingActionButton));

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(find.text('R\$100.00'), findsWidgets);

      //Abre tela de transferência
      await tester.tap(find.text('Enviar'));
      await tester.enterText(find.byType(FloatingActionButton), '50');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Seleciona o usuário
      await tester.tap(find.text('Lucas Correia Damasceno'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Voltar'));
      await tester.pumpAndSettle();

      expect(find.text('R\$50.00'), findsWidgets);
  });
    
}
