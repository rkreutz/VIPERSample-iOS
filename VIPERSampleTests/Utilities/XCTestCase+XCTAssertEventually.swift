import XCTest

private enum Constants {

    static let timeout: TimeInterval = 1.0
    static let pollInterval: TimeInterval = 0.001
}

extension XCTestCase {

    func XCTAssertEventually(
        _ expression: @escaping () -> Bool,
        timeout: TimeInterval = Constants.timeout,
        pollInterval: TimeInterval = Constants.pollInterval,
        _ message: @escaping @autoclosure () -> String = "Assertion expression timed out.",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {

        let expectation = self.expectation(description: "XCTAssertEventually")

        let assertionOperation = ExpressionOperation(expression, pollInterval: pollInterval)
        assertionOperation.completionBlock = expectation.fulfill

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperation(assertionOperation)

        // Ignore UTs fail from here, waitForExpectations(_:_:) shows errors on XCode and there is no way to
        // avoid that, so we also show an error where the issue actually is, so go check other errors if
        // Xcode complaints about the following line.
        waitForExpectations(timeout: timeout) { error in

            guard error != nil else { return }
            XCTFail(message(), file: file, line: line)
            queue.cancelAllOperations()
        }
    }
}


private final class ExpressionOperation: Operation {

    private let expression: () -> Bool
    private let pollInterval: TimeInterval

    init(_ expression: @escaping () -> Bool, pollInterval: TimeInterval) {

        self.expression = expression
        self.pollInterval = pollInterval
    }

    override func main() {

        while !expression() && !isCancelled {

            Thread.sleep(forTimeInterval: pollInterval)
        }
    }
}
