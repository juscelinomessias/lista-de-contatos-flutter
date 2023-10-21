import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_contatos/paginas/criarContato.dart';
import 'package:lista_de_contatos/paginas/deletarContato.dart';
import 'package:lista_de_contatos/paginas/listarContatos.dart';

class HomeContatos extends StatefulWidget {
  const HomeContatos({Key? key}) : super(key: key);

  @override
  _HomeContatosState createState() => _HomeContatosState();
}

class _HomeContatosState extends State<HomeContatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: const Color(0xFF332c66),
        title: const Text("Lista de Contatos",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 8,
                          child: Image.asset(
                            "lib/imagens/contatos.png",
                            height: 400,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: 140,
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CriarContato()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2e5aac),
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    22, 11, 22, 11),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(40, 40),
                                    child: const ClipOval(
                                      child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("Criar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: 140,
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListarContatos()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFf29500),
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    22, 11, 22, 11),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(40, 40),
                                    child: const ClipOval(
                                      child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.list,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("Listar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: 140,
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DeletarContato()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFc50048),
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    22, 11, 22, 11),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size(40, 40),
                                    child: const ClipOval(
                                      child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.delete_outlined,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("Deletar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
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
                        "Sair",
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
}
