import Foundation

public struct JOTPacket {

    public static let MagicByte: UInt8 = 0xCE

    public let data: Data

    public init(data: Data) {
        self.data  = data
    }

    public func encode() throws -> Data {
        let lengthBytes = try JOTLengthCoder.encode(length: UInt(data.count))
        return Data([JOTPacket.MagicByte] + lengthBytes) + data
    }
}
