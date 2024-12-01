protocol IDay {
    var label: String {get}
    var path: String {get}
    func read() throws -> [String]
    func pipeline() throws -> Int
}

extension IDay {
    func read() throws -> [String] { try readLines("../\(path)").map({String($0)}) }
    func run() throws { print("\(label) \(try pipeline())") }
}


