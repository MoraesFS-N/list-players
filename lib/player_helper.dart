import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/player_model.dart';

class PlayerHelper {
  String CREATE_TABLE =
      'CREATE TABLE jogador(idJogador integer primary key autoincrement not null, nome text not null, time text not null, posicao text not null)';
  String tabela = 'jogador';

  Future<Database> openConnection() async {
    return openDatabase(
      join(await getDatabasesPath(), 'jogadores_db.db'),
      onCreate: (db, version) {
        return db.execute(
          this.CREATE_TABLE,
        );
      },
      version: 1,
    );
  }

  Future insertPlayer(Player player) async {
    Database db = await this.openConnection();
    if (player.idJogador == null) {
      return db.insert(this.tabela, player.toMap());
    } else {
      return db.update(
        this.tabela,
        player.toMap(),
        where: 'idJogador = ?',
        whereArgs: [player.idJogador],
      );
    }
  }

  Future delete(Player player) async {
    Database db = await this.openConnection();

    db.delete(
      this.tabela,
      where: 'idJogador = ?',
      whereArgs: [player.idJogador],
    );
  }

  Future<List<Player>> listPlayer() async {
    Database db = await this.openConnection();
    List<Map<String, dynamic>> player = await db.query(this.tabela);

    return List.generate(
      player.length,
      (index) => Player.fromMap(
        player[index],
      ),
    );
  }
}
