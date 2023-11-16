import Foundation


class QuestionViewModel {
    
    private let sourcesURL = URL(string: "https://quiz-68112-default-rtdb.firebaseio.com/quiz.json")!

    var questionModel : DataModel?
    
    func getAllQuestion(completion: @escaping () -> ()){
        URLSession.shared.dataTask(with: sourcesURL){ [weak self] (data, response, error) in
            if let data = data{
                let jsonDecoder = JSONDecoder()
                let finalModel = try! jsonDecoder.decode(DataModel.self, from: data)
                self?.questionModel = finalModel
                completion()
                print("GetAllQuestion finish")
            }
        }.resume()
    }
    
    
}
