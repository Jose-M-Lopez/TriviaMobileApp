import UIKit
import SideMenu

class LeaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MenuControllerDelegate
{
    private var menu:  SideMenuNavigationController?

    @IBOutlet weak var tableView: UITableView!
    
    var topPlayers: [User] = []
    var rootController = MenuController(with: [""])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        topPlayers =  RequestHandler.getLeaderboard()
        
        if(RequestHandler.checkLogin() == false)
        {
            rootController = MenuController(with: ["Home", "Login"])
        }
        else
        {
            rootController = MenuController(with: ["Home", "Match History", "Play", "Logout"])
        }
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        
    }
    
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "Leader2Home", sender: Any?.self)
            }
            else if(named == "Login")
            {
                self.performSegue(withIdentifier: "Leader2Login", sender: Any?.self)
            }
            else if(named == "Play")
            {
                self.performSegue(withIdentifier: "Leader2Play", sender: Any?.self)
            }
            else if(named == "Logout")
            {
                RequestHandler.logout()
                self.performSegue(withIdentifier: "Leader2Home", sender: Any?.self)
            }
            else if(named == "Match History")
            {
                self.performSegue(withIdentifier: "Leader2History", sender: Any?.self)
            }
        })
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return topPlayers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier: "cell")
        let player = topPlayers[indexPath.row]
        
        cell.textLabel?.text = player.username
        cell.textLabel?.font = UIFont(name:"Kohinoor Telugu", size: 20)
        cell.detailTextLabel?.text = "Points: " + String(player.points!)
        cell.detailTextLabel?.font = UIFont(name:"Kohinoor Telugu", size: 15)
        
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
   
}

