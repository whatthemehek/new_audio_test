part of 'main.dart';

class BackgroundWidget extends StatefulWidget {
  @override
  //BackgroundWidget({Key key}) : super(key: key);
  final Data boxData;
  BackgroundWidget({this.boxData});
  _BackgroundWidgetState createState() => _BackgroundWidgetState(boxData: boxData);
  Widget build(BuildContext context) {

  }
}


class _BackgroundWidgetState extends State<BackgroundWidget> {
  final Data boxData;
  _BackgroundWidgetState({this.boxData});
  @override

  Widget build(BuildContext context) {
    return Container (
      child: DragTarget<List<int>>
        (builder: (BuildContext context, List<List<int>> incoming, List rejected) {
        return Column (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < howFullNums.length; i++)
                      Center (
                        child: MeasureBoxWidget(boxData: boxData, measureNumber: 1 + i, duration: 1000),
                      )
                  ]
              ),
              Expanded(
                child: Container (
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 50.0,
                  ),
                )
              )
            ]
        );
      },

          onAccept: (data) {
            setState(() {
              successfulDropNums[data[1]] = true;
              howFullNums[data[1]] = howFullNums[data[1]] - boxData.listOfDurations[boxData.listOfNames.indexOf(currentListNums[data[1]][data[0]])];
              currentListNums[data[1]].removeAt(data[0]);
            });
          },
          onLeave: (data) {

          }
      ),
    );
  }
}