part of 'main.dart';

class MeasureBoxWidget extends StatefulWidget {
  final Data boxData;
  final int measureNumber;
  final int duration;
  MeasureBoxWidget({Key key, this.boxData, this.measureNumber, this.duration}) : super(key: key);
  @override
  _MBWidgetState createState() => _MBWidgetState(boxData: boxData, measureNumber: measureNumber, duration: duration);
  Widget build(BuildContext context) {

  }
}

String baseURL = 'https://storage.googleapis.com/mehek_box_sounds/sounds_two_mp3/';



void _vibrate(List<int> vibrateRhythm, List<int> boxRhythm) async {
  if (await Vibration.hasVibrator() && await Vibration.hasCustomVibrationsSupport()) {
    vibrateRhythm.clear();
    int rest = 250;
    for (int i = 0; i < boxRhythm.length; i++) {
      if (boxRhythm[i] != 0) {
        vibrateRhythm.add(rest + 10);
        vibrateRhythm.add(boxRhythm[i]*250 - 10);
        i += boxRhythm[i] - 1;
        rest = 0;
      } else {
        rest += 250;
      }
    }
    Vibration.vibrate(pattern: vibrateRhythm);
  }
}


String _canPlay = 'Measure not full: Fill to play';



class _MBWidgetState extends State<MeasureBoxWidget> with TickerProviderStateMixin{
  final Data boxData;
  final int measureNumber;
  final int duration;
  _MBWidgetState({this.boxData, this.measureNumber, this.duration});
  @override
  bool isButtonEnabled;
  Widget pulseUsing = Container();

