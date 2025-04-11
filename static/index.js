let account;
const connect = async () => {
  if (window.ethereum !== "undefined") {
    const accounts = await ethereum.request({ method: "eth_requestAccounts" });
    account = accounts[0];
    document.getElementById("contractArea").innerHTML = account;
  }

  const ABI =[
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Bought",
		"type": "event"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Dyed",
		"type": "event"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Retailed",
		"type": "event"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Weaved",
		"type": "event"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Yarn_collected",
		"type": "event"
	  },
	  {
		"anonymous": false,
		"inputs": [
		  {
			"indexed": false,
			"internalType": "bytes32",
			"name": "upc",
			"type": "bytes32"
		  }
		],
		"name": "Yielded",
		"type": "event"
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_customer",
			"type": "address"
		  }
		],
		"name": "getCustomerdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_dyer",
			"type": "address"
		  }
		],
		"name": "getDyerdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_farmer",
			"type": "address"
		  }
		],
		"name": "getFarmerdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_retailer",
			"type": "address"
		  }
		],
		"name": "getRetailerdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_weaver",
			"type": "address"
		  }
		],
		"name": "getWeaverdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "_yarnManufacturer",
			"type": "address"
		  }
		],
		"name": "getYarnManufacturerdetails",
		"outputs": [
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_customerName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_customerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerCustomer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_dyerName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_dyerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerDyer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_farmerName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_farmerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerFarmer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_retailerName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_retailerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerRetailer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_weaverName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_weaverID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerWeaver",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "string",
			"name": "_yarnManufacturerName",
			"type": "string"
		  },
		  {
			"internalType": "address",
			"name": "_yarnManufacturerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_location",
			"type": "string"
		  }
		],
		"name": "registerYarnManufacturer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "uint256",
			"name": "unumber",
			"type": "uint256"
		  }
		],
		"name": "putUniquefabricID",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "uint256",
			"name": "unumber",
			"type": "uint256"
		  }
		],
		"name": "getUniquefabricID",
		"outputs": [
		  {
			"internalType": "bytes32",
			"name": "",
			"type": "bytes32"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "_unum",
			"type": "bytes32"
		  },
		  {
			"internalType": "address",
			"name": "_farmerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_seedVariety",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_farmingMethod",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_harvestingMethod",
			"type": "string"
		  },
		  {
			"internalType": "uint256",
			"name": "_yieldQuantity",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_moisture",
			"type": "uint256"
		  }
		],
		"name": "collectRawMaterials",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "_unum",
			"type": "bytes32"
		  },
		  {
			"internalType": "address",
			"name": "_yarnManufacturerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_certification",
			"type": "string"
		  },
		  {
			"internalType": "uint256",
			"name": "_stapleLength",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_micronairValue",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_strength",
			"type": "uint256"
		  }
		],
		"name": "collectYarn",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "_unum",
			"type": "bytes32"
		  },
		  {
			"internalType": "address",
			"name": "_dyerID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_dyeMaterials",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_coloursUsed",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_certification",
			"type": "string"
		  },
		  {
			"internalType": "uint256",
			"name": "_temperature",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_soakingTime",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_pH",
			"type": "uint256"
		  }
		],
		"name": "collectDye",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "_unum",
			"type": "bytes32"
		  },
		  {
			"internalType": "address",
			"name": "_weaverID",
			"type": "address"
		  },
		  {
			"internalType": "string",
			"name": "_warp",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_weft",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_certification",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_colourfastness",
			"type": "string"
		  },
		  {
			"internalType": "uint256",
			"name": "_strength",
			"type": "uint256"
		  }
		],
		"name": "collectWeave",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "uID",
			"type": "bytes32"
		  },
		  {
			"internalType": "address",
			"name": "_retailerID",
			"type": "address"
		  },
		  {
			"internalType": "uint256",
			"name": "_price",
			"type": "uint256"
		  }
		],
		"name": "retailerDetails",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "uID",
			"type": "bytes32"
		  }
		],
		"name": "getFabricDetails",
		"outputs": [
		  {
			"internalType": "uint256",
			"name": "_price",
			"type": "uint256"
		  },
		  {
			"internalType": "string",
			"name": "_seedVariety",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_farmingMethod",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_harvestingMethod",
			"type": "string"
		  },
		  {
			"internalType": "uint256",
			"name": "_yeildQuantity",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_collectionTime",
			"type": "uint256"
		  },
		  {
			"internalType": "string",
			"name": "_certification",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_coloursUsed",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_dyeMaterials",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_warp",
			"type": "string"
		  },
		  {
			"internalType": "string",
			"name": "_weft",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "uID",
			"type": "bytes32"
		  }
		],
		"name": "getFabricQualityMetrics",
		"outputs": [
		  {
			"internalType": "uint256",
			"name": "_strength",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_moisture",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_stapleLength",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_micronairValue",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_pH",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_temperature",
			"type": "uint256"
		  },
		  {
			"internalType": "uint256",
			"name": "_soakingTime",
			"type": "uint256"
		  },
		  {
			"internalType": "string",
			"name": "_fabricState",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "bytes32",
			"name": "uID",
			"type": "bytes32"
		  }
		],
		"name": "getSupplychainDetails",
		"outputs": [
		  {
			"components": [
			  {
				"internalType": "address",
				"name": "farmerID",
				"type": "address"
			  },
			  {
				"internalType": "string",
				"name": "farmerName",
				"type": "string"
			  },
			  {
				"internalType": "address",
				"name": "yarnManufacturerID",
				"type": "address"
			  },
			  {
				"internalType": "string",
				"name": "yarnManufacturerName",
				"type": "string"
			  },
			  {
				"internalType": "address",
				"name": "dyerID",
				"type": "address"
			  },
			  {
				"internalType": "string",
				"name": "dyerName",
				"type": "string"
			  },
			  {
				"internalType": "address",
				"name": "weaverID",
				"type": "address"
			  },
			  {
				"internalType": "string",
				"name": "weaverName",
				"type": "string"
			  },
			  {
				"internalType": "address",
				"name": "retailerID",
				"type": "address"
			  },
			  {
				"internalType": "string",
				"name": "retailerName",
				"type": "string"
			  },
			  {
				"internalType": "address",
				"name": "customerID",
				"type": "address"
			  }
			],
			"internalType": "struct Trackin.Textilesupplychain",
			"name": "",
			"type": "tuple"
		  },
		  {
			"internalType": "string",
			"name": "",
			"type": "string"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  },
	  {
		"inputs": [
		  {
			"internalType": "address",
			"name": "bal",
			"type": "address"
		  }
		],
		"name": "getBalance",
		"outputs": [
		  {
			"internalType": "uint256",
			"name": "",
			"type": "uint256"
		  }
		],
		"stateMutability": "view",
		"type": "function",
		"constant": true
	  }
];
  const address = "0x16158332cB7957e288d7e61a82B8B026f70C1639";
  window.web3 = await new Web3(window.ethereum);
  window.contract = await new window.web3.eth.Contract(ABI, address);
  document.getElementById("contractStatus").innerHTML = 'Sucessfully Connected';
  const c=await window.contract.methods.getCustomerdetails(account).call({from:account,gas:9000000});
	if(!(c[0].length === 0)){
		document.getElementById("contractStatus").innerHTML = `Hi ${c[0]}`;
	}
};
