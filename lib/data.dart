part of 'main.dart';

final n = 3.0;

final List<List<int>> boxRhythmNums = [[], [], [], []];
final List<List<Color>> rhythmColorLists = [[], [], [], []];
final List<List<Color>> pulseColors = [[], [], [], []];
final List<List<double>> pulseDurations = [[], [], [], []];
final List<List<int>> vibrateRhythmNums = [[250], [250], [250], [250]];


final List<int> howFullNums = [0];

var currentListNums = [[], [], [], []];
var isAccessible = false;
int currentMeasureNum = 1;

List<bool> successfulDropNums = [null, null, null, null];

//general data class
class Data {
  List<Color> listOfColors;
  List<Color> listOfDarkColors;
  List<int> listOfWidths;
  List<int> listOfDurations;
  List<String> listOfNames;
  List<List<int>> rhythmArrays;
  List<String> labelArray;
  List<double> listOfScales;
  String boxType;
  List<Container> listOfContainers;
  int boxHeight;
  int boxWidth;
  int maxFull;

  Data ({this.listOfColors, this.listOfDarkColors, this.listOfWidths,
    this.listOfDurations, this.listOfNames, this.rhythmArrays,
    this.labelArray, this.listOfScales, this.boxType, this.listOfContainers,
    this.boxHeight, this.boxWidth, this.maxFull});
}

/*--------------------------------Measure Data-----------------------------------*/
final measureData = Data(listOfColors: measureListOfColors, listOfDarkColors: measureListOfDarkColors, listOfWidths: measureListOfWidths,
    listOfDurations: measureListOfDurations, listOfNames: measureListOfNames, rhythmArrays: measureRhythmArrays,
    labelArray: measureLabelArray, listOfScales: measureListOfScales, boxType: 'Measure',
    listOfContainers: measureListOfContainers, boxHeight: measureBoxHeight, boxWidth: measureBoxWidth,
    maxFull: measureMaxFull);

final measureListOfColors = [Colors.red, Colors.black, Colors.orange, Colors.black,
  Colors.yellow, Colors.black, Colors.green, Colors.black,
  Colors.blue, Colors.black, Colors.brown, Colors.black,
  Colors.deepOrange[800], Colors.black, Colors.amber[600], Colors.black,
  Colors.purple, Colors.grey, Colors.pink, Colors.tealAccent[100],
  Colors.lightGreenAccent[100], Colors.lightGreenAccent[400], Colors.indigo];
final measureListOfDarkColors = [Colors.red[900], Colors.white, Colors.orange[900], Colors.white,
  Colors.yellow[900], Colors.white, Colors.green[900], Colors.white,
  Colors.blue[900], Colors.white, Colors.brown[900], Colors.white,
  Colors.red[900], Colors.white, Colors.amber[900], Colors.white,
  Colors.purple[900], Colors.grey[800], Colors.pink[900], Colors.tealAccent[400],
  Colors.lightGreenAccent[700], Colors.lightGreen[700], Colors.indigo[900]];
final measureListOfWidths = [96, 96, 72, 72, 48, 48, 36, 36, 24, 24, 18, 18, 12, 12, 6, 6, 24, 24, 24, 24, 24, 24, 24];
final measureListOfDurations = [16, 16, 12, 12, 8, 8, 6, 6, 4, 4, 3, 3, 2, 2, 1, 1, 4, 4, 4, 4, 4, 4, 4];
final measureListOfNames = ['whole', 'wholeRest','dotHalf', 'dotHalfRest',
  'half', 'halfRest', 'dotQuarter', 'dotQuarterRest',
  'quarter', 'quarterRest', 'dotEighth', 'dotEighthRest',
  'eighth', 'eighthRest', 'sixteenth', 'sixteenthRest',
  'oneEAndA', 'oneAnd', 'oneAndA', 'oneEAnd', 'eAndA', 'oneEA', 'oneA'];
