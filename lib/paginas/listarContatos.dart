import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/dao/ContatoDAO.dart';
import 'package:lista_de_contatos/modelos/Contato.dart';
import 'package:lista_de_contatos/paginas/atualizarContato.dart';

class ListarContatos extends StatefulWidget {
  const ListarContatos({Key? key}) : super(key: key);

  @override
  _ListarContatosState createState() => _ListarContatosState();
}

class _ListarContatosState extends State<ListarContatos> {
  // acessar banco de dados
  final ContatoDAO _db = ContatoDAO();

  // criar lista com dados recuperados
  List<Contato> _listaContatos = [];

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
        title: const Text("Listar Contatos",
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
                    itemCount: _listaContatos.length,
                    itemBuilder: (context, index) {
                      final contato = _listaContatos[index];

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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AtualizarContato(),
                                      // passando argumentos para outra tela
                                      settings: RouteSettings(
                                        arguments: _listaContatos[index],
                                      ),
                                    ),
                                  ).then(onGoBack);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFFf29500),
                                ),
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
                    Navigator.pop(context);
                  },
                ))
          ],
        ),
      ),
    );
  }

  _recuperarContatos() async {
    List contatosRecuperados = await _db.recuperarContato();
    List<Contato> listaTemporaria = [];

    for (var item in contatosRecuperados) {
      Contato contato = Contato.fromMap(item);
      listaTemporaria.add(contato);
    }

    setState(() {
      _listaContatos = listaTemporaria;
    });

    print("Lista contatos: " + contatosRecuperados.toString());
  }

  // atualiza a tela com a lista de contatos após edição
  onGoBack(dynamic value) {
    setState(() {
      _recuperarContatos();
    });
  }
}
