import Mapper

struct Test: Mappable {
    let test1: String
    let test2: String?

    public init(map: Mapper) throws {
        try test1 = map.from("test1")
        test2 = map.optionalFrom("test2")
    }
}

let testInvalidJsonForCompactMap = """
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

let testValidJsonForCompactMap = """
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
