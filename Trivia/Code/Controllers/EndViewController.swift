import UIKit
import SideMenu

class EndViewController: UIViewController, MenuControllerDelegate, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    var history: QuestionHistory?
    var questions: [Question]?
    private var menu:  SideMenuNavigationController?
    var rootController = MenuController(with: ["Home", "Leaderboard", "Match History", "Logout"])
    
    @IBOutlet weak var endText: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        
        history = RequestHandler.endGame()
        questions = history?.roundQuestions
        
        endText.text = "Round complete! You earned: \(history!.totalPoints) points."
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "End2Home", sender: Any?.self)
            }
            else if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "End2Leader", sender: Any?.self)
            }
            else if(named == "Logout")
            {
                 RequestHandler.logout()
                
                self.performSegue(withIdentifier: "End2Home", sender: Any?.self)
            }
            else if (named == "Match History")
            {
                self.performSegue(withIdentifier: "End2History", sender: Any?.self)
            }
        })
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
