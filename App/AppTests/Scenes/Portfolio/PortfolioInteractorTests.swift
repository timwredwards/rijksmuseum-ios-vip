
import XCTest
import Service
import Utils
@testable import Rijksmuseum

class PortfolioInteractorTests: XCTestCase {
    var sut: PortfolioInteractor!
    var outputMock: OutputMock!
    var artServiceMock: ArtServiceMock!
    override func setUp() {
        super.setUp()
        outputMock = OutputMock()
        artServiceMock = ArtServiceMock()
        sut = PortfolioInteractor(output: outputMock,
                                  artService: artServiceMock)
    }
}

extension PortfolioInteractorTests {
    class OutputMock: PortfolioInteractorOutput {
        var presentFetchArt_loading_invocations = 0
        var presentFetchArt_loaded_invocations = 0
        var presentFetchArt_loaded_value:[Art]?
        var presentFetchArt_error_invocations = 0
        var presentFetchArt_error_value:Error?
        func presentFetchArt(response: Portfolio.FetchArt.Response) {
            switch response.state {
            case .loading:
                presentFetchArt_loading_invocations += 1
            case .loaded(let arts):
                presentFetchArt_loaded_invocations += 1
                presentFetchArt_loaded_value = arts
            case .error(let error):
                presentFetchArt_error_invocations += 1
                presentFetchArt_error_value = error
            }
        }
    }

    class ArtServiceMock: ArtService {
        var active = true
        var artSeed = [Seeds.Model.ArtSeed()]
        var errorSeed = Seeds.ErrorSeed.generic
        var fetchArt_invocations = 0
        func fetchArt(completion: @escaping (Result<[Art]>) -> Void) {
            fetchArt_invocations += 1
            if active == true {
                completion(.success(artSeed))
            } else {
                completion(.failure(errorSeed))
            }
        }
    }
}

extension PortfolioInteractorTests {
    func test_performFetchArt(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
    }

    func test_performFetchArt_presenter_loading(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loading_invocations == 1)
    }

    func test_performFetchArt_service(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(artServiceMock.fetchArt_invocations == 1)
    }

    func test_performFetchArt_presenter_loaded(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loaded_invocations == 1)
    }

    func test_performFetchArt_presenter_loaded_value(){
        // given
        let request = Portfolio.FetchArt.Request()
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_loaded_value?.count == 1)
        let value = outputMock.presentFetchArt_loaded_value?.first
        let castValue = value as! Seeds.Model.ArtSeed
        XCTAssert(castValue === artServiceMock.artSeed.first)
    }

    func test_performFetchArt_presenter_error(){
        // given
        let request = Portfolio.FetchArt.Request()
        artServiceMock.active = false
        // when
        sut.performFetchArt(request: request)
        // then
        XCTAssert(outputMock.presentFetchArt_error_invocations == 1)
    }

    func test_performFetchArt_presenter_error_value(){
        // given
        let request = Portfolio.FetchArt.Request()
        artServiceMock.active = false
        // when
        sut.performFetchArt(request: request)
        // then
        let value = outputMock.presentFetchArt_error_value as! Seeds.ErrorSeed
        guard case .generic = value else {
            XCTFail()
            return
        }
    }


}
