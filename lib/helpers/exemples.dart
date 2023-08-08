import 'package:boli/models/cardCreditItemModel.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

List<CardCredit> getCardExemples() {
  return [
    CardCredit(
      balanceCard: '32,003,000',
      cardNumber: '0298 6652 9142 7348',
      cvv: '582',
      dueDate: '12/26',
      colorCard: const Color.fromRGBO(255, 213, 65, 1),
      colorText: const Color.fromRGBO(43, 43, 63, 1),
      iconCard: BoxIcons.bxl_visa,
      nameCard: 'MasterCard',
      imageLogo: 'assets/images/mastercard-logo.png',
    ),
    CardCredit(
      balanceCard: '20,000,000',
      cardNumber: '5376 8371 0923 0921',
      cvv: '097',
      dueDate: '12/23',
      colorCard: const Color.fromRGBO(100, 106, 226, 1),
      colorText: Colors.white,
      iconCard: BoxIcons.bxl_visa,
      nameCard: 'Visa',
      imageLogo: 'assets/images/visa-logo.png',
    ),
    CardCredit(
      balanceCard: '8,450,000',
      cardNumber: '0495 8381 9303 1234',
      cvv: '017',
      dueDate: '12/24',
      colorCard: const Color.fromRGBO(27, 27, 27, 1),
      colorText: Colors.white,
      iconCard: BoxIcons.bxl_visa,
      nameCard: 'BBVA',
      imageLogo: 'assets/images/visa-logo.png',
    ),
  ];
}

List<Map<String, String>> getListItensIncoces() {
  return const [
    {"date": '12 Jan 2023', 'title': 'Conta de água', 'value': '110'},
    {"date": '13 Fev 2023', 'title': 'Netflix', 'value': '55'},
    {"date": '15 Fev 2023', 'title': 'Conta de telefone', 'value': '20'},
    {"date": '18 Fev 2023', 'title': 'Conta de energia', 'value': '300'},
    {"date": '19 Fev 2023', 'title': 'Manutenção do carro', 'value': '400'},
  ];
}

List<Map<String, String>> getListItensNotifications() {
  return const [
    {
      "title": "Pedências de confirmação",
      "content": "Clique para consultar suas pedências"
    },
    {
      "title": "Ofertas personalizadas",
      "content": "Você tem ofertas escolhidas para você"
    },
    {"title": "Avisos", "content": "Não compartilhe sua senha com estranhos!"},
    {
      "title": "Compras",
      "content":
          "Identificamos uma nova compra no MasterCard final 7863, deseja adicionar ao app?"
    },
    {
      "title": "Agendamentos",
      "content":
          "Deseja agendar um atendimento? Aqui você encontra atedimentos personalidados e feitos sobre medida para você!"
    },
    {
      "title": "Vencimentos",
      "content": "Seu cartão está próximo de vercer. Cuidado! Nâo pague juros."
    },
  ];
}

List<Map<String, String>> getListUsersSaved() {
  return const [
    {
      "name": "Lucas Damasceno",
      "abbreviation": 'Lu',
    },
    {
      "name": "Leonardo Damasceno",
      "abbreviation": 'Le',
    },
    {
      "name": "Claudia Damasceno",
      "abbreviation": 'Cl',
    }
  ];
}
