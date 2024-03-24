import 'dart:io';
import 'dart:math';

// Interface for shapes
abstract class Shape {
  double volume();
}

// Base class for shapes
class Geometry {
  String name;
  Geometry(this.name);
}

// Class representing a cube
class Cube extends Geometry implements Shape {
  double sideLength;

  Cube(String name, this.sideLength) : super(name);

  @override
  double volume() {
    return sideLength * sideLength * sideLength;
  }
}

// Class representing a sphere
class Sphere extends Geometry implements Shape {
  double radius;

  Sphere(String name, this.radius) : super(name);

  @override
  double volume() {
    return (4 / 3) * pi * pow(radius, 3);
  }
}

// Class representing a cylinder
class Cylinder extends Geometry implements Shape {
  double radius;
  double height;

  Cylinder(String name, this.radius, this.height) : super(name);

  @override
  double volume() {
    return pi * pow(radius, 2) * height;
  }
}

// Class representing a geometric calculator
class VolumeCalculator {
  List<Shape> shapes = [];

  // Method to add a shape to the calculator
  void addShape(Shape shape) {
    shapes.add(shape);
  }

  // Method to calculate the total volume of all shapes
  double totalVolume() {
    double total = 0;
    for (var shape in shapes) {
      total += shape.volume();
    }
    return total;
  }
}

// Main function
void main() {
  // Initialize shapes from a file
  var shapesFromFile = initializeShapesFromFile('shapes.txt');

  // Create a GeometryCalculator instance
  var calculator = VolumeCalculator();

  // Add shapes to the calculator
  for (var shape in shapesFromFile) {
    calculator.addShape(shape);
  }

  // Calculate the total volume
  var totalVolume = calculator.totalVolume();
  print('Total volume of all shapes: $totalVolume');
}

// Method to initialize shapes from a file
List<Shape> initializeShapesFromFile(String fileName) {
  var shapes = <Shape>[];
  var file = File(fileName);
  var lines = file.readAsLinesSync();
  for (var line in lines) {
    var parts = line.split(',');
    var shapeName = parts[0].trim();
    if (shapeName == 'cube') {
      var sideLength = double.parse(parts[1]);
      var cube = Cube(shapeName, sideLength);
      shapes.add(cube);
    } else if (shapeName == 'sphere') {
      var radius = double.parse(parts[1]);
      var sphere = Sphere(shapeName, radius);
      shapes.add(sphere);
    } else if (shapeName == 'cylinder') {
      var radius = double.parse(parts[1]);
      var height = double.parse(parts[2]);
      var cylinder = Cylinder(shapeName, radius, height);
      shapes.add(cylinder);
    }
  }
  return shapes;
}
