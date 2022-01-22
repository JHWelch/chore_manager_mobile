abstract class Factory<T> {
  Map<String, dynamic> properties = {};

  T build();

  List<T> listOf(int times) {
    final List<T> list = [];
    for (var i = 0; i < times; i++) {
      list.add(build());
    }
    return list;
  }

  Factory<T> state(Map<String, dynamic> properties) {
    this.properties = {
      ...this.properties,
      ...properties,
    };

    return this;
  }
}
