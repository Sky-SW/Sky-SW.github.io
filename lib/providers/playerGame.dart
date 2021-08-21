// ignore_for_file: file_names

import 'dart:math';

// player list
List playerList = [];

// if  two  player in data
//  two  player differents created
var player1 = playerList[Random().nextInt(playerList.length)];
var player2 = playerList[Random().nextInt(playerList.length)];

// reset player  one
player_1() {
  return player1 = playerList[Random().nextInt(playerList.length)];
}

// compare player one and player two
player_2() {
  var i = 0;
  while (i < 10) {
    if (player1 == player2) {
      player2 = playerList[Random().nextInt(playerList.length)];
    } else {
      if (playerList.contains(player2) == false) {
        player2 = playerList[Random().nextInt(playerList.length)];
      }
      if (player1 == player2) {
        player2 = playerList[Random().nextInt(playerList.length)];
      }
      return player2;
    }
    i++;
  }
}
