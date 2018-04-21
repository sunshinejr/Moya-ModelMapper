import Quick
import Nimble
import Mapper
import Moya
import ReactiveSwift

@testable import ReactiveMoya_ModelMapper

final class SinglaProducerReponseTests: QuickSpec {

    override func spec() {
        describe("compactMap") {
            it("should map all objects as everything is mappable") {
                let json = testValidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                SignalProducer<Response, MoyaError>(value: response)
                    .compactMap(to: [Test].self)
                    .startWithResult { result in
                        switch result {
                        case let .success(testObjects):
                            mapped = testObjects
                        case .failure:
                            break
                        }
                    }

                expect(mapped?.count).toEventually(equal(3))
            }

            it("should map only two objects as one is not mappable") {
                let json = testInvalidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                SignalProducer<Response, MoyaError>(value: response)
                    .compactMap(to: [Test].self)
                    .startWithResult { result in
                        switch result {
                        case let .success(testObjects):
                            mapped = testObjects
                        case .failure:
                            break
                        }
                }

                expect(mapped?.count).toEventually(equal(2))
            }
        }
    }
}
