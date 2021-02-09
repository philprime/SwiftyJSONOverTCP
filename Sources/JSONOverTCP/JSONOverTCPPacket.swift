import Foundation

public struct JSONOverTCPPacket {

    public static let MagicByte: UInt8 = 0xCE

    public let data: Data

    public init(data: Data) {
        self.data  = data
    }

    public func encode() throws -> Data {
        let lengthBytes = try JSONOverTCPLengthCoder.encode(length: UInt(data.count))
        return Data([JSONOverTCPPacket.MagicByte] + lengthBytes) + data
    }
}
