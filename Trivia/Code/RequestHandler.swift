import Foundation
import UIKit

class RequestHandler
{
   static func checkLogin() -> Bool
   {
        var done = false
        var returnBool: Bool = true
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/checkLogin")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
        
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                    let dataString = String(data: data, encoding: .utf8)!
         
                    if(String(dataString) == "false")
                    {
                        returnBool = false
                    }
                    else
                    {
                        returnBool = true
                    }
                    done=true
            }
        }.resume()
    
    repeat
    {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
    } while !done
    
        return returnBool
   }
    
    static func getLeaderboard() -> [User]
    {
        var done  = false
        var returnArray: [User] = []
        let url = URL(string:"http://trivia-pop.herokuapp.com/api/Leaderboard")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                let leaderBoard = try? JSONDecoder().decode(Leaderboard.self, from: data)
                
                returnArray = leaderBoard!.topPlayers
                done=true
            }
        }.resume()
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnArray
        }
    
    static func login(username: String, password: String) -> GenericResponse
    {
        var returnResponse: GenericResponse?
        var done = false
        let url = URL(string:"http://trivia-pop.herokuapp.com/api/Login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "Username=\(username)&Password=\(password)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
               if let genericResponse = try? JSONDecoder().decode(GenericResponse.self, from: data)
               {
                returnResponse = genericResponse
                done=true
               }
            }
        }.resume()
        
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnResponse!
    }
    
    static func logout() -> GenericResponse
    {
        var returnResponse: GenericResponse?
        var done = false
        let url = URL(string:"http://trivia-pop.herokuapp.com/api/Logout")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
               if let genericResponse = try? JSONDecoder().decode(GenericResponse.self, from: data)
               {
                returnResponse = genericResponse
                done=true
               }
            }
        }.resume()
        
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnResponse!
    }
    
    static func register(username: String, password: String) -> GenericResponse
    {
        var returnResponse: GenericResponse?
        var done = false
        let url = URL(string:"http://trivia-pop.herokuapp.com/api/createAccount")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "Username=\(username)&Password=\(password)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
               if let genericResponse = try? JSONDecoder().decode(GenericResponse.self, from: data)
               {
                returnResponse = genericResponse
                done=true
               }
            }
        }.resume()
        
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnResponse!
    }
    
    static func startGame(difficulty: String) -> GenericResponse
    {
        var returnResponse: GenericResponse?
        var done = false
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/startGame")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let postString = "difficulty=\(difficulty)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                if let genericResponse = try? JSONDecoder().decode(GenericResponse.self, from:data)
                {
                    returnResponse = genericResponse
                    done=true
                }
            }
        }.resume()
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnResponse!
            
    }
    
    static func getQuestion() -> QnA
    {
        var done  = false
        var returnQnA: QnA?
        let url = URL(string:"http://trivia-pop.herokuapp.com/api/getQuestion")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                let newQnA = try? JSONDecoder().decode(QnA.self, from: data)
                
                returnQnA = newQnA
                done=true
            }
        }.resume()
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnQnA!
    }
    
    static func checkAnswer(answer: String, timeTaken: Int) -> CorrectCheck
    {
        var returnCheck: CorrectCheck?
        var done = false
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/Check")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let postString = "submittedAns=\(answer)&timer=\(timeTaken)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                if let check = try? JSONDecoder().decode(CorrectCheck.self, from:data)
                {
                    returnCheck = check
                    done=true
                }
            }
        }.resume()
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnCheck!
    }
    
    static func getHistory() -> RoundHistory
    {
        var returnHistory: RoundHistory?
        var done = false
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/roundHistory")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                if let history = try? JSONDecoder().decode(RoundHistory.self, from:data)
                {
                    returnHistory = history
                    done=true
                }
            }
        }.resume()
        
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        
        return returnHistory!
    }
    
    static func getHistory(roundID: Int) -> QuestionHistory
    {
        var returnHistory: QuestionHistory?
        var done = false
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/questionHistory")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let postString = "RoundID=\(roundID)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                if let history = try? JSONDecoder().decode(QuestionHistory.self, from:data)
                {
                    returnHistory = history
                    done=true
                }
            }
        }.resume()
        
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        
        return returnHistory!
    }
    
    static func endGame() -> QuestionHistory
    {
        var returnHistory: QuestionHistory?
        var done = false
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/endGame")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                if let history = try? JSONDecoder().decode(QuestionHistory.self, from:data)
                {
                    returnHistory = history
                    done=true
                }
            }
        }.resume()
        repeat
        {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while !done
        return returnHistory!
    }
    
    static func alert(title: String, message: String) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                        
        alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
    
        return alert
    }
    
    static func isRoundStarted() -> Bool
    {
        var done = false
        var returnBool: Bool = true
        let url = URL(string: "http://trivia-pop.herokuapp.com/api/isRoundStarted")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
        
            if error != nil
            {
                print(error!)
                return
            }
            
            if let data = data
            {
                    let dataString = String(data: data, encoding: .utf8)!
         
                    if(String(dataString) == "false")
                    {
                        returnBool = false
                    }
                    else
                    {
                        returnBool = true
                    }
                    done=true
            }
        }.resume()
    
    repeat
    {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
    } while !done
    
        return returnBool
    
}
}
