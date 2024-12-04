class day4_1: IDay {
    var label: String { "day4:1" }
    var path: String { "input4" }

    var word: String { "XMAS" }
    var data: [String] = []
    var steps = [(1, 0), (0, 1), (-1, 0), (0, -1), (1, 1), (-1, -1), (1, -1), (-1, 1)]
    
    func parseLine(_ line: String) { data.append(line) }

    func countWord(_ start: (Int, Int), _ step: (Int, Int)) -> Int {
        var li = start.0
        var ci = start.1
        
        for i in 0..<word.count {            
            if li < 0 || li >= data.count || ci < 0 || ci >= data[li].count ||
                 data[li][ci] != word[i] {
                return 0
            }
            
            li += step.0
            ci += step.1
        }

        return 1
    }

    func countWords(_ start: (Int, Int)) -> Int {
        steps.map({countWord(start, $0)}).sum
    }
    
    func countWords(_ line: Int) -> Int {
        (0..<data[line].count).map({countWords((line, $0))}).sum
    }
    
    func pipeline() throws -> Int {
        try read().forEach(parseLine)
        return (0..<data.count).map(countWords).sum
    }
}
