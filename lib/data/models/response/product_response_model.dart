import 'dart:convert';

class ProductsResponseModel {
    int? id;
    String? title;
    int? price;
    String? description;
    List<String>? images;
    DateTime? creationAt;
    DateTime? updatedAt;
    Category? category;

    ProductsResponseModel({
        this.id,
        this.title,
        this.price,
        this.description,
        this.images,
        this.creationAt,
        this.updatedAt,
        this.category,
    });

    factory ProductsResponseModel.fromJson(String str) => ProductsResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductsResponseModel.fromMap(Map<String, dynamic> json) => ProductsResponseModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category?.toMap(),
    };
}

class Category {
    int? id;
    Name? name;
    String? image;
    DateTime? creationAt;
    DateTime? updatedAt;

    Category({
        this.id,
        this.name,
        this.image,
        this.creationAt,
        this.updatedAt,
    });

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        image: json["image"],
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": nameValues.reverse[name],
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

enum Name {
    CLOTHES,
    SHOES
}

final nameValues = EnumValues({
    "Clothes": Name.CLOTHES,
    "Shoes": Name.SHOES
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
