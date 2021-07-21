/*
- An approach how Flutter BottomSheet should works with SnackBars on Flutter.
- Armstrong Lohãns - 2021
- https://github.com/lohhans
*/

// Flutter imports:
import 'package:flutter/material.dart';

class BottomSheetWithSnackBar extends StatefulWidget {
  const BottomSheetWithSnackBar({Key? key}) : super(key: key);

  @override
  _BottomSheetWithSnackBarState createState() =>
      _BottomSheetWithSnackBarState();
}

class _BottomSheetWithSnackBarState extends State<BottomSheetWithSnackBar> {
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
            // EN: Here you set up your BottomSheet with the widgets you want, on it you'll use the SnackBar.
            // PT-BR: Aqui você monta seu BottomSheet com os widgets que quiser, nele você utilizará o SnackBar.
            return Container(
              height: 200,
              color: Colors.blueGrey,
              child: Center(
                child: ElevatedButton(
                  child: const Text('SNACKBAR'),
                  onPressed: () {
                    // EN: Any SnackBar in this context will appear above the BottomSheet, as desired.
                    // PT-BR: Qualquer SnackBar neste contexto aparecerá acima do BottomSheet, como desejado.
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
      // EN: Here it is necessary to use a Stack to add depth effect (shadow) to the BottomSheet when be opened,
      // it is important to know how to manipulate the Stack to not get adverse effects.
      // PT-BR: Aqui é necessário o uso de uma Stack para adicionarmos efeito de profundidade (sombra) ao BottomSheet ser aberto,
      // é importante saber manipular a Stack para não obter efeitos adversos.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // EN: This "if" is important to know when the BottomSheet is open
          // and then darken everything behind it only at this moment.
          // PT-BR: Este "if" é importante para saber quando o BottomSheet está aberto
          // e então escurecer tudo por trás dele somente neste momento.
          if (_showPersistentBottomSheetCallBack == null)
            Container(
              color: Colors.black12,
            ),

          // EN: The entire "body" of the application is here, in this case it only has the button that calls the SnackBar,
          // but if you want to show more information, use a "Column" or something similar to keep a single widget above the last widget...
          // PT-BR: O "body" real da aplicação se encontra aqui, neste caso só tem o botão que chama a SnackBar,
          // mas caso queira mostrar mais informações use uma "Column" ou algo semelhante para manter um widget único acima do último widget...
          Center(
            child: ElevatedButton(
              child: const Text('BOTTOMSHEET'),
              onPressed: _showPersistentBottomSheetCallBack,
            ),
          ),

          // EN: Again the "if" is used to "do the work" only when the BottomSheet is open, and in this case,
          // the "GestureDetector" will notice if there are touches outside the BottomSheet and will close it if so.
          // PT-BR: Novamente o "if" é utilizado para "funcionar" somente quando o BottomSheet está aberto,
          // e neste caso, o "GestureDetector" irá perceber se existem toques fora do BottomSheet e irá fechá-lo caso positivo.
          if (_showPersistentBottomSheetCallBack == null)
            GestureDetector(onTap: (() => Navigator.pop(context))),
        ],
      ),
    );
  }
}
