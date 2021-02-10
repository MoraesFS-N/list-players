import 'package:flutter/material.dart';
import 'package:list_players/player_home.dart';

void main() {
  runApp(ListPlayers());
}

class ListPlayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
