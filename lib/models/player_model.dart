class Player {
  int idJogador;
  String nome;
  String time;
  String posicao;

  Player(this.idJogador, this.nome, this.time, this.posicao);

  Map<String, dynamic> toMap() {
    return {
      'idJogador': idJogador,
      'nome': this.nome,
      'time': this.time,
      'posicao': this.posicao,
    };
  }

  static fromMap(data) {
    return Player(
      data['idJogador'],
      data['nome'],
      data['time'],
      data['posicao'],
    );
  }
}
