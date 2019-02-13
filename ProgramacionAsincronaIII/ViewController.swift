//
//  ViewController.swift
//  ProgramacionAsincronaIII
//
//  Created by l.arranz.martinez on 6/2/19.
//  Copyright © 2019 l.arranz.martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Definir una cola
    
    var operationQueue : OperationQueue!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBAction func cancelAllOperations(_ sender: Any) {
        //Cancela la carga de imágenes. Pero primero comprobar si se ha cargado alguna imagen
        if operationQueue != nil {
            operationQueue.cancelAllOperations()
        }
    }
    
    func descargaImages() {
        
        let url1 = "https://images5.alphacoders.com/822/822471.jpg"
        let url2 = "https://vignette.wikia.nocookie.net/imagenes7216/images/7/74/Fondo_Abstracto_Color_Azul_Con_Rayos_Sobresaliendo_De_La_Parte_Inferior_%28Mario_Getial%29.jpg/revision/latest?cb=20170629231129&path-prefix=es"
        let url3 = "https://upload.wikimedia.org/wikipedia/commons/6/67/Inside_the_Batad_rice_terraces.jpg"
        let url4 = "https://upload.wikimedia.org/wikipedia/commons/6/67/Inside_the_Batad_rice_terraces.jpg"
        
        let operation1 = BlockOperation {
            let data = try! Data(contentsOf: URL (string: url1)!)
            OperationQueue.main.addOperation {
                //Actualizacion del imageView correspondiente
                self.imageView1.image = UIImage(data: data)
            }
        }
        
        let operation2 = BlockOperation {
            let data = try! Data(contentsOf: URL (string: url2)!)
            OperationQueue.main.addOperation {
                //Actualizacion del imageView correspondiente
                self.imageView2.image = UIImage(data: data)
            }
        }
        
        let operation3 = BlockOperation {
            let data = try! Data(contentsOf: URL (string: url3)!)
            OperationQueue.main.addOperation {
                //Actualizacion del imageView correspondiente
                self.imageView3.image = UIImage(data: data)
            }
        }
        
        let operation4 = BlockOperation {
            let data = try! Data(contentsOf: URL (string: url4)!)
            OperationQueue.main.addOperation {
                //Actualizacion del imageView correspondiente
                self.imageView4.image = UIImage(data: data)
            }
        }
        
        //Añadir dependencias a las operaciones
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)
        
        //Conocer el estado de las operaciones
        //operation1.isCancelled
        
        //Inicializar el operationQueue
        operationQueue = OperationQueue()
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
        operationQueue.addOperation(operation3)
        operationQueue.addOperation(operation4)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descargaImages() //Deshabilita el boton cuando la imagen todavía no se ha cargado
    }


}

