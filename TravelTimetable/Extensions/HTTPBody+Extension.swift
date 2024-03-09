//
//  HTTPBody+Extension.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 09.03.2024.
//

import Foundation
import OpenAPIRuntime

extension HTTPBody {
    func decode<T: Decodable>(to type: T.Type, using decoder: JSONDecoder = .init(), upTo maxBytes: Int = 1_000_000_000_000) async throws -> T {
        let data = try await Data(collecting: self, upTo: maxBytes)
        return try decoder.decode(T.self, from: data)
    }
}
