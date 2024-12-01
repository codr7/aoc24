import Foundation

struct XY: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    var description: String {"\(x):\(y)"}

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

typealias Box = Set<XY>

extension Box {
    func intersects(_ other: Set<XY>) -> Bool { !isDisjoint(with: other) }
}

func box(_ lt: (Int, Int), _ rb: (Int, Int)) -> Box {
    var b: Box = []
    
    for x in lt.0..<rb.0+1 {
        for y in lt.1..<rb.1+1 {
            if x >= 0 && y >= 0 { b.insert(XY(x, y)) }
        }
    }
    
    return b
}

extension RawRepresentable {
    var description: String { "\(rawValue)" }
}

public protocol OptionalType: ExpressibleByNilLiteral {
    associatedtype WrappedType
    var asOptional: WrappedType? { get }
}

extension Optional: OptionalType {
    public var asOptional: Wrapped? {
        return self
    }
}

func readLines(_ path: String) throws -> [String.SubSequence] {
    try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
      .filter({$0 != "\r"})
      .split(separator: "\n")
}

extension [Int] {
    var sum: Int { self.reduce(0, {(x:Int, y:Int) in x+y}) }
    var product: Int { self.reduce(1, {(x:Int, y:Int) in x*y}) }
}

extension Array where Element: OptionalType {
    var forced: [Element.WrappedType] { map({$0.asOptional!}) }
    var non_nil: [Element] { filter({$0.asOptional != nil}) }
}

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }

    func parseInt(_ i: String.Index, _ j: String.Index) -> Int {
        Int(self[i..<j])!
    }

    func parseInt(_ i: Int, _ j: Int) -> Int {
        parseInt(index(startIndex, offsetBy: i), index(startIndex, offsetBy: j))
    }

    func search(_ it: String) -> Range<String.Index>? {
        self.range(of: it)
    }

    func rsearch(_ it: String) -> Range<String.Index>? {
        self.range(of: it, options: [.backwards])
    }
}
