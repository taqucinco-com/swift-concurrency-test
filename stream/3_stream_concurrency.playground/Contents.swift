func numberSubscription() -> AsyncStream<Int> {
    return AsyncStream { continuation in
        let task = Task {
            var nextNumber = 1
            
            // 一定の値を超えるまで1秒おきに値をインクリメントして流す
            while (nextNumber < 10) {
                do {
                    try Task.checkCancellation()
                } catch {
                    break
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                continuation.yield(nextNumber)
                nextNumber += 1
            }
            print("finished")
            continuation.finish()
        }
        
        // returnするAsyncStreamがキャンセルされたら行う処理
        continuation.onTermination = { termination in
            print(termination)
            task.cancel()
        }
    }
}

Task {
    let one = Task {
        for await value in numberSubscription() {
            print("subscribe by one \(value)")
        }
        print("one finish")
    }

    let two = Task {
        for await value in numberSubscription() {
            print("subscribe by two \(value)")
        }
        print("two finish")
    }
    
    // 5秒後にキャンセルする
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    one.cancel()
    two.cancel()
}
