import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_api_banco_2709/aluno.dart';
import 'package:flutter_application_api_banco_2709/repository.dart';
import 'package:http/http.dart' as http;

class ListaAluno extends StatefulWidget {
  const ListaAluno({super.key});

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  Aluno al = Aluno();
  AlunoRepository alRepo = AlunoRepository();
  Future<void> fazerRequisicao() async{
    var url =Uri.parse('http://localhost:8080/apiAluno/todos');
    http.Response response = await http.get(url);
    if (response.statusCode==200){
      List listaAl = jsonDecode(response.body) as List;
      alRepo.listaAl = listaAl.map(
        (listaAl) => Aluno.fromJson(listaAl)).toList();
        setState(() {
          
        });
      
    }
    
  }
  @override
  Widget build(BuildContext context) {
    fazerRequisicao();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Listagem de alunos",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),),
        backgroundColor: const Color.fromARGB(255, 74, 185, 195),
      ),
      body: ListView.builder(
        itemCount:  alRepo.listaAl.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(alRepo.listaAl[index].nome.toString()),
            subtitle: Text(alRepo.listaAl[index].ra.toString()),
          );
        },
      )
    );

  }
}