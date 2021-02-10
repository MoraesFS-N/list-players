import 'package:flutter/material.dart';
import 'package:list_players/models/player_model.dart';
import 'package:list_players/player_details.dart';
import 'package:list_players/player_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayerHelper db = PlayerHelper();

  List<Player> players;

  updateView() {
    db.listPlayer().then((valuesOfDatabase) {
      setState(() {
        this.players = valuesOfDatabase;
      });
    });
  }

  @override
  initState() {
    updateView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jogadores',
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: SizedBox(
        height: 200.0,
        child: ListView.builder(
            itemCount: this.players.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(this.players[index].nome),
                  subtitle: Text(this.players[index].time +
                      ' - ' +
                      this.players[index].posicao),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            callEditPlayer(this.players[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removePlayer(this.players[index]);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black26,
        onPressed: () async {
          callEditPlayer(Player(null, '', '', ''));
        },
      ),
    );
  }

/*
  connectionApi() async {
    var url = ' https://api.api-futebol.com.br/v1/campeonatos/10';
    var key = 'test_5e8962a0e049f025dd45e17c38ab51';

    var response = await http.get(url, headers: {key: key});
    String jsonFrom = jsonDecode(response.body);
    print(jsonFrom);
  }
*/
  callEditPlayer(Player player) async {
    bool resp = await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PlayerDetails(player),
    ));
    if (resp == true) {
      updateView();
    }
  }

  removePlayer(Player player) {
    AlertDialog dialog = AlertDialog(
      title: Text('Jogadores'),
      content: Text('Deseja realmente excluir este item?'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Sim'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Não'),
        )
      ],
    );
    showDialog(context: context, builder: (_) => dialog).then(
      (value) {
        if (value == true) {
          db.delete(player).then(
                (_) => {
                  updateView(),
                },
              );
        }
      },
    );
  }
}
