class Planet {
  final int _id;
  final String _name;
  final double _mass;

  Planet(this._id, this._name, this._mass);

  int get id => _id;
  String get name => _name;
  double get mass => _mass;

  @override
  String toString() {
    return 'Universe{id: $_id, name: $_name, mass: $_mass}';
  }
}