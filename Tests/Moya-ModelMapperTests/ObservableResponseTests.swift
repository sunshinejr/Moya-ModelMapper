import Quick
import Nimble
import Mapper
import Moya
import RxSwift

@testable import RxMoya_ModelMapper

final class ObservableReponseTests: QuickSpec {

    override func spec() {
        describe("compactMap") {
            it("should map all objects as everything is mappable") {
                let json = """
[
   {
      "test1":"test1",
      "test2":"test2"
   },
   {
      "test1":"test1",
      "test2":"test2"
   },
   {
      "test1":"test1"
   }
]
"""

                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                _ = Observable.just(response)
                    .compactMap(to: [Test].self)
                    .subscribe(onNext: { testObjects in
                        mapped = testObjects
                    })

                expect(mapped?.count).toEventually(equal(3))
            }

            it("should map only two objects as one is not mappable") {
                let json = """
[
   {
      "test1":"test1",
      "test2":"test2"
   },
   {
      "test1":"test1",
      "test2":"test2"
   },
   {
      "test2":"test2"
   }
]
"""

                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                var mapped: [Test]?

                _ = Observable.just(response)
                    .compactMap(to: [Test].self)
                    .subscribe(onNext: { testObjects in
                        mapped = testObjects
                    })

                expect(mapped?.count).toEventually(equal(2))
            }
        }
    }
}
