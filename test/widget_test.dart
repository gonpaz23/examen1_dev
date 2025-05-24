import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:examen1_dev/main.dart';

void main() {
  testWidgets('Prueba de interfaz de calculadora', (WidgetTester tester) async {
    await tester.pumpWidget(CalculadoraApp());

    // Verificar que la interfaz se muestra
    expect(find.text('Calculadora Avanzada'), findsOneWidget);
    expect(find.text('Suma'), findsOneWidget);
    expect(find.text('Resta'), findsOneWidget);

    // Probar interacción con el botón de suma
    await tester.tap(find.text('Suma'));
    await tester.pumpAndSettle(); // Espera a que aparezca el diálogo

    // Verificar que el diálogo aparece
    expect(find.text('Suma'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}