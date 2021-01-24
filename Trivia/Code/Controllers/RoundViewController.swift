import SideMenu
import UIKit

class RoundViewController: UIViewController, MenuControllerDelegate, UITableViewDataSource, UITableViewDelegate
{
    var rounds: RoundHistory?
    var history: QuestionHistory?
    var matchReceiver: Int?
    
    private var menu:  SideMenuNavigationController?
    let rootController = MenuController(with: ["Home", "Leaderboard", "Play", "Logout"])
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        rounds = RequestHandler.getHistory()
    }
    
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "History2Home", sender: Any?.self)
            }
            else if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "History2Leader", sender: Any?.self)
            }
            else if(named == "Play")
            {
                self.performSegue(withIdentifier: "History2Play", sender: Any?.self)
            }
            else if(named == "Logout")
            {
                RequestHandler.logout()
                self.performSegue(withIdentifier: "History2Home", sender: Any?.self)
            }
        })
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return rounds!.roundList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell()
        let matchNum = indexPath.row + 1
       
        cell.textLabel?.text = String("Match #: \(matchNum)")
        cell.textLabel?.font = UIFont(name:"Kohinoor Telugu", size: 20)
        
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 0.4971532822, green: 0.9005881548, blue: 0.6309407949, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.4033296108, green: 0.8107992411, blue: 0.9339869618, alpha: 1)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "History2Select", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?)
    {
        if(segue.identifier == "History2Select")
        {
            let indexPath: NSIndexPath = sender as! NSIndexPath
            let history = rounds!.roundList[indexPath.row]
            let viewHistoryController = segue.destination as! RoundSelectViewController
            
            viewHistoryController.roundID = history.RoundID
            viewHistoryController.matchNum = indexPath.row + 1
            viewHistoryController.totalPoints = history.totalPoints
        }
    }
}
