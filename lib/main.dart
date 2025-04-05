import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blueGrey,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 15, 184)),


      ),
      home : const UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}
 

class _UnitConverterScreenState extends State<UnitConverterScreen>  {
  double _inputValue = 0.0;
  double _convertedValue = 0.0;
  String _fromUnit = 'meter';
  String _toUnit = 'kilometer';

  final List<String> units = [
    'meter', 'kilometer', 'centimeter', 'millimeter', 'mile', 'yard', 'foot', 'inch'
  ]; 
  void _convert() {
    setState(() {
      _convertedValue = UnitsConverter.convert(
        _inputValue, 
        fromUnit: _fromUnit, 
        toUnit: _toUnit
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Enter value'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: units.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                      _convert();
                    });
                  },
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toUnit,
                  items: units.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                      _convert();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue $_toUnit',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}