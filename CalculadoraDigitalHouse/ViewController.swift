//
//  ViewController.swift
//  CalculadoraDigitalHouse
//
//  Created by Lucas Viana Munhoz on 01/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Soma: UIButton!
    @IBOutlet weak var Multiplicacao: UIButton!
    @IBOutlet weak var Divisao: UIButton!
    @IBOutlet weak var Subtracao: UIButton!
    @IBOutlet weak var Total: UILabel!
    
    
    let userDefaults = UserDefaults.standard
    var selecionado : Bool = false;
    var tipoOperacao: TipoOperacao? = nil;
    var ultimaOperacao: TipoOperacao? = nil;
    var limpo : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LimpaValoresMemoria()
      
    }

    @IBAction func BotaoLimpar(_ sender: UIButton) {
        Total.text! = "0";
        LimpaValoresMemoria()
        if(self.tipoOperacao != nil){
            AtivaBotaoOperacao(operacao: self.tipoOperacao!)
        }
        self.selecionado=false;
        self.limpo = false ;
        self.tipoOperacao = nil;
    }
    
    
    @IBAction func BotaoZero(_ sender: UIButton) {
        if(Total.text != "0" && Total.text!.count < 12){
            VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "0");
        }
    }
    
    @IBAction func BotaoPorcentagem(_ sender: Any) {
        let primeiroValor = self.userDefaults.double(forKey: "primeiroValor")
        Total.text!  = String(format: "%0.2f",Double(primeiroValor/100));
    }
    @IBAction func BotaoMaisMenos(_ sender: Any) {
        let negativo = Total.text!.contains("-");
        if(negativo){
            Total.text! = Total.text!.replacingOccurrences(of: "-", with: "")
        }else{
            Total.text! = "-"+Total.text!
        }
       

    }
    
    @IBAction func BotaoUm(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "1");
   
    }
    
    @IBAction func BotaoDois(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "2");
   
    }
    @IBAction func BotaoTres(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "3");
   
    }
    
    @IBAction func BotaoQuatro(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "4");
   
    }
    
    @IBAction func BotaoQuinta(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "5");
   
    }
    
    @IBAction func BotaoSeis(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "6");
   
    }
    
    @IBAction func BotaoSete(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "7");
   
    }
    
    @IBAction func BotaoOito(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "8");
   
    }
    @IBAction func BotaoNove(_ sender: UIButton) {
        VerificaSeTemDozeCaracteres(texto:Total.text! , numero: "9");
   
    }
    @IBAction func BotaoVirgula(_ sender: UIButton) {
        let virgula = Total.text!.contains(",");
        if virgula==false {
            Total.text! += ",";
        }
    }

    @IBAction func BotaoSoma(_ sender: UIButton) {
        ProcessarSolicitacao(operacao: .Soma);
    }
    @IBAction func BotaoSubtracao(_ sender: UIButton) {
     
        ProcessarSolicitacao(operacao: .Subtracao);

    }

    @IBAction func BotaoIgual(_ sender: Any) {
        ProcessarSolicitacao(operacao: .Igual);
        AtivaBotaoOperacao(operacao: self.ultimaOperacao!)
    }
    @IBAction func BotaoMultiplicacao(_ sender: UIButton) {
        ProcessarSolicitacao(operacao: .Multiplicacao);

    }
    
    @IBAction func BotaoDivisao(_ sender: UIButton) {
        ProcessarSolicitacao(operacao: .Divisao);
    }
    
    
    func ArmazenarPrimeiroValor()  {
        SaveKeysUsers(key:"primeiroValor" , value: ValorRetornadoComPonto())
 
        self.selecionado = true
        DesativaBotaoOperacao(operacao: self.tipoOperacao!)
     
     }
    
    func ValorRetornadoComPonto()->Double{
      return  Double(Total.text!.replacingOccurrences(of: ",", with: "."))!
    }
    func EfetuaOperacao(operacao : TipoOperacao){
        let primeiroValor = self.userDefaults.double(forKey: "primeiroValor")
        let segundoValor = self.userDefaults.double(forKey: "segundoValor")
       
        switch operacao {
        case .Soma:
            Total.text = String(format: "%0.2f",Double(primeiroValor+segundoValor));
            FinalizaOperacao(operacao: self.tipoOperacao!)
            GuardaResultadoOperacao()
            print("Soma")
            break
        case .Subtracao:
            Total.text!  = String(format: "%0.2f",Double(primeiroValor-segundoValor));
            FinalizaOperacao(operacao: self.tipoOperacao!)
            GuardaResultadoOperacao()
            print("Subtracao")
            break
        case .Divisao:
            Total.text!  = String(format: "%0.2f",Double(primeiroValor/segundoValor));
            FinalizaOperacao(operacao: self.tipoOperacao!)
            GuardaResultadoOperacao()
            print("Divisao")
            break
        case .Multiplicacao:
            Total.text!  = String(format: "%0.2f",Double(primeiroValor*segundoValor));
            FinalizaOperacao(operacao: self.tipoOperacao!)
            GuardaResultadoOperacao()
            print("Multiplicacao")
            break
        case .Igual:
            self.tipoOperacao = self.ultimaOperacao
            let segundoValor = self.userDefaults.double(forKey: "segundoValor")
            let ultimoValor =  self.userDefaults.double(forKey: "ultimoValor")
            if segundoValor != 0{
                self.userDefaults.set(segundoValor, forKey: "ultimoValor")
            }else{
                self.userDefaults.set(ultimoValor, forKey: "segundoValor")
            }
            EfetuaOperacao(operacao: self.ultimaOperacao!)
            break;
        case .Porcentagem:
            break;
        }
        
        
    }
    func GuardaResultadoOperacao(){
        self.userDefaults.set(ValorRetornadoComPonto(),forKey: "primeiroValor")
    }
    func FinalizaOperacao(operacao : TipoOperacao){
        switch operacao {
        case .Soma:
            self.selecionado = true
            self.Soma.isEnabled = false
            self.limpo = false
            LimpaValoresMemoria()
            break;
        case  .Subtracao:
            self.selecionado = true
            self.Subtracao.isEnabled = false
            self.limpo = false
            LimpaValoresMemoria()
            break;
        case .Multiplicacao:
            self.selecionado = true
            self.Multiplicacao.isEnabled = false
            self.limpo = false
            LimpaValoresMemoria()
            break;
        case .Divisao:
            self.selecionado = true
            self.Divisao.isEnabled = false
            self.limpo = false
            LimpaValoresMemoria()
            break;
        case .Igual:
            break;
        case .Porcentagem:
            break;
        }
    }
    func AtivaBotaoOperacao(operacao : TipoOperacao){
        switch operacao {
        case .Soma:
            self.Soma.isEnabled = true
            break;
        case .Subtracao:
            self.Subtracao.isEnabled = true
            break;
      

        case .Multiplicacao:
            self.Multiplicacao.isEnabled = true
            break;
        case .Divisao:
            self.Divisao.isEnabled = true
            break;
        case .Igual:
            break;
        case .Porcentagem:
            break;
        }
    }
    func DesativaBotaoOperacao(operacao : TipoOperacao){
        switch operacao {
        case .Soma:
            self.Soma.isEnabled = false
            break;
        case .Subtracao:
            self.Subtracao.isEnabled = false
            break;
        case .Multiplicacao:
            self.Multiplicacao.isEnabled = false
            break;
        case .Divisao:
            self.Divisao.isEnabled = false
            break;
        case .Igual:
            self.Soma.isEnabled = false
            self.Subtracao.isEnabled = false
            self.Divisao.isEnabled = false
            self.Multiplicacao.isEnabled = false
            break;
        case .Porcentagem:
            
            break;
        }
    }
    func SaveKeysUsers(key:String ,value : Any){
        self.userDefaults.set(value,forKey: key);
    }
    func ProcessarSolicitacao (operacao:TipoOperacao ) {
        if(self.tipoOperacao != nil && self.tipoOperacao != operacao && operacao != .Igual ){
            AtivaBotaoOperacao(operacao: self.tipoOperacao!)
            DesativaBotaoOperacao(operacao: operacao)
            self.tipoOperacao = operacao
            self.ultimaOperacao = operacao
        
        }else  if(self.selecionado && self.tipoOperacao == operacao || operacao == .Igual){
            EfetuaOperacao(operacao: operacao)
   
        }else{
            self.tipoOperacao = operacao
            self.ultimaOperacao = operacao
            ArmazenarPrimeiroValor()
  
        }
    }
    func VerificaSeTemDozeCaracteres(texto:String,numero : String) {
        let sinal =  Total.text!.contains("-");
        if(Total.text!.count < 12){
            if(self.selecionado){
               if(!self.limpo){
                   Total.text! = ""
                   self.limpo = true
                  
               }
                AtivaBotaoOperacao(operacao: self.tipoOperacao!)
              
               Total.text! += numero;
                self.userDefaults.set(ValorRetornadoComPonto(),forKey: "segundoValor")
           } else if(VerificaSeTemZero(texto: Total.text!)){
                Total.text = numero;
            }
            
            else {
                Total.text! += numero;
                self.userDefaults.set(ValorRetornadoComPonto(),forKey: "segundoValor")
            }
        }
        Total.text! = sinal  ?  "-"+Total.text! : Total.text!;
    }
    
    func VerificaSeTemZero(texto : String) -> Bool {
        var zero =    Total.text!.contains("0") && !Total.text!.contains("0,") ;
        if(!Total.text!.contains("-0") && Total.text!.count>1){
            zero = false;
        }
        return zero;
    }
    func VerificaNumeroMaiorQueZero(texto:String) -> Bool{
        let zero = Double(Total.text!)!>0;
        return zero;
    }
    func LimpaValoresMemoria(){
        self.userDefaults.set(0,forKey: "primeiroValor")
        self.userDefaults.set(0,forKey: "segundoValor")
        
        self
    }
}

