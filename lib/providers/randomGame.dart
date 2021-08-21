// ignore_for_file: file_names

// random number
import 'dart:math';

// variables
List colors = [
  'bleu',
  'rouge',
  'vert',
  'jaune',
  'marron',
  'orange',
  'blanc',
  'noir',
  'violet',
  'gris',
  'rose'
];

List heros = [
  'BATMAN',
  'SUPERMAN',
  'SUPERGIRL',
  'CATWOMEN',
  'IRON MAN',
  'THOR',
  'HULK',
  'BLACKWIDOW',
  'AQUAMAN',
  'ROBIN',
  'HARLEY QUIN',
  'LE JOCKER',
  'VANDA',
  'VISION'
];

List alcool = ['vin', 'bière', 'rhum', 'vodka', 'wisky', 'cocktail'];

List minorityOrMajority = ['minoritaires', 'majoritaires'];

List firstModeChoice = [
  'voyager en France ou partir à l\'étranger',
  'plage ou montagne',
  'épicé ou doux',
  'vin ou bière',
  'sushis ou burger',
  'pain au chocolat ou chocolatine',
  'sucré ou salé'
];

List smallOrBig = ['petite', 'grande'];

List fourModeAll = [
  'vieux/vielles',
  'burgers',
  'sushis',
  'pizzas',
  'cougardes/sugar daddy'
];

List size = [
  '1m60 et 1m75',
  '1m50 et 1m65',
  '1m55 et 1m70',
  '1m70 et 1m85',
  '1m80 et 1m95'
];

List choice = [
  'Je ne sors jamais sans ...',
  'La première chose que je prends en voiture ...',
  'La première chose que je fais au réveil ...',
  'Meilleure série des années 2000 ...'
];

List old = [
  '20ans et moins de 30ans',
  '18ans et moins de 25ans',
  '25ans et moins de 40ans',
  '25ans',
  '30ans',
  '35ans',
  '40ans'
];

List hairColor = [
  'blonds/blondes',
  'chatains/chataignes',
  'bruns/brunes',
  'roux/rousses'
];

List youngOrOld = ['jeune', 'âgée'];

List secondModeModeGuest = [
  'chiante',
  'drole',
  'charismatique',
  'énervante',
  'tête en l\'air',
  'serviable',
  'gentille',
  'sociable',
  'antisociable',
  'joyeuse',
  'dragueuse',
  'alcoolique',
  'joueuse',
  'cinglée'
];

List synonymous = [
  'meilleur',
  'gentil',
  'attachant',
  'âgé',
  'attendre',
  'argent',
  'manger',
  'nettoyer'
];

List secondModeGame = [
  'Il était une fois',
  'Un jour en me retournant',
  'Je l\'ai surpris(e) en train de',
  'En fait c\'était',
  'Je peux tout t\'expliquer'
];

List thirdModeVoteOne = ['Embrasser', 'Sucer', 'Cacher', 'Branler'];

List thirdModeAsk = [
  'Les morsures/léchouillent plutôt cou ou lèvre',
  'Plutôt douceur ou violence au lit',
  'Plutôt vaginal ou anal',
  'Plutôt morsure ou léchouille',
  '69 plutôt allongé ou debout',
  'Plutôt fessée ou caresse',
  'Plutôt soumission ou domination au lit',
  'La masturbation plutôt solo ou accompagnés'
];

List thirdModeVoteSecond = [
  'en forêt ou à la piscine',
  'au lit ou en voiture',
  'au ciné ou à la piscine',
  'au travail ou en voiture',
  'au ciné ou au travail',
  'en forêt ou au lit'
];

List thirdModeChoice = ['mordre', 'embrasser', 'caresser', 'lécher'];

List leftOrRight = ['gauche', 'droite'];

List fourModeVoteIfAlcohol = ['bourrée', 'sobre'];

List generalDoneOrNotDone = [
  'qui ont déjà faits ça prennent ',
  'qui n\'ont jamais faits ça prennent '
];

List doneOrNotDone = [
  'as déjà fait ça tu prends ',
  'n\'as jamais fait ça tu prends ',
  'n\'as jamais fait ça tu distribues ',
  'as déjà fait ça tu distribues ',
];

List giveOrDone = [' ou tu prends ', ' ou tu distribues '];

// random between 0 and 10
randomNumberStart() {
  var rn = Random();
  return rn.nextInt(11).toString();
}

// random gulp
randomGulp() {
  int min = 1;
  int max = 6;
  String gulp = ' gorgée';
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  if (randomNumber > 1) {
    gulp = ' gorgées';
  }
  return randomNumber.toString() + gulp;
}

// little random
littleRandom() {
  int min = 1;
  int max = 4;
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  return randomNumber.toString();
}

