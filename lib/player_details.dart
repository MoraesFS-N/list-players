import 'package:flutter/material.dart';
import 'package:list_players/player_helper.dart';
import 'models/player_model.dart';

// ignore: must_be_immutable
class PlayerDetails extends StatefulWidget {
  Player player;

  PlayerDetails(this.player);

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState(this.player);
}

class _PlayerDetailsState extends State<PlayerDetails> {
  TextEditingController nomeCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController posicaoCtrl = TextEditingController();
  PlayerHelper db = PlayerHelper();

  Player player;

  _PlayerDetailsState(this.player);

  @override
  Widget build(BuildContext context) {
    nomeCtrl.text = this.player.nome;
    timeCtrl.text = this.player.time;
    posicaoCtrl.text = this.player.posicao;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Jogadores',
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
              ),
              TextField(
                controller: this.nomeCtrl,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              TextField(
                controller: this.timeCtrl,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                ),
              ),
              TextField(
                controller: this.posicaoCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Posicao',
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.black87,
                child: Text('Confirmar'),
                onPressed: () {
                  this.save();
                },
                padding: const EdgeInsets.only(
                    right: 50, left: 50, bottom: 20, top: 20),
                hoverColor: Colors.black38,
              )
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    this.player.nome = nomeCtrl.text;
    this.player.time = timeCtrl.text;
    this.player.posicao = posicaoCtrl.text;

    this.db.insertPlayer(player).then(
      (value) {
        AlertDialog dialog = AlertDialog(
          title: Text('Jogador'),
          content: Text('Jogador Salvo!'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Ok'),
            )
          ],
        );
        showDialog(context: context, builder: (_) => dialog).then(
          (value) => Navigator.of(context).pop(true),
        );
      },
    );
  }
}
