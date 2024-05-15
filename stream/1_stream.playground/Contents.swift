// キャンセルを無視してStreamを実装

func numberSubscription() -> AsyncStream<Int> {
    return AsyncStream { continuation in
        Task {
            var nextNumber = 1
            // 一定の値を超えるまで1秒おきに値をインクリメントして流す
            while (nextNumber <= 5) {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                continuation.yield(nextNumber)
                nextNumber += 1
            }
            print("finished")
            continuation.finish()
        }
    }
}

Task {
    // 1秒おきに流れていくる値を出力
    for await value in numberSubscription() {
        print(value)
    }
    print("finish")
}
