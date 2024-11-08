class GitRepoModel {
  String? url;
  String? forksUrl;
  String? commitsUrl;
  String? id;
  String? nodeId;
  String? gitPullUrl;
  String? gitPushUrl;
  String? htmlUrl;
  Files? files;
  bool? public;
  String? createdAt;
  String? updatedAt;
  String? description;
  int? comments;
  Null? user;
  String? commentsUrl;
  Owner? owner;
  bool? truncated;

  GitRepoModel(
      {this.url,
      this.forksUrl,
      this.commitsUrl,
      this.id,
      this.nodeId,
      this.gitPullUrl,
      this.gitPushUrl,
      this.htmlUrl,
      this.files,
      this.public,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.comments,
      this.user,
      this.commentsUrl,
      this.owner,
      this.truncated});

  GitRepoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    forksUrl = json['forks_url'];
    commitsUrl = json['commits_url'];
    id = json['id'];
    nodeId = json['node_id'];
    gitPullUrl = json['git_pull_url'];
    gitPushUrl = json['git_push_url'];
    htmlUrl = json['html_url'];
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    comments = json['comments'];
    user = json['user'];
    commentsUrl = json['comments_url'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    truncated = json['truncated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['forks_url'] = this.forksUrl;
    data['commits_url'] = this.commitsUrl;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['git_pull_url'] = this.gitPullUrl;
    data['git_push_url'] = this.gitPushUrl;
    data['html_url'] = this.htmlUrl;
    if (this.files != null) {
      data['files'] = this.files!.toJson();
    }
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    data['comments'] = this.comments;
    data['user'] = this.user;
    data['comments_url'] = this.commentsUrl;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['truncated'] = this.truncated;
    return data;
  }
}

class Files {
  Gistfile1Txt? gistfile1Txt;

  Files({this.gistfile1Txt});

  Files.fromJson(Map<String, dynamic> json) {
    gistfile1Txt = json['gistfile1.txt'] != null
        ? new Gistfile1Txt.fromJson(json['gistfile1.txt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gistfile1Txt != null) {
      data['gistfile1.txt'] = this.gistfile1Txt!.toJson();
    }
    return data;
  }
}

class Gistfile1Txt {
  String? filename;
  String? type;
  String? language;
  String? rawUrl;
  int? size;

  Gistfile1Txt(
      {this.filename, this.type, this.language, this.rawUrl, this.size});

  Gistfile1Txt.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    type = json['type'];
    language = json['language'];
    rawUrl = json['raw_url'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['type'] = this.type;
    data['language'] = this.language;
    data['raw_url'] = this.rawUrl;
    data['size'] = this.size;
    return data;
  }
}

class Owner {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  String? userViewType;
  bool? siteAdmin;

  Owner(
      {this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.userViewType,
      this.siteAdmin});

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    userViewType = json['user_view_type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['user_view_type'] = this.userViewType;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}
