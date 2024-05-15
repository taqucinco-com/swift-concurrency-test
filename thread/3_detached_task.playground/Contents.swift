import Foundation

func asyncFunc() async -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    return "first - 3s"
}

let asyncClosure = { @Sendable () async -> String in
    return await asyncFunc()
}

Task {
    // 上２つは同じコンテキストで実行される
    Task {
        let label = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
        print("Current DispatchQueue label: \(label ?? "unknown")")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
    
    Task {
        let label = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
        print("Current DispatchQueue label: \(label ?? "unknown")")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
    
    // 上２つとは別のコンテキストで実行される
    Task.detached {
        let label = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
        print("Current DispatchQueue label: \(label ?? "unknown")")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
}
