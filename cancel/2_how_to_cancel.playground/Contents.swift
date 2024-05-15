func loopFunc() async -> String {
    for i in 1...10 {
        /// 以下のどちらをコメントアウト&アンコメント
        
        // フラグを見るか
//        if Task.isCancelled { return "\(i) index loop canceled" }
        
        // キャンセルエラーを明示的にスローする
        do {
            try Task.checkCancellation()
        } catch {
            print(error)
            return "\(i) index loop canceled"
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("\(i).0s passed")
    }
    return "1.0sec x 10times loop finish"
}

let task = Task {
    let result = await loopFunc()
    print(result)
    print("finish")
}
Task {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    task.cancel()
}
