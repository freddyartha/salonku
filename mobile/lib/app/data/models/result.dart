sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final String? message;
  final T data;
  final Meta? meta;

  const Success(this.data, {this.message, this.meta});
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"] ?? 0,
    from: json["from"] ?? 0,
    lastPage: json["last_page"] ?? 0,
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"].toString(),
    perPage: json["per_page"] ?? 0,
    to: json["to"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"].toString(),
    label: json["label"].toString(),
    active: json["active"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class Error<T> extends Result<T> {
  final String? message;
  final int? statusCode;
  final Map<String, dynamic>? errors;
  const Error(this.message, {this.statusCode, this.errors});
}

class Loading<T> extends Result<T> {
  const Loading();
}

class Cancelled<T> extends Result<T> {
  const Cancelled();
}