// little random gulp
littleRandomGulp() {
  int min = 1;
  int max = 4;
  String gulp = ' gorgée';
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  if (randomNumber > 1) {
    gulp = ' gorgées';
  }
  return randomNumber.toString() + gulp;
}

// little random gulp with wait
littleRandomGulpWithWait() {
  int min = 1;
  int max = 4;
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  if (randomNumber > 1) {
    return randomNumber.toString() + " gorgées t'attendent";
  } else {
    return randomNumber.toString() + " gorgée t'attend";
  }
}

// middle random
middleRandomTime() {
  int min = 2;
  int max = 6;
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  return randomNumber.toString() + " tours";
}

// big random
bigRandom() {
  int min = 4;
  int max = 6;
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  return randomNumber.toString();
}

// big random with gulp
bigRandomGulp() {
  int min = 4;
  int max = 6;
  String gulp = ' gorgées';
  var rnd = Random();
  var randomNumber = min + rnd.nextInt(max - min);
  return randomNumber.toString() + gulp;
}

// return random color
randomColor() {
  var rn = Random();
  return colors[rn.nextInt(colors.length)].toString();
}

// return random hero
randomHero() {
  var rn = Random();
  return heros[rn.nextInt(heros.length)].toString();
}

// return random alcool
randomAlcool() {
  var rn = Random();
  return alcool[rn.nextInt(alcool.length)].toString();
}

// return random done or not done for all
randomGeneralDoneOrNotDone() {
  var rn = Random();
  return generalDoneOrNotDone[rn.nextInt(generalDoneOrNotDone.length)]
      .toString();
}

// return random done or not done
randomDoneOrNotDone() {
  var rn = Random();
  return doneOrNotDone[rn.nextInt(doneOrNotDone.length)].toString();
}

// return random minority or majority
randomminorityOrMajority() {
  var rn = Random();
  return minorityOrMajority[rn.nextInt(minorityOrMajority.length)].toString();
}

// return random first mode choice
randomFirstModeChoice() {
  var rn = Random();
  return firstModeChoice[rn.nextInt(firstModeChoice.length)].toString();
}

// return random little or big
randomLittleOrBig() {
  var rn = Random();
  return smallOrBig[rn.nextInt(smallOrBig.length)].toString();
}

// return random size
randomSize() {
  var rn = Random();
  return size[rn.nextInt(size.length)].toString();
}

// return random choice
randomChoice() {
  var rn = Random();
  return choice[rn.nextInt(choice.length)].toString();
}

// return random choice
randomOld() {
  var rn = Random();
  return old[rn.nextInt(old.length)].toString();
}

// return random young or old
randomYoungOrOld() {
  var rn = Random();
  return youngOrOld[rn.nextInt(youngOrOld.length)].toString();
}

// return random young or old
randomHairColor() {
  var rn = Random();
  return hairColor[rn.nextInt(hairColor.length)].toString();
}

// return random second mode more guest
randomSecondModeGuest() {
  var rn = Random();
  return secondModeModeGuest[rn.nextInt(secondModeModeGuest.length)].toString();
}

// return random synonymous
randomSynonymous() {
  var rn = Random();
  return synonymous[rn.nextInt(synonymous.length)].toString();
}

// return random second mode game
randomSecondModeGame() {
  var rn = Random();
  return secondModeGame[rn.nextInt(secondModeGame.length)].toString();
}

// return random third mode choice
randomThirdModeVoteOne() {
  var rn = Random();
  return thirdModeVoteOne[rn.nextInt(thirdModeVoteOne.length)].toString();
}

// return random third mode ask
randomThirdModeAsk() {
  var rn = Random();
  return thirdModeAsk[rn.nextInt(thirdModeAsk.length)].toString();
}

// return random third mode ask
randomThirdModeVoteSecond() {
  var rn = Random();
  return thirdModeVoteSecond[rn.nextInt(thirdModeVoteSecond.length)].toString();
}

// return random third mode choice
randomThirdModeChoice() {
  var rn = Random();
  return thirdModeChoice[rn.nextInt(thirdModeChoice.length)].toString();
}

// return random left or right
randomLeftOrRight() {
  var rn = Random();
  return leftOrRight[rn.nextInt(leftOrRight.length)].toString();
}

// return random four mode vote
randomFourModeVote() {
  var rn = Random();
  return fourModeVoteIfAlcohol[rn.nextInt(fourModeVoteIfAlcohol.length)]
      .toString();
}

// return random four mode vote
randomFourModeAll() {
  var rn = Random();
  return fourModeAll[rn.nextInt(fourModeAll.length)].toString();
}

randomGiveOrDone() {
  var rn = Random();
  return giveOrDone[rn.nextInt(giveOrDone.length)].toString();
}
