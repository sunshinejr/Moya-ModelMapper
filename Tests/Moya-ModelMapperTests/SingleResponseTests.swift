import Quick
import Nimble
import Mapper
import Moya
import RxSwift

@testable import RxMoya_ModelMapper

final class SingleReponseTests: QuickSpec {

    override func spec() {
        describe("compactMap") {
            it("should map all objects as everything is mappable") {
                let json = testValidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                _ = Single.just(response)
                    .compactMap(to: [Test].self)
                    .subscribe(onSuccess: { testObjects in
                        mapped = testObjects
                    })

                expect(mapped?.count).toEventually(equal(3))
            }

            it("should map only two objects as one is not mappable") {
                let json = testInvalidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                _ = Single.just(response)
                    .compactMap(to: [Test].self)
                    .subscribe(onSuccess: { testObjects in
                        mapped = testObjects
                    })

                expect(mapped?.count).toEventually(equal(2))
            }
        }
    }
}
