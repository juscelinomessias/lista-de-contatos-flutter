import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_contatos/dao/ContatoDAO.dart';
import 'package:lista_de_contatos/modelos/Contato.dart';
import 'package:lista_de_contatos/paginas/home_contatos.dart';

class DeletarContato extends StatefulWidget {
  const DeletarContato({Key? key}) : super(key: key);

  @override
  _DeletarContatoState createState() => _DeletarContatoState();
}

class _DeletarContatoState extends State<DeletarContato> {
  // acessar banco de dados
  final ContatoDAO _db = ContatoDAO();

  // criar lista com dados recuperados
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    _recuperarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: const Color(0xFF332c66),
        title: const Text("Deletar Contato",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff51489a),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: _contatos.length,
                    itemBuilder: (context, index) {
                      final contato = _contatos[index];

                      // verifica se existe uma imagem, caso não exista é adicionado uma padrão
                      final avatar = contato.urlImagem != null
                          ? CircleAvatar(
                              radius: 26,
                              backgroundColor: const Color(0xFFffffff),
                              child: CircleAvatar(
                                radius: 29,
                                child: ClipOval(
                                  child: Image.file(
                                    File((contato.urlImagem)),
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            );
                      return Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 5, 10, 5),
                          leading: avatar,
                          title: Text(
                            contato.nome!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _alertaDeConfirmacao(contato.id!);
                                },
                                icon: const Icon(Icons.delete_outlined,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
            Container(
                height: 65,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFffffff)))),
                child: GestureDetector(
                  child: Container(
                    height: 65.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Menu Principal",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeContatos()));
                  },
                ))
          ],
        ),
      ),
    );
  }

  // alerta de confimação para deletar item
  _alertaDeConfirmacao(dynamic id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Excluir",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: -90,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 60,
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  )
                ]),
            content: const Text(
              "Deseja excluir o Contato?",
              style: TextStyle(color: Colors.black, fontSize: 17),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _removerContato(id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      "Sim",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      "Não",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }

  // recupera informações do banco de dados
  _recuperarContatos() async {
    List contatosRecuperados = await _db.recuperarContato();
    List<Contato> listaTemporaria = [];

    for (var item in contatosRecuperados) {
      Contato contato = Contato.fromMap(item);
      listaTemporaria.add(contato);
    }

    setState(() {
      _contatos = listaTemporaria;
    });

    print("Lista contatos: " + contatosRecuperados.toString());
  }

  // deletar informaçao no banco de dados
  _removerContato(dynamic id) async {
    await _db.removerContato(id);
    _recuperarContatos();

    // Remove o SnackBar caso esteja aberto
    ScaffoldMessenger.of(context).clearSnackBars();

    // Exibe uma mensagem quando o Contato é excluído
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "Contato excluído com sucesso!",
            style: TextStyle(
              color: Color(0xFFffffff),
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF332c66),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
