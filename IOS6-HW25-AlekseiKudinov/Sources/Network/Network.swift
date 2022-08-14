//
//  Network.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 15.08.2022.
//

import Foundation
import Alamofire

class NetworkProvider: NetworkProviderErrorHandler {

    var delegate: NetworkProviderDelegate?

    private var url: String { "\(marvelAPI.domain)\(marvelAPI.path)\(Sections.characters)" }
    private var parameters = ["apikey": marvelAPI.publicKey,
                              "ts": marvelAPI.ts,
                              "hash": marvelAPI.hash]

    func fetchData(characterName: String?, completion: @escaping ([Character]) -> ()) {
        if let name = characterName {
            switch name {
            case "":
                parameters.removeValue(forKey: "nameStartsWith")
            default:
                parameters["nameStartsWith"] = name
            }
        }

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    print(self.url, self.parameters)
                case let .failure(error):
                    self.delegate?.showAlert(message: error.errorDescription?.description)
                }
            }
            .responseDecodable(of: MarvelAPI.self) { (response) in
                guard let characters = response.value?.data else { return }

                if characters.count == 0 {
                    self.delegate?.showAlert(message: nil)
                }
                completion(characters.all)
            }
    }
}

extension NetworkProvider {
    enum marvelAPI {
        static let domain = "https://gateway.marvel.com"
        static let path = "/v1/public/"
        static let privateKey = "c5d5042da0bd55f1e80dfda77514e854481c9060"
        static let publicKey = "9fdd5a81b7c74ea842fb304d01089cdf"
        static var ts: String {
            return String(Date().getCurrentTimestamp())
        }
        static var hash: String {
            print("number: \(ts)")
            return String(String(ts) + privateKey + publicKey).md5
        }
    }

    enum Sections {
        case characters
        case comics
    }
}

protocol NetworkProviderErrorHandler {
    var delegate: NetworkProviderDelegate? { get set }
}

protocol NetworkProviderDelegate {
    func showAlert(message: String?)
}
