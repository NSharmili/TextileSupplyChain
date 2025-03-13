# TextileSupplyChain
**ABSTRACT:**<br>
Every fabric holds a secret—woven in its threads, revealed in its touch, and defined by its purity. The textile industry prioritizes transparency, sustainability, and authenticity, but traditional supply chains lack clarity and genuineness. This leaves weavers underpaid and unrecognized, while counterfeit products continue to grow in the market. The proposed system ‘Blockchain and Machine Learning Solution for building Trust in Textiles’ integrates blockchain for secure traceability and machine learning for fabric purity analysis. The application securely documents the entire production process on an immutable blockchain, from raw material procurement to pre-weaving, pattern designing, yarn dyeing, fabric weaving, and post-weaving stages. The application uses machine learning to analyze fabric data, enabling secure and transparent tracking while detecting fabric authenticity, blends, and adulteration. . Customers can scan a fabric identifier on clothing to access textile details, including yarn material, ply type, twist, fiber length, and yarn quality. By combining blockchain and machine learning, this solution builds trust between brands and consumers, supports ethical practices, and helps people make better purchasing decisions.<br>
<br>
<br>
**Deploying Remix Smart Contracts to Ganache Using Truffle**
**Steps:**
1.	Install Node.js & npm<br>
•	 Download and install Node.js(version 18)<br>
•	Verify the installation <br>
           node -v and npm -v<br>
  ![image](https://github.com/user-attachments/assets/3f50ec35-a9e0-4de5-b543-54caf066df8d)
2.	Install Truffle using npm   <br>    
•	To install Truffle, open your terminal and run:<br>
           npm install -g truffle<br>


•	Verify the installation<br>
            truffle version<br>
 ![image](https://github.com/user-attachments/assets/3a0f774e-9b01-41e9-a534-5a8cd70729c0)

**Create a Truffle Project**
**Steps:**
1. Download the project from remix IDE
2. Initialize a Truffle project:
               truffle init
 
**Configuring Truffle to connect with Ganache
Steps:**
<br>
1.Open truffle-config.js in Vs code.<br>
2. Modify the networks section to connect with Ganache:<br>
~~~
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Ganache runs on localhost
      port: 7545,        // Use 8545 for Ganache CLI
      network_id: "*",   // Match any network ID
    },
  },
  compilers: {
    solc: {
      version: "0.8.20", // Ensure this matches your Solidity version
    },
  },
};
~~~
3.	Save and close the file.

**Export a Smart Contract from Remix**
1.  Open Remix IDE (Remix.ethereum.org).
2.  Write a Solidity contract in Remix or use an existing one.
3. Compile the contract in Remix.
4.  Click Compile and select the contract (e.g., MyContract.sol).
5.  Click ABI & Bytecode and Copy ABI.
6.  Save the contract to your Truffle project:
•	Open the contracts/ folder in your Truffle project.
•	Create a new file, e.g., MyContract.sol.
•	Paste the Solidity code from Remix into this file.
7.  Save and close the file.



