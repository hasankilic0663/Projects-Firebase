import Foundation
import Combine


class NewsViewModel: ObservableObject {
    @Published var validationResult: NewsValidationResult?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func validateNews(url: String) {
        guard let requestUrl = URL(string: "https://api.openai.com/v1/chat/completions") else { return }
        
        isLoading = true
        errorMessage = nil
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer sk-xxxx", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": "Bu haber URL'si doğru mu? \(url)"]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        // API isteğini başlatıyoruz
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: OpenAIResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.validationResult = NewsValidationResult(
                        accuracy: 0.85, // Örnek doğruluk oranı
                        explanation: response.choices.first?.message.content ?? "Açıklama bulunamadı"
                    )
                }
            })
            .store(in: &cancellables)
    }
}
