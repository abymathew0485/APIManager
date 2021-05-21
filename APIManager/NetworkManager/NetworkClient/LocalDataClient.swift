//
//  LocalDataClient.swift
//  APIManager
//
//  Created by Aby Mathew on 21/05/21.
//

import Foundation

class LocalDataClient: ApiClientProtocol {
    func callApi<ResponseType>(request: ApiRequestProtocol, completion: @escaping (Result<ResponseType, NetworkError>) -> Void) where ResponseType : Codable {
        
        guard let data = LocalDataReader.readLocalFile(forName: "DummyData") else {
            fatalError("failed to get data from DummyData.json")
        }
        do {
            let decodedModel = try JSONDecoder().decode(BaseModel<ResponseType>.self, from: data)
            if let data = decodedModel.data, decodedModel.status == "success" {
                    completion(.success(data))
            }else{
                completion(.failure(.jsonDecodingError))
            }
        } catch {
            completion(.failure(.jsonDecodingError))
        }
    }
}


class LocalDataReader {
   final class func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
