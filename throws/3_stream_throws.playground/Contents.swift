enum CustomError: Error {
    case unknown
}

func numberSubscription() -> AsyncThrowingStream<Int, Error> {
    return AsyncThrowingStream { continuation in
        let task = Task {
            var nextNumber = 1
            
            // 一定の値を超えるまで1秒おきに値をインクリメントして流す
            while (nextNumber <= 3) {
                do {
                    try Task.checkCancellation()
                } catch {
                    break
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                continuation.yield(nextNumber)
                nextNumber += 1
            }
            // 3秒を超えたらエラーをスローして終了する
            continuation.finish(throwing: CustomError.unknown)
        }
        
        // returnするAsyncStreamがキャンセルされたら行う処理
        continuation.onTermination = { termination in
            print(termination)
            task.cancel()
        }
    }
}

let task = Task {
    // 1秒おきに流れていくる値を出力
    do {
        for try await value in numberSubscription() {
            print(value)
        }
        print("never reached by error")
    } catch {
        print(error)
    }
}

