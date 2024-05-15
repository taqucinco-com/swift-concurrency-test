import Foundation

func asyncFunc() async -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    return "first - 3s"
}

let asyncClosure = { @Sendable () async -> String in
    return await asyncFunc()
}

Task {
    Task { @MainActor in
        print("現在のスレッドはmain: \(Thread.current)")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
    Task(priority: .background) {
        print("現在のスレッドはnot main: \(Thread.current)")
        let first = await asyncClosure()
        print(first)
        print("finish")
    }
}
