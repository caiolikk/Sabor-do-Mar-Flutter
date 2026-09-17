import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabor_do_mar/main.dart';

void main() {
  testWidgets('Carrinho soma, remove e conclui', (tester) async {
    tester.view.physicalSize = const Size(1000, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const Principal());
    await tester.pumpAndSettle();
    await tester.tap(find.text('PEDIR AGORA'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Carrinho (1 itens)'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Adicionar Temaki Salmão'));
    await tester.pumpAndSettle();
    expect(find.text('R\$ 49,80'), findsNWidgets(2));
    await tester.tap(find.byTooltip('Remover Temaki Salmão'));
    await tester.pumpAndSettle();
    expect(find.text('R\$ 49,80'), findsNothing);
    await tester.tap(find.text('Concluir demonstração'));
    await tester.pumpAndSettle();
    expect(find.text('Pedido demonstrativo concluído!'), findsOneWidget);
    await tester.tap(find.text('Voltar ao cardápio'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Carrinho (0 itens)'));
    await tester.pumpAndSettle();
    expect(find.text('Seu carrinho está vazio.\nEscolha seu temaki favorito!'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Cartão abre detalhes e adiciona o produto correto',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const Principal());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Temaki Camarão'));
    await tester.tap(find.text('Temaki Camarão'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adicionar ao carrinho'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Carrinho (1 itens)'));
    await tester.pumpAndSettle();
    expect(find.text('R\$ 29,90'), findsWidgets);
    await tester.tap(find.byTooltip('Remover Temaki Camarão'));
    await tester.pumpAndSettle();
    expect(find.text('Seu carrinho está vazio.\nEscolha seu temaki favorito!'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final largura in [320.0, 390.0, 768.0, 1024.0]) {
    testWidgets('Layout sem overflow em largura $largura', (tester) async {
      tester.view.physicalSize = Size(largura, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const Principal());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (var i = 0; i < 5; i++) {
        await tester.drag(find.byType(ListView).first, const Offset(0, -450));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  }
}
