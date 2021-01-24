class User: Codable
{
    var username: String
    var password: String?
    var ID: Int?
    var points: Int?
}

struct Leaderboard: Codable
{
    let topPlayers: [User]
}
