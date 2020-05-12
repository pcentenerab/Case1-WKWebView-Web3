// GLOBAL VARIABLES
var web3;
var contract;
var account;

// CONFIGURATION METHODS

function getContract() {
    this.web3 = new Web3("http://localhost:7545");
    var contractAddress = "0xc481b3c43AF7e98c892995a48a1ebbAdd5ABaCb2";
    var contr = new this.web3.eth.Contract(contractAbi, contractAddress);
    this.contract = contr;
    webkit.messageHandlers.didFetchValue.postMessage("Contrato configurado");
}

async function getAccount() {
    try {
        var accounts = await this.web3.eth.getAccounts();
        this.account = accounts[0];
        webkit.messageHandlers.didFetchValue.postMessage("Cuenta configurada: "+this.account);
    } catch (rejectedValue) {
        webkit.messageHandlers.didFetchValue.postMessage("Error: "+rejectedValue);
    }
}

// METHODS TO BE CALLED FROM SWIFT

async function getValor() {
    try {
        var valor = await this.contract.methods.valor().call();
        webkit.messageHandlers.didFetchValue.postMessage("Mensaje recibido: el valor es "+valor);
    }
    catch (rejectedValue) {
        webkit.messageHandlers.didFetchValue.postMessage("Error: "+rejectedValue);
    }
}

async function incr() {
    try {
        await this.contract.methods.incr().send({from: account});
        this.getValor();
    }
    catch (rejectedValue) {
        webkit.messageHandlers.didFetchValue.postMessage("Error: "+rejectedValue);
    }
}

async function decr() {
    try {
        await this.contract.methods.decr().send({from: account});
        this.getValor();
    }
    catch (rejectedValue) {
        webkit.messageHandlers.didFetchValue.postMessage("Error: "+rejectedValue);
    }
}

async function reset() {
    try {
        await this.contract.methods.reset().send({from: account});
        this.getValor();
    }
    catch (rejectedValue) {
        webkit.messageHandlers.didFetchValue.postMessage("Error: "+rejectedValue);
    }
}