  int _duration;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _duration = widget.duration;
    animationController = AnimationController(
        duration: Duration(milliseconds: _duration),
        vsync: this
    );
  }

  @override
  void didUpdateWidget(MeasureBoxWidget oldWidget) {
    setState(() {
      _duration = widget.duration;
    });

    updateController(oldWidget);
    super.didUpdateWidget(oldWidget);
  }


  void updateController(MeasureBoxWidget oldWidget){
    if(oldWidget.duration != _duration){
      animationController.dispose();
      animationController = AnimationController(duration: Duration(milliseconds: _duration), vsync:this);
    }
  }

  Widget pulser(List<List<double>> pulseDurations, List<List<Color>> pulseColors) {
        return Stack(
          children: [
            for (int i = 0; i < pulseColors[measureNumber - 1].length; i++)
              SpinKitPulse(
                color: pulseColors[measureNumber - 1][i],
                size: 400.0,
                intervalOne: pulseDurations[measureNumber - 1][i*2],
                intervalTwo: pulseDurations[measureNumber - 1][i*2 + 1],
                controller: AnimationController(
                  vsync: this,
                  duration: Duration(milliseconds: 4000),
                ),
              )
          ],
        );
  }

  Function _enablePlayButton() {
    isButtonEnabled = (howFullNums[measureNumber - 1] == boxData.maxFull);
    if (isButtonEnabled) {
      _canPlay = 'Measure is full: Can Play';
      return () async {
        pulseDurations[measureNumber - 1].clear();
        pulseColors[measureNumber - 1].clear();
        rhythmColorLists[measureNumber - 1].clear();
        boxRhythmNums[measureNumber - 1].clear();
        for (var l in currentListNums[measureNumber - 1]) {
          boxRhythmNums[measureNumber - 1].addAll(boxData.rhythmArrays[boxData.listOfNames.indexOf(l)]);
          for (int i = 0; i < boxData.rhythmArrays[boxData.listOfNames.indexOf(l)].length; i++) {
            rhythmColorLists[measureNumber - 1].add(boxData.listOfColors[boxData.listOfNames.indexOf(l)]);
          }
        }
        //player.clearCache();
        List<String> loadAllArray = [];
        double lastTime = 0.0;
        for (int i = 0; i < boxRhythmNums[measureNumber - 1].length; i++) {
          loadAllArray.add('Index'+ (i + 1).toString() + 'Length' + boxRhythmNums[measureNumber - 1][i].toString() + '.mp3');
          pulseDurations[measureNumber - 1].add(lastTime);
          pulseDurations[measureNumber - 1].add(lastTime + boxRhythmNums[measureNumber - 1][i] / 16.0);
          lastTime = lastTime + boxRhythmNums[measureNumber - 1][i] / 16.0;
          pulseColors[measureNumber - 1].add(rhythmColorLists[measureNumber - 1][i]);
          if (boxRhythmNums[measureNumber - 1][i] != 0) {
            i = i + boxRhythmNums[measureNumber - 1][i] - 1;
          }
        }
        AudioPlayer _player = AudioPlayer();
        List<AudioSource> loadList = [];
        for (String s in loadAllArray) {
          loadList.add(AudioSource.uri(Uri.parse(baseURL + s)));
        }
        ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: loadList);
        await _player.load(_playlist, initialIndex: 0, initialPosition: Duration.zero);
        await _player.seekToNext();
        await _player.seekToPrevious();
        _vibrate(vibrateRhythmNums[measureNumber - 1], boxRhythmNums[measureNumber - 1]);
        setState(() {
          _player.play();
          setState(() {
            pulseUsing = pulser(pulseDurations, pulseColors);
          });
          Future.delayed(Duration(milliseconds: 4000), () {
            setState(() {
                pulseUsing = Container();
            });
          });
        });
      };
    } else {
      _canPlay = 'Measure not full: Fill to play';
      return null;
    }
  }

  Function _removeRhythm(int indexCurrentList, int indexData) {
    return () {
      setState(() {
        isAccessible = true;
        currentListNums[measureNumber - 1].removeAt(indexCurrentList);
        howFullNums[measureNumber - 1] -= boxData.listOfDurations[indexData];
      });
    };
  }



  Widget build(BuildContext context) {
    if (isAccessible) {
      return Container(
          child: Column(
              children: [
                Center(
                  //Draws the box, with the right size
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        pulseUsing,
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                height: boxData.boxHeight * n,
                                width: boxData.boxWidth * n,
                                decoration: BoxDecoration(
                                  color: Color(0xc9c9c9),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2 * n,
                                  ),
                                ),
                                // Draws the blocks currently in the box
                                child: Center(
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < currentListNums[measureNumber - 1].length; i++)
                                          Container (
                                              width: boxData.listOfWidths[boxData.listOfNames.indexOf(currentListNums[measureNumber - 1][i])]*n,
                                              height:(boxData.boxHeight - 4)*n,
                                              child: RawMaterialButton(
                                                onPressed: _removeRhythm(i, boxData.listOfNames.indexOf(currentListNums[measureNumber - 1][i])),
                                                padding: EdgeInsets.all(0),
                                                child: Tooltip(message: currentListNums[measureNumber - 1][i],
                                                    child: boxData.listOfContainers[boxData.listOfNames.indexOf(currentListNums[measureNumber - 1][i])]),
                                              )
                                          )
                                      ],
                                    )
                                )
                            )
                        ),
                      ]
                    ),
                ),
                Container(
                  child: Semantics(
                    label: 'Play Button',
                    value: _canPlay,
                    child: IconButton(
                      iconSize: 80.0,
                      icon: Icon(Icons.play_circle_filled),
                      color: Colors.blue,
                      disabledColor: Colors.grey,
                      onPressed: _enablePlayButton(),
                    ),
                  )
                )]
          )
      );
    } else {
      return DragTarget<String>(builder: (BuildContext context, List<String> incoming, List rejected) {
          return Column (
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    pulseUsing,
                    Container (
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Container (
                        height: boxData.boxHeight*n,
                        width: boxData.boxWidth*n,
                        decoration: BoxDecoration(
                          color: Color(0xc9c9c9),
                          border: Border.all(
                            color: Colors.white,
                            width: 2*n,
                          ),
                        ),
                        child: Center ( // Draws the blocks currently in the box
                          child: Row(
                            children: [
                              for (var i in currentListNums[measureNumber - 1])
                              Draggable(
                                child: boxData.listOfContainers[boxData.listOfNames.indexOf(i)],
                                feedback: Material (
                                  child: boxData.listOfContainers[boxData.listOfNames.indexOf(i)],
                                ),
                                childWhenDragging: null,
                                data: ([currentListNums[measureNumber - 1].indexOf(i), measureNumber - 1]),
                              ),
                            ],
                          )
                        )
                      )
                    ),

                  ]
                ),
                  //Draws the box, with the right size
                Container(
                  child: IconButton (
                    iconSize: 80.0,
                    icon: Icon(Icons.play_circle_filled),
                    color: Colors.blue,
                    disabledColor: Colors.grey,
                    onPressed: _enablePlayButton(),
                    tooltip: "Play Rhythm",
                  ),
                )
              ]
          );
        },

        onWillAccept: (data) {
          if (data is String) {
            return (boxData.listOfDurations[boxData.listOfNames.indexOf(data)] + howFullNums[measureNumber - 1] <= boxData.maxFull);
          }
          if (data is int) {
            //
          }
          return false;
        },
        onAccept: (data) {
          setState(() {
            isAccessible = false;
            howFullNums[measureNumber - 1] = boxData.listOfDurations[boxData.listOfNames.indexOf(data)] + howFullNums[measureNumber - 1];
            currentListNums[measureNumber - 1].add(data);
          });
        },
        onLeave: (data) {
        },


      );
    }
  }
}
