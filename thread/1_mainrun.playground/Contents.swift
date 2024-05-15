import Foundation

func asyncFunc() async -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    return "first - 3s"
}

let asyncClosure = { @Sendable () async -> String in
    return await asyncFunc()
}

let closure = { @Sendable () -> String in
    return "sync now"
}

Task {
    
    // メインスレッドで実行される
    Task { @MainActor in
        print("現在のスレッド: \(Thread.current)")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
    
    Task {
        print("現在のスレッド: \(Thread.current)")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
    
    // コンパイルできません
//    MainActor.run {
//        async let first = firstClosure()
//        
//        print(await first)
//        print("finish")
//    }
    
    // MainActor.runで呼び出せるのは同期関数
    await MainActor.run {
        print("現在のスレッド: \(Thread.current)")
        let ret = closure()

        print(ret)
        print("finish")
    }
}

// メインスレッドで実行される
Task { @MainActor in
    Task {
        print("メインのTaskから派生したスレッド: \(Thread.current)")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
}
