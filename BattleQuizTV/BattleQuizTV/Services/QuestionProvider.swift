import Foundation

struct QuestionProvider {
    static func generateLocalQuestions(count: Int, difficulty: Difficulty) -> [Question] {
        let easy: [(String,[String],Int)] = [
            ("What is the capital of France?", ["Berlin","Madrid","Paris","Rome"], 2),
            ("2 + 2 = ?", ["3","4","5","6"], 1),
            ("Which planet is known as the Red Planet?", ["Earth","Mars","Jupiter","Venus"], 1),
            ("What color are bananas when ripe?", ["Blue","Yellow","Purple","Black"], 1),
            ("Which animal says 'meow'?", ["Dog","Cat","Cow","Bird"], 1),
            ("Which day comes after Monday?", ["Sunday","Tuesday","Friday","Saturday"], 1),
            ("Which shape has 3 sides?", ["Square","Triangle","Circle","Rectangle"], 1),
            ("How many legs does a spider have?", ["6","8","10","4"], 1)
        ]
        let medium: [(String,[String],Int)] = [
            ("Which gas do plants breathe in?", ["Oxygen","Carbon Dioxide","Nitrogen","Helium"], 1),
            ("Who painted the Mona Lisa?", ["Vincent van Gogh","Leonardo da Vinci","Pablo Picasso","Claude Monet"], 1),
            ("What is H2O commonly known as?", ["Salt","Water","Hydrogen","Ozone"], 1),
            ("Which ocean is the largest?", ["Indian","Pacific","Atlantic","Arctic"], 1),
            ("Which country invented pizza?", ["France","Italy","USA","Greece"], 1),
            ("Which metal is liquid at room temperature?", ["Mercury","Iron","Aluminum","Copper"], 0),
            ("What is the tallest land animal?", ["Elephant","Giraffe","Horse","Bear"], 1),
            ("Which sport uses a shuttlecock?", ["Tennis","Badminton","Squash","Cricket"], 1)
        ]
        let hard: [(String,[String],Int)] = [
            ("Which element has the chemical symbol 'W'?", ["Tungsten","Tin","Silver","Tantalum"], 0),
            ("Who developed the theory of general relativity?", ["Isaac Newton","Albert Einstein","Niels Bohr","Galileo Galilei"], 1),
            ("Which language has the most native speakers?", ["English","Spanish","Mandarin Chinese","Hindi"], 2),
            ("What is the capital of Iceland?", ["Oslo","Reykjavik","Copenhagen","Helsinki"], 1),
            ("Which year did the first iPhone release?", ["2005","2007","2009","2011"], 1),
            ("In computing, what does 'CPU' stand for?", ["Central Processing Unit","Control Program Unit","Computer Power Unit","Core Processing Utility"], 0),
            ("Which mathematician proved Fermat's Last Theorem?", ["Andrew Wiles","Grigori Perelman","Terence Tao","Kurt Gödel"], 0),
            ("What is the largest internal organ in the human body?", ["Liver","Lung","Heart","Kidney"], 0)
        ]

        let pool: [(String,[String],Int)]
        switch difficulty {
        case .easy: pool = easy
        case .medium: pool = medium
        case .hard: pool = hard
        }

        var unique = Array(pool.shuffled().prefix(max(1, min(count, pool.count))))
        if unique.count < count {
            var idx = 0
            while unique.count < count {
                unique.append(pool[idx % pool.count])
                idx += 1
            }
        }

        let mapped: [Question] = unique.map { item in
            let correct = item.2
            var pairs = item.1.enumerated().map { ($0.offset, $0.element) }
            pairs.shuffle()
            let options = pairs.map { $0.1 }
            let newIndex = pairs.firstIndex { $0.0 == correct } ?? 0
            return Question(prompt: item.0, options: options, correctIndex: newIndex)
        }
        return mapped
    }
}
