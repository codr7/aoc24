class day5_2: day5_1 {
    override var label: String { "day5:2" }
    
    func reorder(_ update: Update) -> Update {
        var result = update
        var done = false
        
        while !done {
            done = true
            
            for (x, y) in rules {
                if let i = result.firstIndex(of: x),
                   let j = result.firstIndex(of: y),
                   j < i {
                    result.swapAt(i, j)
                    done = false
                }
            }
        }

        return result
    }
    
    override func pipeline() throws -> Int {
        try parseLines()
        return updates.filter({!isOrdered($0)}).map({reorder($0)[$0.count/2]}).sum
    }
}
