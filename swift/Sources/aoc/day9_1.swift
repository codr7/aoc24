class day9_1: IDay {
    var label: String { "day9:1" }
    var path: String { "input9" }

    var files: [Int:(Int, Int)] = [:]
    var fileBlocks: [Int:(Int, Int)] = [:]
    var freeBlocks: [Int:Int] = [:]
    var maxBlock: Int = 0
    
    func parseBlocks(_ data: String) {
        var isFile = true
        
        for i in 0..<data.count {
            let n = Int(String(data[i]))!

            if isFile {
                files[files.count] = (maxBlock, n)
                fileBlocks[maxBlock] = (fileBlocks.count, n)
            } else if n != 0 {
                freeBlocks[maxBlock] = n
            }

            maxBlock += n
            isFile = !isFile
        }
    }

    func moveFile(_ fileId: Int, _ start: Int, _ n: Int) {
        var i = 0
        var rn = n
        
        while i < start {
            if let fb = freeBlocks[i] {
                let s = min(fb, rn)
                fileBlocks[i] = (fileId, s)
                freeBlocks[i] = nil     
                if fb > s { freeBlocks[i+s] = fb - s }
                
                if s == rn {
                    fileBlocks[start] = nil
                    break
                }

                rn -= s
                fileBlocks[start] = (fileId, rn)
                i += s
            } else {
                i += 1
            }
        }
    }

    func moveFiles() {
        for i in stride(from: maxBlock-1,
                        through: 0,
                        by: -1) {
            if let f = fileBlocks[i] { moveFile(f.0, i, f.1) }
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
        moveFiles()
        return checksum()
    }
}
