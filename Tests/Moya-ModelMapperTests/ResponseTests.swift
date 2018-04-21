import Quick
import Nimble
import Mapper
import Moya

@testable import Moya_ModelMapper

final class ResponseTests: QuickSpec {

    override func spec() {
        describe("compactMap") {
            it("should map all objects as everything is mappable") {
                let json = testValidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                let mapped = try! response.compactMap(to: [Test].self)

                expect(mapped.count) == 3
            }

            it("should map only two objects as one is not mappable") {
                let json = testInvalidJsonForCompactMap
                let data = json.data(using: .utf8)!
                let response = Response(statusCode: 200, data: data)
                let mapped = try! response.compactMap(to: [Test].self)

                expect(mapped.count) == 2
            }
        }
    }
}
