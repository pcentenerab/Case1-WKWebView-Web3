const contractAbi = [
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "msg",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "uint8",
                "name": "out",
                "type": "uint8"
            }
        ],
        "name": "Tic",
        "type": "event"
    },
    {
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "fallback"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "decr",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "incr",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "reset",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "valor",
        "outputs": [
            {
                "internalType": "uint8",
                "name": "",
                "type": "uint8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }
]