final measureRhythmArrays = [[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16], //1: Whole
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Whole Rest
  [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12], //2: Dot Half
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Dot Half Rest
  [8, 8, 8, 8, 8, 8, 8, 8], //3: Half
  [0, 0, 0, 0, 0, 0, 0, 0], //Half Rest
  [6, 6, 6, 6, 6, 6], //4: Dot Quarter
  [0, 0, 0, 0, 0, 0], //Dot Quarter Rest
  [4, 4, 4, 4], //5: Quarter
  [0, 0, 0, 0], //16: Quarter Rest
  [3, 3, 3], //6: Dot Eighth
  [0, 0, 0], //Dot Eighth Rest
  [2, 2], //7: Eighth
  [0, 0], // Eighth Rest
  [1], //8: Sixteenth
  [0], // Sixteenth Rest
  [1, 1, 1, 1], //9: One E And A
  [2, 2, 2, 2], //10: One And
  [2, 2, 1, 1], //11: One And A
  [1, 1, 2, 2], //12: One E And
  [0, 1, 1, 1], //13: E And A
  [1, 2, 2, 1], //14: One E A
  [3, 3, 3, 1], //15: One A
];
final measureLabelArray = ['w', 'W', 'd', 'D', 'h', 'H', 'j', 'J', ' q', 'Q', 'i', 'I', 'e', 'E', 's', 'S', 'y', 'n', 'm', 'M', 'S³', '¾', 'o', 'Q'];
final measureListOfScales = [4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 2.0, 2.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 5.0];
final measureListOfContainers = [
  for (var j in measureListOfNames)
    Container(
      child: Center (
        child: Text (
          measureLabelArray[measureListOfNames.indexOf(j)],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Musisync',
            color: measureListOfDarkColors[measureListOfNames.indexOf(j)],
          ),
          textScaleFactor: measureListOfScales[measureListOfNames.indexOf(j)],

        ),
      ),
      width: (measureListOfWidths[measureListOfNames.indexOf(j)] * n),
      height: (measureBoxHeight - 4) * n,
      decoration: BoxDecoration(
        color: measureListOfColors[measureListOfNames.indexOf(j)],
        border: Border.all(
          color: measureListOfDarkColors[measureListOfNames.indexOf(j)],
          width: 1,
        ),
      ),
    )
];
final measureBoxHeight = 40;
final measureBoxWidth = 100;
final measureMaxFull = 16;

/*--------------------------------Beat Data-----------------------------------*/
final beatData = Data(listOfColors: beatListOfColors, listOfDarkColors: beatListOfDarkColors, listOfWidths: beatListOfWidths,
    listOfDurations: beatListOfDurations, listOfNames: beatListOfNames, rhythmArrays: beatRhythmArrays,
    labelArray: beatLabelArray, listOfScales: beatListOfScales, boxType: 'Beat',
    listOfContainers: beatListOfContainers, boxHeight: beatBoxHeight, boxWidth: beatBoxWidth,
    maxFull: beatMaxFull);

final beatListOfColors = [Colors.blue, Colors.black, Colors.brown, Colors.black,
  Colors.deepOrange[800], Colors.black, Colors.amber[600], Colors.black,
  Colors.purple, Colors.grey, Colors.pink, Colors.tealAccent[100],
  Colors.lightGreenAccent[100], Colors.lightGreenAccent[400], Colors.indigo];

final beatListOfDarkColors = [Colors.blue[900], Colors.white, Colors.brown[900], Colors.white,
  Colors.red[900], Colors.white, Colors.amber[900], Colors.white,
  Colors.purple[900], Colors.grey[800], Colors.pink[900], Colors.tealAccent[400],
  Colors.lightGreenAccent[700], Colors.lightGreen[700], Colors.indigo[900]];
final beatListOfWidths = [80, 80, 60, 60, 40, 40, 20, 20, 80, 80, 80, 80, 80, 80, 80, 80];
final beatListOfDurations = [4, 4, 3, 3, 2, 2, 1, 1, 4, 4, 4, 4, 4, 4, 4];
final beatListOfNames = ['quarter', 'quarterRest', 'dotEighth', 'dotEighthRest',
  'eighth', 'eighthRest', 'sixteenth', 'sixteenthRest',
  'oneEAndA', 'oneAnd', 'oneAndA', 'oneEAnd', 'eAndA', 'oneEA', 'oneA'];
final beatRhythmArrays = [[4, 4, 4, 4], //1: Quarter
  [0, 0, 0, 0], // Quarter Rest
  [3, 3, 3], //2: Dot Eighth
  [0, 0, 0],// Dot Eighth Rest
  [2, 2], //3: Eighth
  [0, 0], // Eighth
  [1], //4: Sixteenth
  [0], //Sixteenth Rest
  [1, 1, 1, 1], //5: One E And A
  [2, 2, 2, 2], //6: One And
  [2, 2, 1, 1], //7: One And A
  [1, 1, 2, 2], //8: One E And
  [0, 1, 1, 1], //9: E And A
  [1, 2, 2, 1], //10: One E A
  [3, 3, 3, 1], //11: One A
];
final beatLabelArray = [' q', 'Q','i','I', 'e','E', 's','S', 'y', 'n', 'm', 'M', 'S³', '¾', 'o'];
final beatListOfScales = [4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0];
final beatListOfContainers = [
  for (var j in beatListOfNames)
    Container(
      child: Center (
        child: Text (
          beatLabelArray[beatListOfNames.indexOf(j)],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Musisync',
            color: beatListOfDarkColors[beatListOfNames.indexOf(j)],
          ),
          textScaleFactor: beatListOfScales[beatListOfNames.indexOf(j)],

        ),
      ),
      width: (beatListOfWidths[beatListOfNames.indexOf(j)] * n),
      height: (beatBoxHeight - 4) * n,
      decoration: BoxDecoration(
        color: beatListOfColors[beatListOfNames.indexOf(j)],
        border: Border.all(
          color: beatListOfDarkColors[beatListOfNames.indexOf(j)],
          width: 1,
        ),
      ),
    )
];
final beatBoxHeight = 44;
final beatBoxWidth = 84;
final beatMaxFull = 4;

