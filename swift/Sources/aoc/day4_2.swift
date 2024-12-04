class day4_2: day4_1 {
    override var label: String { "day4:2" }
    override var word: String { "MAS" }

    override func countWords(_ start: (Int, Int)) -> Int {
        if (countWord((start.0-1, start.1+1), (1, -1)) +
              countWord((start.0-1, start.1-1), (1, 1)) +
              countWord((start.0+1, start.1+1), (-1, -1)) +
              countWord((start.0+1, start.1-1), (-1, 1))) > 1 { 1 }
        else { 0 }
    }
}
