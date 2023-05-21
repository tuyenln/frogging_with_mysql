// ignore_for_file: public_member_api_docs

class PackageModel {
  const PackageModel({
    this.id,
    this.name,
    this.description,
    this.price,
  });

  // fromJSON
  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
    );
  }

  // Create an PackageModel given a row.assoc() map
  factory PackageModel.fromRowAssoc(Map<String, String?> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }

  // toJSON
  Map<String, dynamic> toJson() {
    return {
      'id': int.parse(id!),
      'name': name.toString(),
      'description': description.toString(),
      'price': price.toString(),
    };
  }

  final String? name;
  final String? description;
  final String? price;
  final String? id;
}
