class System {
  int? id;
  String title;

  System({this.id, required this.title});

  factory System.fromMap(Map<String, dynamic> map) {
    return System(
      id: map['id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class Category {
  int? id;
  String title;

  Category({this.id, required this.title});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class SubCategory {
  int? id;
  int? categoryId;
  String title;

  SubCategory({this.id, required this.categoryId, required this.title});

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'],
      categoryId: map['categoryId'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
    };
  }
}

class Character {
  int? id;
  String title;
  int level;
  int systemId;
  System? system;
  Character({
    this.id,
    required this.title,
    required this.level,
    required this.systemId,
    this.system,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      title: map['title'],
      level: map['level'],
      systemId: map['systemId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'level': level,
      'systemId': systemId,
    };
  }

  injectSystem(System s) {
    this.system = s;
  }
}

class Compendium {
  int? id;
  String title;
  int categoryId;
  int subCategoryId;
  Category? category;
  SubCategory? subCategory;
  Compendium({
    this.id,
    required this.title,
    required this.categoryId,
    required this.subCategoryId,
    this.category,
    this.subCategory,
  });

  factory Compendium.fromMap(Map<String, dynamic> map) {
    return Compendium(
      id: map['id'],
      title: map['title'],
      categoryId: map['categoryId'],
      subCategoryId: map['subCategoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
    };
  }
}
