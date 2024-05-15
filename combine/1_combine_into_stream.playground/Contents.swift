import Combine

let intSubject = CurrentValueSubject<Int, Never>(0)

func numberSubscription() -> AsyncStream<Int> {
    return AsyncStream { continuation in
        Task {
            let cancellable = intSubject.sink(
                receiveCompletion: { _ in
                    continuation.finish()
                },
                receiveValue: {
                    continuation.yield($0)
                }
            )
            continuation.onTermination = { termination in
                print(termination)
                cancellable.cancel()
            }
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

Task {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    intSubject.send(1)
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    intSubject.send(2)
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    intSubject.send(3)
    intSubject.send(completion: .finished)
}

