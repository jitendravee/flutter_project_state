class MovieModelData {
  double? score;
  Show? show;

  MovieModelData({this.score, this.show});

  MovieModelData.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    show = json['show'] != null ? Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['score'] = this.score;
    if (this.show != null) {
      data['show'] = this.show!.toJson();
    }
    return data;
  }
}

class Show {
  num? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  num? runtime;
  num? averageRuntime;
  String? premiered;
  String? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  num? weight;
  Network? network;
  Map<String, dynamic>? webChannel; // Updated to handle a Map if needed
  String? dvdCountry;
  Externals? externals;
  Image? image;
  String? summary;
  num? updated;
  Links? lLinks;

  Show({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel, // Now expecting a Map<String, dynamic>?
    this.dvdCountry,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.lLinks,
  });

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    genres = List<String>.from(json['genres']);
    status = json['status'];
    runtime = json['runtime'];
    averageRuntime = json['averageRuntime'];
    premiered = json['premiered'];
    ended = json['ended'];
    officialSite = json['officialSite'];
    schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    weight = json['weight'];
    network =
        json['network'] != null ? Network.fromJson(json['network']) : null;
    webChannel = json['webChannel'] != null
        ? json['webChannel']
        : null; // Fix for the webChannel field
    dvdCountry = json['dvdCountry'];
    externals = json['externals'] != null
        ? Externals.fromJson(json['externals'])
        : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    updated = json['updated'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['language'] = language;
    data['genres'] = genres;
    data['status'] = status;
    data['runtime'] = runtime;
    data['averageRuntime'] = averageRuntime;
    data['premiered'] = premiered;
    data['ended'] = ended;
    data['officialSite'] = officialSite;
    if (schedule != null) {
      data['schedule'] = schedule!.toJson();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['weight'] = weight;
    if (network != null) {
      data['network'] = network!.toJson();
    }
    data['webChannel'] = webChannel; // Add webChannel to the JSON output
    data['dvdCountry'] = dvdCountry;
    if (externals != null) {
      data['externals'] = externals!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    data['updated'] = updated;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class Schedule {
  String? time;
  List<String>? days;

  Schedule({this.time, this.days});

  Schedule.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    days = List<String>.from(json['days']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['time'] = time;
    data['days'] = days;
    return data;
  }
}

class Rating {
  num? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['average'] = average;
    return data;
  }
}

class Network {
  num? id;
  String? name;
  Country? country;
  String? officialSite;

  Network({this.id, this.name, this.country, this.officialSite});

  Network.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    officialSite = json['officialSite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['officialSite'] = officialSite;
    return data;
  }
}

class Country {
  String? name;
  String? code;
  String? timezone;

  Country({this.name, this.code, this.timezone});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['code'] = code;
    data['timezone'] = timezone;
    return data;
  }
}

class Externals {
  int? tvrage;
  num? thetvdb;
  String? imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  Externals.fromJson(Map<String, dynamic> json) {
    tvrage = json['tvrage'];
    thetvdb = json['thetvdb'];
    imdb = json['imdb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tvrage'] = tvrage;
    data['thetvdb'] = thetvdb;
    data['imdb'] = imdb;
    return data;
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}

class Links {
  Self? self;
  Previousepisode? previousepisode;

  Links({this.self, this.previousepisode});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    previousepisode = json['previousepisode'] != null
        ? Previousepisode.fromJson(json['previousepisode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (self != null) {
      data['self'] = self!.toJson();
    }
    if (previousepisode != null) {
      data['previousepisode'] = previousepisode!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}

class Previousepisode {
  String? href;
  String? name;

  Previousepisode({this.href, this.name});

  Previousepisode.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    data['name'] = name;
    return data;
  }
}
