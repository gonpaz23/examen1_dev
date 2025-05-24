
import 'package:flutter/material.dart';
import 'operaciones_basicas';
import 'numeros_primos';
import 'pares_impares';
import 'fibonacci';
import 'areas_geometricas';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Avanzada',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuCalculadora(),
    );
  }
}

class MenuCalculadora extends StatefulWidget {
  @override
  _MenuCalculadoraState createState() => _MenuCalculadoraState();
}

class _MenuCalculadoraState extends State<MenuCalculadora> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora Avanzada')),
      body: ListView(
        children: [
          _buildBoton('Suma', Icons.add, Colors.blue, () {
            _mostrarDialogoOperacion(context, 'Suma', realizarSuma);
          }),
          _buildBoton('Resta', Icons.remove, Colors.red, () {
            _mostrarDialogoOperacion(context, 'Resta', realizarResta);
          }),
          _buildBoton('Division', Icons.filter, Colors.grey, () {
            _mostrarDialogoOperacion(context, 'Division', realizarDivision);
          }),
          _buildBoton('Multiplicacion', Icons.filter_1, Colors.teal, () {
            _mostrarDialogoOperacion(context, 'Multiplicacion', realizarMultiplicacion);
          }),
          _buildBoton('Pares e Impares', Icons.filter_2, Colors.black, () {
            _mostrarDialogoOperacion(context, 'Pares e Impares', mostrarParesImpares);
          }),
          _buildBoton('Fibonacci', Icons.filter_3, Colors.purple, () {
            _mostrarDialogoOperacion(context, 'Fibonacci', mostrarFibonacci);
          }),
          _buildBoton('Números Primos', Icons.filter_4, Colors.green, () {
            _mostrarPrimos(context);
          }),
          _buildBoton('Area Circulo', Icons.circle, Colors.orange, () {
            _mostrarDialogoOperacion(context, 'Area Circulo', calcularAreaCirculo);
          }),
          _buildBoton('Area Rectangulo', Icons.rectangle, Colors.orange, () {
            _mostrarDialogoOperacion(context, 'Area Rectangulo', calcularAreaRectangulo);
          }),
          _buildBoton('Area Triangulo', Icons.train, Colors.orange, () {
            _mostrarDialogoOperacion(context, 'Area Triangulo', calcularAreaTriangulo);
          }),
          _buildBoton('Area Cuadrado', Icons.square, Colors.orange, () {
            _mostrarDialogoOperacion(context, 'Area Cuadrado', calcularAreaCuadrado);
          }),
        ],
      ),
    );
  }

  Widget _buildBoton(String texto, IconData icono, Color color, Function() onPressed) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icono, color: color),
        title: Text(texto),
        onTap: onPressed,
      ),
    );
  }

  void _mostrarDialogoOperacion(BuildContext context, String titulo, Function operacion) {
    final controller1 = TextEditingController();
    final controller2 = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controller1, keyboardType: TextInputType.number),
            TextField(controller: controller2, keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Calcular'),
            onPressed: () {
              final num1 = double.parse(controller1.text);
              final num2 = double.parse(controller2.text);
              final resultado = operacion(num1, num2);
              Navigator.pop(context);
              _mostrarResultado(context, '$num1 ${titulo.toLowerCase()} $num2 = $resultado');
            },
          ),
        ],
      ),
    );
  }

  void _mostrarPrimos(BuildContext context) {
    final controllerInicio = TextEditingController();
    final controllerFin = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Números Primos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerInicio, decoration: InputDecoration(hintText: 'Inicio')),
            TextField(controller: controllerFin, decoration: InputDecoration(hintText: 'Fin')),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Buscar'),
            onPressed: () {
              final inicio = int.parse(controllerInicio.text);
              final fin = int.parse(controllerFin.text);
              final primos = <int>[];
  for (int i = inicio; i <= fin; i++) {
    if (esPrimo(i)) primos.add(i);
  }
              Navigator.pop(context);
              _mostrarResultado(context, 'Primos encontrados: ${primos.join(', ')}');
            },
          ),
        ],
      ),
    );
  }

  void _mostrarResultado(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: Duration(seconds: 5)));
  }
}