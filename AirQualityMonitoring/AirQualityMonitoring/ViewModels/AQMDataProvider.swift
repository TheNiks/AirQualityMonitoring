//
//  AQMDataProvider.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import Foundation
import Starscream

protocol AQMDataProviderDelegate {
    //Did recieve response from API call
    func didReceive(response: Result<[AQMResponseData], Error>)
}

class AQMDataProvider {
    
    var isConnected: Bool = false

    /// API response delegate
    var delegate: AQMDataProviderDelegate?

    /// Websocket instance
    var socket: WebSocket? = {
        guard let url = URL(string: ServerConnection.url) else {
            print("can not create URL from: \(ServerConnection.url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        var socket = WebSocket(request: request)
        return socket
    }()

    /// Subcribe to websocket connection
    func subscribe() {
        self.socket?.delegate = self
        self.socket?.connect()
    }

    /// Unsubcribe to websocket connection
    func unsubscribe() {
        self.socket?.disconnect()
    }

    /// Life cycle method
    deinit {
        self.socket?.disconnect()
        self.socket = nil
    }
}

/// Websocket delegate
extension AQMDataProvider: WebSocketDelegate {
    /// Asynchronous response from websocket based on its status
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            //Connected
            case .connected(let headers):
                //Set connected value true
                isConnected = true
                print("websocket is connected: \(headers)")
            //Disconnected
            case .disconnected(let reason, let code):
                //Set connected value false
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            //Recieved text data
            case .text(let string):
                handleText(text: string)
            //Cancelled
            case .cancelled:
                //Set connected value false
                isConnected = false
            //Recieved error
            case .error(let error):
                //Set connected value false
                isConnected = false
                //Handle error
                handleError(error: error)
            //For all other websocket status
            default:
                break

        }
    }

    /// Handle text reponse from websocket's delegate method didReceive()
    private func handleText(text: String) {
        let jsonData = Data(text.utf8)
        let decoder = JSONDecoder()
        do {
            //Decode data
            let resArray = try decoder.decode([AQMResponseData].self, from: jsonData)
            //Inform delegate implemenator that new data has arrived
            self.delegate?.didReceive(response: .success(resArray))
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Handle error from websocket's delegate method didReceive()
    private func handleError(error: Error?) {
        if let e = error {
            self.delegate?.didReceive(response: .failure(e))
        }
    }
}
