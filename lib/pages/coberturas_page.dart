import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:diacritic/diacritic.dart';

class CoberturasPage extends StatefulWidget {
  @override
  _CoberturasPageState createState() => _CoberturasPageState();
}

class _CoberturasPageState extends State<CoberturasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _allProcedimientos = [];
  List<dynamic> _filteredProcedimientos = [];

  @override
  void initState() {
    super.initState();
    _loadProcedimientos();
  }

  Future<void> _loadProcedimientos() async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('assets/data/procedimientos_medicos.json');
    final jsonResponse = json.decode(jsonString);
    setState(() {
      _allProcedimientos = jsonResponse['procedimientos'];
      _filteredProcedimientos = []; // Inicialmente vacía
    });
  }

  void _filterProcedimientos(String query) {
    final normalizedQuery = removeDiacritics(query.toLowerCase());

    setState(() {
      _filteredProcedimientos = _allProcedimientos
          .where((proc) => removeDiacritics(proc['nombre'].toLowerCase()).contains(normalizedQuery))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coberturas'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar procedimiento médico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _filterProcedimientos(_searchController.text),
                  child: Text('Buscar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredProcedimientos.isEmpty
                ? Center(
              child: Text(
                'No se encontraron procedimientos',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
                : ListView.builder(
              itemCount: _filteredProcedimientos.length,
              itemBuilder: (context, index) {
                final proc = _filteredProcedimientos[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      proc['nombre'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('ID: ${proc['id']}'),
                    children: [
                      ListTile(
                        title: Text('Opción Fonasa', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Valor: \$${proc['valorFonasa']}'),
                        trailing: Text('Copago: \$${proc['valorBruto'] - proc['valorFonasa']}',
                        style: TextStyle(color: Colors.green),
                      ),
                 ),
                      ListTile(
                        title: Text('Opción Particular', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Valor: \$${proc['valorParticular']}'),
                        trailing: Text('Total con IVA: \$${proc['valorFinalConIVA']}',
                        style: TextStyle(color: Colors.green),
                      ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
