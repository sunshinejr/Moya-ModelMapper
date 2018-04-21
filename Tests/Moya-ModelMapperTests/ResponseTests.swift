import Quick
import Nimble
import Mapper
import Moya

@testable import Moya_ModelMapper

final class ResponseTests: QuickSpec {

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
                let mapped = try! response.compactMap(to: [Test].self)

                expect(mapped.count) == 3
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
                let mapped = try! response.compactMap(to: [Test].self)

                expect(mapped.count) == 2
            }
        }
    }
}

struct Test: Mappable {
    let test1: String
    let test2: String?

    public init(map: Mapper) throws {
        try test1 = map.from("test1")
        test2 = map.optionalFrom("test2")
    }
}