/*--------------------------------ThreeFour Data-----------------------------------*/
final threeFourData = Data(listOfColors: threeFourListOfColors, listOfDarkColors: threeFourListOfDarkColors, listOfWidths: threeFourListOfWidths,
    listOfDurations: threeFourListOfDurations, listOfNames: threeFourListOfNames, rhythmArrays: threeFourRhythmArrays,
    labelArray: threeFourLabelArray, listOfScales: threeFourListOfScales, boxType: 'Measure',
    listOfContainers: threeFourListOfContainers, boxHeight: threeFourBoxHeight, boxWidth: threeFourBoxWidth,
    maxFull: threeFourMaxFull);

final threeFourListOfColors = [Colors.orange, Colors.black,
  Colors.yellow, Colors.black, Colors.green, Colors.black,
  Colors.blue, Colors.black, Colors.brown, Colors.black,
  Colors.deepOrange[800], Colors.black, Colors.amber[600], Colors.black,
  Colors.purple, Colors.grey, Colors.pink, Colors.tealAccent[100],
  Colors.lightGreenAccent[100], Colors.lightGreenAccent[400], Colors.indigo];
final threeFourListOfDarkColors = [Colors.orange[900], Colors.white,
  Colors.yellow[900], Colors.white, Colors.green[900], Colors.white,
  Colors.blue[900], Colors.white, Colors.brown[900], Colors.white,
  Colors.red[900], Colors.white, Colors.amber[900], Colors.white,
  Colors.purple[900], Colors.grey[800], Colors.pink[900], Colors.tealAccent[400],
  Colors.lightGreenAccent[700], Colors.lightGreen[700], Colors.indigo[900]];
final threeFourListOfWidths = [72, 72, 48, 48, 36, 36, 24, 24, 18, 18, 12, 12, 6, 6, 24, 24, 24, 24, 24, 24, 24];
final threeFourListOfDurations = [12, 12, 8, 8, 6, 6, 4, 4, 3, 3, 2, 2, 1, 1, 4, 4, 4, 4, 4, 4, 4];
final threeFourListOfNames = ['dotHalf', 'dotHalfRest',
  'half', 'halfRest', 'dotQuarter', 'dotQuarterRest',
  'quarter', 'quarterRest', 'dotEighth', 'dotEighthRest',
  'eighth', 'eighthRest', 'sixteenth', 'sixteenthRest',
  'oneEAndA', 'oneAnd', 'oneAndA', 'oneEAnd', 'eAndA', 'oneEA', 'oneA'];
final threeFourRhythmArrays = [[12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12], //2: Dot Half
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Dot Half Rest
  [8, 8, 8, 8, 8, 8, 8, 8], //3: Half
  [0, 0, 0, 0, 0, 0, 0, 0], //Half Rest
  [6, 6, 6, 6, 6, 6], //4: Dot Quarter
  [0, 0, 0, 0, 0, 0], //Dot Quarter Rest
  [4, 4, 4, 4], //5: Quarter
  [0, 0, 0, 0], //16: Quarter Rest
  [3, 3, 3], //6: Dot Eighth
  [0, 0, 0], //Dot Eighth Rest
  [2, 2], //7: Eighth
  [0, 0], // Eighth Rest
  [1], //8: Sixteenth
  [0], // Sixteenth Rest
  [1, 1, 1, 1], //9: One E And A
  [2, 2, 2, 2], //10: One And
  [2, 2, 1, 1], //11: One And A
  [1, 1, 2, 2], //12: One E And
  [0, 1, 1, 1], //13: E And A
  [1, 2, 2, 1], //14: One E A
  [3, 3, 3, 1], //15: One A
];
final threeFourLabelArray = ['d', 'D', 'h', 'H', 'j', 'J', ' q', 'Q', 'i', 'I', 'e', 'E', 's', 'S', 'y', 'n', 'm', 'M', 'S³', '¾', 'o', 'Q'];
final threeFourListOfScales = [4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 2.0, 2.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 5.0];
final threeFourListOfContainers = [
  for (var j in threeFourListOfNames)
    Container(
      child: Center (
        child: Text (
          threeFourLabelArray[threeFourListOfNames.indexOf(j)],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Musisync',
            color: threeFourListOfDarkColors[threeFourListOfNames.indexOf(j)],
          ),
          textScaleFactor: threeFourListOfScales[threeFourListOfNames.indexOf(j)],

        ),
      ),
      width: (threeFourListOfWidths[threeFourListOfNames.indexOf(j)] * n),
      height: (threeFourBoxHeight - 4) * n,
      decoration: BoxDecoration(
        color: threeFourListOfColors[threeFourListOfNames.indexOf(j)],
        border: Border.all(
          color: threeFourListOfDarkColors[threeFourListOfNames.indexOf(j)],
          width: 1,
        ),
      ),
    )
];
final threeFourBoxHeight = 40;
final threeFourBoxWidth = 76;
final threeFourMaxFull = 12;