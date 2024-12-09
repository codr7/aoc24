class day9_1: IDay {
    var label: String { "day9:1" }
    var path: String { "input9" }

    var files: [Int:(Int, Int)] = [:]
    var fileBlocks: [Int:(Int, Int)] = [:]
    var freeBlocks: [(Int, Int)] = []
    var maxBlock: Int = 0
    
    func parseBlocks(_ data: String) {
        var isFile = true
        
        for i in 0..<data.count {
            let n = Int(String(data[i]))!

            if isFile {
                let id = files.count
                files[id] = (maxBlock, n)
                fileBlocks[maxBlock] = (id, n)
            } else if n != 0 {
                freeBlocks.append((maxBlock, n))
            }

            maxBlock += n
            isFile = !isFile
        }
    }

    func moveBlocks(_ fileId: Int, _ start: Int, _ n: Int) {
        var rn = n

        while rn > 0 && !freeBlocks.isEmpty {
            let fb = freeBlocks.removeLast()
            if fb.0 > start { break }
            let s = min(fb.1, rn)
            fileBlocks[fb.0] = (fileId, s)
            if fb.1 > s { freeBlocks.append((fb.0+s, fb.1 - s)) }
            rn -= s
            
            if rn == 0 {
                fileBlocks[start] = nil
                break
            }
            
            fileBlocks[start] = (fileId, rn)
        }
    }

    func moveFiles() {
        for i in stride(from: maxBlock-1,
                        through: 0,
                        by: -1) {
            if let f = fileBlocks[i] { moveBlocks(f.0, i, f.1) }
        }
    }

    func checksum() -> Int {
        var i = 0
        var result = 0
        
        while i < maxBlock {
            if let f = fileBlocks[i] {
                for _ in 0..<f.1 {
                    result += i * f.0
                    i += 1
                }  
            } else {
                i += 1
            }
        }

        return result
    }
    
    func pipeline() throws -> Int {
        let d = try read()[0]
        parseBlocks(d)
        freeBlocks.reverse()
        //draw()
        moveFiles()
        //draw()
        return checksum()
    }

    func draw() {
        var result = ""
        var i = 0
        
        while i < maxBlock {
            if let fb = fileBlocks[i] {
                for _ in 0..<fb.1 { result += String(fb.0) }
                i += fb.1
            } else {
                result += "."
                i += 1
            }
        }

        print(result)
    }
}
