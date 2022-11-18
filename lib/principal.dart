import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // text fields' controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _reservaController = TextEditingController();

  final CollectionReference _Clientes =
      FirebaseFirestore.instance.collection('Clientes');
//insertar producto
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'apellido'),
                ),                
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cedulaController,
                  decoration: const InputDecoration(
                    labelText: 'cedula',
                  ),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(labelText: 'Sexo (M o F)'),
                ),
                TextField(
                  controller: _fechaController,
                  decoration: const InputDecoration(labelText: 'Fecha de nacimiento (dd/mm/aa)'),
                ),                
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo (Estudiante,empleado, desempleado)'),
                ),
                TextField(
                  controller: _reservaController,
                  decoration: const InputDecoration(labelText: 'Reserva'),
                ),                                                                
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String usuario = _usuarioController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nac= _fechaController.text;
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String reserva = _reservaController.text;
                    final int? cedula =
                        int.tryParse(_cedulaController.text);
                    if (cedula != null) {
                      await _Clientes
                          .add({"nombre": nombre, "cedula": cedula, "usuario": usuario, "apellido": apellido, 
                          "fecha_nac": fecha_nac, "tipo": tipo, "reserva": reserva, "sexo": sexo});
                      _nombreController.text = '';
                      _cedulaController.text = '';
                      _usuarioController.text = '';
                      _apellidoController.text = '';
                      _fechaController.text = '';
                      _tipoController.text = '';
                      _sexoController.text = '';
                      _reservaController.text = '';                      
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
//actualizar poducto

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();                  
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _fechaController.text = documentSnapshot['fecha_nac'].toString();
      _reservaController.text = documentSnapshot['cedula'].toString();
      
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'apellido'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cedulaController,
                  decoration: const InputDecoration(labelText: 'cedula',),
                ),
                  TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(labelText: 'sexo (M o F)'),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(labelText: 'tipo (Estudiante,empleado, desempleado)'),
                ),
                TextField(
                  controller: _fechaController,
                  decoration: const InputDecoration(labelText: 'fecha nacimiento (dd/mm/aa)'),
                ),                                                
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Actualizar'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String usuario = _usuarioController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nac= _fechaController.text;
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String reserva = _reservaController.text;
                    final int? cedula =
                        int.tryParse(_cedulaController.text);
                    if (cedula != null) {
                      await _Clientes
                          .doc(documentSnapshot!.id)
                          .update({"nombre": nombre, "cedula": cedula, "usuario": usuario, "apellido": apellido, 
                          "fecha_nac": fecha_nac, "tipo": tipo, "reserva": reserva, "sexo": sexo});
                      _nombreController.text = '';
                      _cedulaController.text = '';
                      _usuarioController.text = '';
                      _apellidoController.text = '';
                      _fechaController.text = '';
                      _tipoController.text = '';
                      _sexoController.text = '';
                      _reservaController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar productos
  Future<void> _delete(String ClientId) async {
    await _Clientes.doc(ClientId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El Cliente fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Usuarios')),
        ),
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage (image: NetworkImage("https://i.pinimg.com/564x/7d/f0/8a/7df08aa36f475c33fa680bc4d790de9b.jpg"), 
          fit: BoxFit.cover)
          ),
          child: StreamBuilder(
            stream: _Clientes.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Nombre: "+documentSnapshot['nombre'].toString()+" "+documentSnapshot['apellido'].toString()),
                        subtitle: Text("No. Documento: "+documentSnapshot['cedula'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _delete(documentSnapshot.id)),
                            ],
                          ),
                        ),
                      ),
                    );              
                  },                
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
// agregar productos
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _create(),
          label: const Text('Agregar'),
        icon: const Icon(Icons.add_card),
        backgroundColor: Color.fromARGB(255, 99, 102, 99),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
