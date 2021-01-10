part of 'main.dart';


class _FirstPageWidgetState extends State<FirstPage> {
  final Data boxData;
  _FirstPageWidgetState({this.boxData});
  @override
  Widget build(BuildContext context) {
    Function _addRhythm(int index, Data boxData, int measureNumber) {
      return () {
        setState(() {
          isAccessible = true;
          if (boxData.listOfDurations[index] + howFullNums[measureNumber - 1] <= boxData.maxFull) {
            currentListNums[measureNumber - 1].add(boxData.listOfNames[index]);
            howFullNums[measureNumber - 1] += boxData.listOfDurations[index];
          }
        });
      };
    }
    Function _enableAddMeasure() {
      bool isButtonEnabled = (howFullNums.length < 4) && !isAccessible;
      if (isButtonEnabled) {
        return () {
          setState(() {
            howFullNums.add(0);
            currentMeasureNum++;
          });
        };
      }
    }
    Function _enableRemoveMeasure() {
      bool isButtonEnabled = (howFullNums.length > 1) && !isAccessible;
      if (isButtonEnabled) {
        return () {
          setState(() {
            currentListNums[currentMeasureNum - 1] = [];
            boxRhythmNums[currentMeasureNum - 1] = [];
            vibrateRhythmNums[currentMeasureNum - 1] = [250];
            howFullNums.removeAt(currentMeasureNum - 1);
            currentMeasureNum--;
          });
        };
      }
    }
    if (isAccessible) {
      return Scaffold(
        appBar: AppBar(
          title: Text(boxData.boxType + "Box"),
        ),
        body: Column (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container (
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: (boxData.boxHeight - 4)*n,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var index in boxData.listOfContainers)
                          Container (
                            width: boxData.listOfWidths[boxData.listOfContainers.indexOf(index)]*n,
                            height:(boxData.boxHeight - 4)*n,
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(0),
                              onPressed: _addRhythm(boxData.listOfContainers.indexOf(index), boxData, 1),
                              child: Tooltip(message: boxData.listOfNames[boxData.listOfContainers.indexOf(index)],
                                  child: index),
                            ),
                          )
                      ]
                  )
              ),
              Expanded(
                  child: Container(
                    color: Color(0xffe4e1),
                    child: BackgroundWidget(boxData: boxData),
                  )
              ),
            ]// Children
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text('Measure Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/measure');
                },
              ),
              ListTile(
                title: Text('Beat Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/beat');
                },
              ),
              ListTile(
                title: Text('3/4 Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/threeFour');
                },
              ),
              ListTile(
                title: Text('Privacy Policy'),
                onTap: () {
                  Navigator.pushNamed(context, '/privacy');
                },
              ),
              SwitchListTile(
                title: Text('Screen-reader Optimized'),
                value: isAccessible,
                onChanged: (bool value) {
                  setState(() {
                    isAccessible = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(boxData.boxType + " Box"),
        ),
        body: Column (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container (
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: (boxData.boxHeight - 4)*n,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var index in boxData.listOfContainers)
                          Draggable<String>(
                            child: index,
                            feedback: Material(
                              child: index,
                            ),
                            childWhenDragging: index,
                            data: boxData.listOfNames[boxData.listOfContainers.indexOf(index)],
                            affinity: Axis.vertical,
                          )
                      ]
                  )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 80.0,
                      icon: Icon(Icons.add_circle_sharp),
                      color: Colors.red,
                      disabledColor: Colors.grey,
                      onPressed: _enableAddMeasure(),
                      tooltip: "Add Measure",
                    ),
                    IconButton(
                      iconSize: 80.0,
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red,
                      disabledColor: Colors.grey,
                      onPressed: _enableRemoveMeasure(),
                      tooltip: "Remove Measure",
                    ),
                  ]
              ),

              Expanded(
                  child: Container(
                    color: Color(0xffe4e1),
                    child: BackgroundWidget(boxData: boxData),
                  )
              ),
            ]// Children
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text('Measure Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/measure');
                },
              ),
              ListTile(
                title: Text('Beat Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/beat');
                },
              ),
              ListTile(
                title: Text('3/4 Box'),
                onTap: () {
                  Navigator.pushNamed(context, '/threeFour');
                },
              ),
              ListTile(
                title: Text('Privacy Policy'),
                onTap: () {
                  Navigator.pushNamed(context, '/privacy');
                },
              ),
              SwitchListTile(
                title: Text('Screen-reader Optimized'),
                value: isAccessible,
                onChanged: (bool value) {
                  setState(() {
                    isAccessible = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}

class FirstPage extends StatefulWidget{
  final Data boxData;
  FirstPage({this.boxData});
  @override
  _FirstPageWidgetState createState() => _FirstPageWidgetState(boxData: boxData);
  Widget build(BuildContext context) {


  }
}

