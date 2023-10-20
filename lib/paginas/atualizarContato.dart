import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/dao/ContatoDAO.dart';
import 'package:lista_de_contatos/modelos/Contato.dart';
import 'package:lista_de_contatos/paginas/home_contatos.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class AtualizarContato extends StatefulWidget {
  AtualizarContato({Key? key, contato}) : super(key: key);

  @override
  _AtualizarContatoState createState() => _AtualizarContatoState();
}

class _AtualizarContatoState extends State<AtualizarContato> {
  // acessar banco de dados
  final ContatoDAO _db = ContatoDAO();

  XFile? photo;

  // recuperar os dados digitados pelo usuário
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerUrlImagem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // recebendo argumentos de outra tela
    final contato = ModalRoute.of(context)!.settings.arguments as Contato;

    // imprimindo dados passados da outra tela
    print(contato.nome);

    dynamic id = contato.id!;
    String nome = contato.nome;
    String telefone = contato.telefone;
    String email = contato.email;
    String urlImagem = contato.urlImagem;

    _controllerNome.text = nome;
    _controllerTelefone.text = telefone;
    _controllerEmail.text = email;

    if (photo == null && contato.urlImagem != null) {
      _controllerUrlImagem.text = urlImagem;
    } else {
      _controllerUrlImagem.text = photo!.path;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: const Color(0xFF332c66),
        title: const Text("Atualizar Contato",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff51489a),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              photo == null && contato.urlImagem != null
                                  ? CircleAvatar(
                                      radius: 90,
                                      backgroundColor: const Color(0xFFffffff),
                                      child: CircleAvatar(
                                        radius: 99,
                                        child: ClipOval(
                                          child: Image.file(
                                            File((contato.urlImagem)),
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 90,
                                      backgroundColor: const Color(0xFFffffff),
                                      child: CircleAvatar(
                                        radius: 99,
                                        child: ClipOval(
                                          child: Image.file(
                                            File(photo!.path),
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                    ),
                              Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return Wrap(
                                              children: [
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.camera,
                                                      color: Color(0xFF7d74c3)),
                                                  title: const Text("Camera"),
                                                  onTap: () async {
                                                    final ImagePicker _picker =
                                                        ImagePicker();
                                                    photo =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (photo != null) {
                                                      String path =
                                                          (await path_provider
                                                                  .getApplicationDocumentsDirectory())
                                                              .path;
                                                      String name =
                                                          basename(photo!.path);
                                                      await photo!.saveTo(
                                                          "$path/$name");
                                                      await GallerySaver
                                                          .saveImage(
                                                              photo!.path);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    }
                                                  },
                                                ),
                                                photo != null
                                                    ? Container(
                                                        child: Image.file(
                                                            File(photo!.path)),
                                                      )
                                                    : Container(),
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.image,
                                                      color: Color(0xFF7d74c3)),
                                                  title: const Text("Galeria"),
                                                  onTap: () async {
                                                    final ImagePicker _picker =
                                                        ImagePicker();
                                                    photo =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    elevation: 2.0,
                                    fillColor: const Color(0xFF2e5aac),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Color(0xFFffffff),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      //controller captura os dados digitados pelo usuário
                      controller: _controllerNome,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 16, 26, 16),
                        hintText: "Nome",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF7d74c3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.account_circle,
                            color: Color(0xFFffffff)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      //controller captura os dados digitados pelo usuário
                      controller: _controllerTelefone,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 16, 26, 16),
                        hintText: "Telefone",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF7d74c3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.local_phone,
                            color: Color(0xFFffffff)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      //controller captura os dados digitados pelo usuário
                      controller: _controllerEmail,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 16, 26, 16),
                        hintText: "E-mail",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF7d74c3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFFffffff)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      //controller captura os dados digitados pelo usuário
                      controller: _controllerUrlImagem,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 16, 26, 16),
                        hintText: "Imagem",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF7d74c3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.add_photo_alternate,
                            color: Color(0xFFffffff)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _atualizar(contato);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFf29500),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Atualizar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
        ]),
      ),
    );
  }

  // atualizar dados no banco
  _atualizar(contato) async {
    BuildContext context = this.context;

    dynamic? id = contato.id;
    String nome = _controllerNome.text;
    String telefone = _controllerTelefone.text;
    String email = _controllerEmail.text;
    String urlImagem = _controllerUrlImagem.text;

    Contato contatoList = Contato(id, nome, telefone, email, urlImagem);
    dynamic resultado = await _db.atualizarContato(contatoList);
    print("Atualizar contato: " + resultado.toString());

    // Remove o SnackBar caso esteja aberto
    ScaffoldMessenger.of(context).clearSnackBars();

    // Exibe uma mensagem quando a Categora é criada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "Contato atualizado com sucesso!",
            style: TextStyle(
              color: Color(0xffffffff),
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
