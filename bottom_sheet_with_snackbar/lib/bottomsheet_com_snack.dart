// Flutter imports:
import 'package:flutter/material.dart';

class TelaDeBottomSheetComSnack extends StatefulWidget {
  const TelaDeBottomSheetComSnack({Key? key}) : super(key: key);

  @override
  _TelaDeBottomSheetComSnackState createState() => _TelaDeBottomSheetComSnackState();
}

class _TelaDeBottomSheetComSnackState extends State<TelaDeBottomSheetComSnack> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistentBottomSheetCallBack;

  void initState() {
    super.initState();
    _showPersistentBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersistentBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState!
        .showBottomSheet(
          (context) {
            // AQUI VOCÊ MONTA O QUE QUISER DENTRO DO BOTTOMSHEET
            return Container(
              height: 200,
              color: Colors.blueGrey,
              child:  Center(
                child: ElevatedButton(
                  child: const Text('SNACKBAR'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('SNACKBAR! :)'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
        .closed
        .whenComplete(
          () {
            if (mounted) {
              setState(
                () {
                  _showPersistentBottomSheetCallBack = _showBottomSheet;
                },
              );
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Flutter BottomSheet With SnackBar'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Escurece a tela para dar o efeito de que algo está em cima
          if(_showPersistentBottomSheetCallBack==null)
            Container(
              color: Colors.black12,
            ),

          // Informações da tela (Neste caso só tem o botão que chama a SnackBar,
          // caso queira usar mais informações põe uma Column...
          Center(
            child: ElevatedButton(
              child: const Text('BOTTOMSHEET'),
              onPressed: _showPersistentBottomSheetCallBack,
            ),
          ),

          // Percebe se existem toques fora do BottomSheet e fecha
          if(_showPersistentBottomSheetCallBack==null)
            GestureDetector(onTap: (() => Navigator.pop(context))),
        ],
      ),
    );
  }
}


