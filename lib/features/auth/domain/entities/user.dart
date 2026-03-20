class User {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});
}

//What this is:
//  The entity is the core business object. It has no JSON parsing, no annotations, no Flutter imports — just the data that matters to
//   the domain. Everything else (API responses, DB rows) will eventually map to this.
