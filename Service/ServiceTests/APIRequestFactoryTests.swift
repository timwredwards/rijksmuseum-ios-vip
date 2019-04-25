
import XCTest
import TestingUtils
@testable import Service

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
}

extension APIRequestFactoryTests {
    func test_createRequest() {
        let request = sut.createRequest(fromAPIEndpoint: .art)
        XCTAssertEqual(request.path, "/collection")
        XCTAssertEqual(request.queryItems.count, 3)
    }
}
