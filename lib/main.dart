import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DragBox(
            Offset(0.0, 0.0),
            Size(100.0, 100.0),
            const Text(
              'Box One',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
            Colors.blueAccent),
        DragBox(
            Offset(200.0, 0.0),
            Size(100.0, 100.0),
            const Text(
              'Box Two',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
            Colors.orange),
        DragBox(
            Offset(300.0, 0.0),
            Size(100.0, 100.0),
            const Text(
              'Box Three',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
            Colors.lightGreen),
        DragBox(
            Offset(100.0, 500.0),
            Size(200.0, 200.0),
            DragTarget(
              onAccept: (Color color) {
                caughtColor = color;
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color:
                        accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Text("Drag Here!"),
                  ),
                );
              },
            ),
            Colors.transparent),
      ],
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final Size boxSize;
  final Widget childWidget;
  final Color itemColor;

  DragBox(this.initPos, this.boxSize, this.childWidget, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: LongPressDraggable(
          data: widget.itemColor,
          child: Container(
            width: widget.boxSize.width,
            height: widget.boxSize.height,
            color: widget.itemColor,
            child: Center(
              child: widget.childWidget,
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: widget.boxSize.width * 1.1,
            height: widget.boxSize.width * 1.1,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: widget.childWidget,
            ),
          ),
        ));
  }
}
