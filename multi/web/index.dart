import 'dart:html';
import 'dart:math';

class CanvasDrawer {
  static const List<String> colors = const [
      "red", "green", "yellow", "blue", "magenta", "orangered"];
  CanvasElement canvas;
  CanvasRenderingContext2D ctxt;
  Rectangle offset;
  Map<int, Map> lines = {};

  CanvasDrawer(this.canvas) {
    ctxt = canvas.getContext('2d');
    canvas.width = canvas.offsetWidth;
    canvas.style.width = '100%';
    canvas.width = canvas.offsetWidth;
    canvas.style.width = '';

    ctxt.lineWidth = (new Random().nextDouble() * 35).ceil();
    ctxt.lineCap = "round";
    offset = canvas.offset;

    canvas.onTouchStart.listen(preDraw);
    canvas.onTouchMove.listen(draw);
  }

  preDraw(TouchEvent event) {
    event.preventDefault();
    event.touches.forEach((touch) {
      lines[touch.identifier] = {
          'x'    : touch.page.x - offset.left,
          'y'    : touch.page.y - offset.top,
          'color' : colors[new Random().nextInt(colors.length)]
      };
    });
  }

  draw(TouchEvent event) {
    event.preventDefault();
    event.touches.forEach((touch) {
      var _id = touch.identifier;
      var ret = move(
          _id,
          touch.page.x - offset.left - lines[_id]['x'],
          touch.page.y - offset.top - lines[_id]['y']);
      lines[_id]['x'] = ret['x'];
      lines[_id]['y'] = ret['y'];
    });
  }

  move(_id, changeX, changeY) {
    ctxt.strokeStyle = lines[_id]['color'];
    ctxt.beginPath();
    ctxt.moveTo(lines[_id]['x'], lines[_id]['y']);
    ctxt.lineTo(lines[_id]['x'] + changeX, lines[_id]['y'] + changeY);
    ctxt.stroke();
    ctxt.closePath();
    return { 'x': lines[_id]['x'] + changeX, 'y': lines[_id]['y'] + changeY };
  }
}

void main() {
  var canvas = querySelector('#example');
  CanvasDrawer canvasDrawer = new CanvasDrawer(canvas);
}