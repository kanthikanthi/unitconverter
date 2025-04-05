import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 15, 10, 147),
        ),
      ),
      home: const UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  double _inputValue = 0.0;
  double _convertedValue = 0.0;
  String _fromUnit = 'meter';
  String _toUnit = 'kilometer';

  final List<String> units = [
    'meter',
    'kilometer',
    'centimeter',
    'millimeter',
    'mile',
    'yard',
    'foot',
    'inch'
  ];

  LENGTH getLengthEnum(String unit) {
    switch (unit) {
      case 'meter':
        return LENGTH.meters;
      case 'kilometer':
        return LENGTH.kilometers;
      case 'centimeter':
        return LENGTH.centimeters;
      case 'millimeter':
        return LENGTH.millimeters;
      case 'mile':
        return LENGTH.miles;
      case 'yard':
        return LENGTH.yards;
      case 'foot':
        return LENGTH.feet;
      case 'inch':
        return LENGTH.inches;
      default:
        return LENGTH.meters;
    }
  }

  void _convert() {
    Length length = Length();
    length.convert(getLengthEnum(_fromUnit), _inputValue);
    setState(() {
      _convertedValue = length.getUnit(getLengthEnum(_toUnit))?.value ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter'),
      backgroundColor: Colors.blue,
      foregroundColor: const Color.fromARGB(235, 236, 239, 239),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromUnit,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
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
                ),
                const SizedBox(width: 12),
                const Icon(Icons.swap_horiz),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toUnit,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue $_toUnit',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}