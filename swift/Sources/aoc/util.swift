import Foundation

struct P<T: Equatable & Hashable>: Equatable, Hashable, CustomStringConvertible {
    static func ==(_ l: P<T>, _ r: P<T>) -> Bool { l.x == r.x && l.y == r.y }
      
    let x: T
    let y: T
    
    var description: String {"\(x):\(y)"}

    init(_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
}

struct XY: Hashable, CustomStringConvertible {
    static func +=(_ l: inout XY, _ r: XY) {
        l.x += r.x
        l.y += r.y
    }

    static func -=(_ l: inout XY, _ r: XY) {
        l.x -= r.x
        l.y -= r.y
    }

    static func -(_ l: XY, _ r: XY) -> XY {
        var result = l
        result -= r
        return result
    }

    var x: Int
    var y: Int

    var description: String {"\(x):\(y)"}

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

func slope(_ l: XY, _ r: XY) -> XY { XY(r.x - l.x, r.y - l.y) }

struct XYZ: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    let z: Int
    
    var description: String {"\(x):\(y):\(z)"}

    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
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
      .split(separator: "\r\n")
}

extension Array where Element: Numeric {
    var sum: Element { self.reduce(0, {(x:Element, y:Element) in x+y}) }
    var product: Element { self.reduce(1, {(x:Element, y:Element) in x*y}) }
}

extension Array where Element: OptionalType {
    var forced: [Element.WrappedType] { map({$0.asOptional!}) }
    var non_nil: [Element] { filter({$0.asOptional != nil}) }
}

extension Substring {
    subscript(i: Int) -> Character {
        get {
            self[index(startIndex, offsetBy: i)]
        }
    }
}

extension String {
    subscript(i: Int) -> Character {
        get {
            self[index(startIndex, offsetBy: i)]
        }
    }

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

    func splitOnce(_ separator: Element) -> (String, String) {
        let ps = split(separator: separator, maxSplits: 1)
        return (String(ps[0]), String(ps[1]))
    }

    func split(_ separator: String) -> [String] {
        split(separator: separator).map({String($0)})
    }
    
    func slice(_ from: Int, _ to: Int) -> String {
        let i = self.index(self.startIndex, offsetBy: from)
        let j = self.index(self.startIndex, offsetBy: to)
        return String(self[i..<j])
    }
    
    var int: Int { Int(trimmed)! }

    func firstMatch<T>(of: [Regex<T>]) -> Regex<T>.Match? {
        var ms = of
          .map(firstMatch)
          .filter({$0 != nil })
          .map({$0!})
        
        if ms.isEmpty { return nil }
        ms.sort(by: {(x, y) in x.range.lowerBound < y.range.lowerBound})
        return ms[0]
    }
}

extension Int {
    var sign: Int { (self < 0) ? -1 : 1 }
}

func cosineSimilarity(_ a: [Float], _ b: [Float]) -> Float {
    let dp = zip(a, b).map({$0.0*$0.1}).sum
    if dp == 0 { return 0 }
    let na = pow(a.map({$0*$0}).sum, 0.5)
    if na == 0 { return 1 }
    let nb = pow(b.map({$0*$0}).sum, 0.5)
    if nb == 0 { return 1 }
    return dp / (na*nb)
}

enum Order {
    case equal, greater, less
}

typealias Compare<T> = (T, T) -> Order

func defaultCompare<T: Comparable>(_ l: T, _ r: T) -> Order {
    if l < r {
        .less
    } else if l > r {
        .greater
    } else {
        .equal
    }
}

class PriorityQueue<T> {
    let compare: Compare<T>
    var items: [T] = []

    init(_ compare: @escaping Compare<T> = defaultCompare) where T: Comparable {
        self.compare = compare
    }

    func index(_ it: T) -> Int {
        var min = 0
        var max = items.count
        
        while min < max {
            let i = (min + max) / 2
            
            switch compare(it, items[i]) {
            case .equal:
                return i 
            case .greater:
                max = i
            case .less:
                min = i + 1
            }
        }
        
        return min
    }

    func push(_ it: T) { items.insert(it, at: index(it)) }    
    func pop() -> T? { items.isEmpty ? nil : items.removeLast() }
}

func firstPermutation<T>(_ values: [T], _ current: inout [T], _ n: Int,
                         where pred: (_ v: [T]) -> Bool) -> [T]? {
    if current.count == n { return pred(current) ? current : nil }
    
    for v in values {
        current.append(v)
        if let r = firstPermutation(values, &current, n, where: pred) { return r }
        current.removeLast()
    }

    return nil
}

@discardableResult
func firstPermutation<T>(_ values: [T], _ n: Int,
                         where pred: (_ v: [T]) -> Bool) -> [T]? {
    var current: [T] = []
    return firstPermutation(values, &current, n, where: pred)
}

func pairs<T: Hashable>(_ values: [T]) -> [(T, T)] {
    var result: Set<P<T>> = []
    
    firstPermutation(values, 2, where: {v in
                                         let (l, r) = (v[0], v[1])
                                         
                                         if l != r && !result.contains(P(r, l)) {
                                             result.insert(P(l, r))
                                         }
                                         
                                         return false
                                     })

    return Array(result.map({($0.x, $0.y)}))
}

extension Int {
    var squared: Int { self * self }
}

func mdist(_ from: XY, _ to: XY) -> Int { abs(from.x - to.x) + abs(from.y - to.y) }

func edist(_ from: XY, _ to: XY) -> Int {
    Int(Double((to.x-from.x).squared + (to.y - from.y).squared).squareRoot())
}
