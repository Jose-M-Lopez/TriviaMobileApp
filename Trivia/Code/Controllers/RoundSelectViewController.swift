import UIKit
import SideMenu
class RoundSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var roundID: Int?
    var totalPoints: Int?
    var questionHistory: QuestionHistory?
    var questions: [Question]?
    var matchNum: Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchTitle: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var pointsEarned: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        
        questionHistory = RequestHandler.getHistory(roundID: roundID!)
        questions = questionHistory?.roundQuestions
        
    
        matchTitle.text = "Match #: \(matchNum!)"
        difficulty.text = "Difficulty: \(questions![0].difficulty.uppercased())"
        pointsEarned.text = "Points Earned: \(totalPoints!)"
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier: "cell")
        let question = questions![indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = question.question
        cell.textLabel?.font = UIFont(name:"Kohinoor Telugu", size: 20)
        cell.detailTextLabel?.text = question.category
        cell.detailTextLabel?.font = UIFont(name:"Kohinoor Telugu", size: 15)
        
      if(question.ifCorrect == true)
        {
            cell.backgroundColor = #colorLiteral(red: 0.4971532822, green: 0.9005881548, blue: 0.6309407949, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.9983369708, green: 0.69584167, blue: 0.7406207919, alpha: 1)
        }

        return cell
    }
}
