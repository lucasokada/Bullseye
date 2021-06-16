//
//  HighScoresViewController.swift
//  Bullseye
//
//  Created by Lucas Eiki Okada on 18/05/21.
//

import UIKit

class HighScoresViewController: UITableViewController {
    var items = [HighScoreItem]()

    override func viewDidLoad() {
        
        let row0item = HighScoreItem()
        let row1item = HighScoreItem()
        let row2item = HighScoreItem()
        let row3item = HighScoreItem()
        let row4item = HighScoreItem()
    
        row0item.name = "Lucas Okada"
        row1item.name = "Manda"
        row2item.name = "Joey"
        row3item.name = "Adam"
        row4item.name = "Eli"
        row0item.score  = 50000
        row1item.score  = 10000
        row2item.score  = 5000
        row3item.score  = 1000
        row4item.score  = 500
        
        items.append(row0item)
        items.append(row1item)
        items.append(row2item)
        items.append(row3item)
        items.append(row4item)
        
        
        super.viewDidLoad()
        items = PersistenceHelper.loadHighScores()
        
        if items.count == 0 {
            resetHighScores()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreItem", for: indexPath) //recicla celulas da tabela ou cria novas celulas se necessario
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel //pede à table view a célula de tag 1000
        let scoreLabel = cell.viewWithTag(2000) as! UILabel
        
            
        let item = items[indexPath.row]  //index path é simplesmente um      objeto que aponta para uma linha da tabela. Quando o data source é pedido pela view controller a linha de número .row é verificada
        
        nameLabel.text = item.name
        scoreLabel.text = String(item.score)
        return cell
    }
    
    //metodo chamado sempre que o usuario clica em uma celula. A celula fica cinza e depois é desselecionada novamente.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //deletr linhas
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //MARK :- Actions
    @IBAction func resetHighScores() {
        items = [HighScoreItem]()
       
        
        let item1 = HighScoreItem()
        let item2 = HighScoreItem()
        let item3 = HighScoreItem()
        let item4 = HighScoreItem()
        let item5 = HighScoreItem()
    
        item1.name = "Lucas Okada"
        item2.name = "Manda"
        item3.name = "Joey"
        item4.name = "Adam"
        item5.name = "Eli"
        item1.score  = 50000
        item2.score  = 10000
        item3.score  = 5000
        item4.score  = 1000
        item5.score  = 500
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        items.append(item5)
        
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
