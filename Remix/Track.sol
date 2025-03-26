// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Farmer.sol";
import "./YarnManufacturer.sol";
import "./Dyer.sol";
import "./Weaver.sol";
import "./Retailer.sol";
import "./Customer.sol";

contract Trackin is customer{

    enum State{
        Yielded,
        Yarn_collected,
        Dyed,
        Weaved,
        Retailed,
        Sold,
        Bought
    }

    mapping(uint=>string) Statechange;
    constructor(){
        Statechange[0]="Yielded";
        Statechange[1]="Yarn_collected";
        Statechange[2]="Dyed";
        Statechange[3]="Weaved";
        Statechange[4]="Retailed";
        Statechange[5]="Sold";
        Statechange[6]="Bought";
    }

    struct Textilesupplychain{
        address farmerID;
        string farmerName;
        address yarnManufacturerID;
        string yarnManufacturerName;
        address dyerID;
        string dyerName;
        address weaverID;
        string weaverName;
        address retailerID;
        string retailerName;
        address customerID;
    }

    struct fabricQuality{
        uint strength;
        uint moisture;
        uint stapleLength;
        uint micronaireValue;
        uint pH;
        uint temperature;
        uint soakingTime;
        string colourFastness;
    }

    struct Payment{
        uint _price;
        address payable receiver;
        address payable sender;
    }
    mapping(bytes32=>Payment) paymentdetails;

    struct Fabric{
        uint  price;
        bytes32 uniquefabricID;
        string seedVariety;
        string farmingMethod;
        string harvestingMethod;
        uint yieldQuantity;
        uint256 collectionTime;
        string certification;
        string coloursUsed;
        string dyeMaterials;
        string warp;
        string weft;
        bool isfabric;
        State fabricstate;
    }
    mapping(bytes32=>Fabric) fabricdescrip;
    mapping(bytes32=>fabricQuality) Supplychainmapping;
    mapping(bytes32=>Textilesupplychain) ts;

    modifier yielded(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Yielded, 'Plants is still not yielded');
        _;
    }
    modifier yarn_collected(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Yarn_collected, 'Yarn is still not collected');
        _;
    }
    modifier dyed(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Dyed, 'Dyeing is not done');
        _;
    }
    modifier weaved(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Weaved, 'Weaving is not done');
        _;
    }
    modifier retailed(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Retailed, 'Fabric state is not Processed');
        _;
    }
    modifier sold(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Sold, 'Fabric state is not sold');
        _;
    }
    modifier bought(bytes32 _upc){
        require(fabricdescrip[_upc].fabricstate==State.Bought, 'Fabric state is still not bought');
        _;
    }

    mapping(uint=>bytes32) fabricIDmapping;
    mapping(bytes32=>bool) uIDexist;
    event Yielded(bytes32 upc);
    event Yarn_collected(bytes32 upc);
    event Dyed(bytes32 upc);
    event Weaved(bytes32 upc);
    event Retailed(bytes32 upc);
    event Bought(bytes32 upc);

    function putUniquefabricID(uint unumber) public{
        require(uIDexist[fabricIDmapping[unumber]]==false,"Already exists");
        fabricIDmapping[unumber]=sha256(abi.encodePacked(unumber,block.timestamp));
        uIDexist[fabricIDmapping[unumber]]=true;
    }
    function getUniquefabricID(uint unumber) public view returns(bytes32){
        return(fabricIDmapping[unumber]);
    }
    modifier uniquefabricID(bytes32 unum){
        require(fabricdescrip[unum].isfabric==false,"Fabric id already exists");
        _;
    }
    modifier isfabricID(bytes32 num){
        require(fabricdescrip[num].isfabric==true,"Fabric id already exists");
        _;
    }
    // modifier paidEnough(uint _price){
    //     require(msg.value>=_price,"Insufficient amount for the quoted price");
    //     _;
    // }
    // modifier checkValue(bytes32 _upc, address payable _sender){
    //     uint _price=fabricdescrip[_upc].price;
    //     uint amountToReturn=msg.value-_price;
    //     _sender.transfer(amountToReturn);
    //     _;
    // }

    function collectRawMaterials(bytes32 _unum,address _farmerID, string memory _seedVariety,string memory _farmingMethod,string memory _harvestingMethod, uint _yieldQuantity, uint _moisture) public uniquefabricID(_unum) isFarmer(msg.sender){
        require(msg.sender==_farmerID);
        fabricdescrip[_unum]=Fabric({
            price: 0,
            uniquefabricID:_unum,
            seedVariety:_seedVariety,
            farmingMethod:_farmingMethod,
            harvestingMethod:_harvestingMethod,
            yieldQuantity:_yieldQuantity,
            collectionTime:block.timestamp,
            certification:"",
            coloursUsed:"",
            dyeMaterials:"",
            warp:"",
            weft:"",
            isfabric:true,
            fabricstate:State.Yielded
        });
        Supplychainmapping[_unum]=fabricQuality({
            strength:0,
            stapleLength:0,
            moisture:_moisture,
            micronaireValue:0,
            pH:0,
            temperature:0,
            soakingTime:0,
            colourFastness:""
        });
        ts[_unum]=Textilesupplychain({
            farmerID:_farmerID,
            farmerName:farmerdetails[_farmerID].farmerName,
            retailerID:address(0),
            dyerID:address(0),
            weaverID:address(0),
            yarnManufacturerID:address(0),
            retailerName:"",
            dyerName:"",
            weaverName:"",
            yarnManufacturerName:"",
            customerID:address(0)
        });
        emit Yielded(_unum);
    }

    function collectYarn(bytes32 _unum,address _yarnManufacturerID, string memory _certification,  uint _stapleLength, uint _micronairValue, uint _strength) public isYarnManufacturer(msg.sender){
        require(msg.sender==_yarnManufacturerID);
        fabricdescrip[_unum].collectionTime=block.timestamp;
        fabricdescrip[_unum].certification=_certification;
        fabricdescrip[_unum].fabricstate=State.Yarn_collected;
        Supplychainmapping[_unum].strength=_strength;
        Supplychainmapping[_unum].stapleLength=_stapleLength;
        Supplychainmapping[_unum].micronaireValue=_micronairValue;
        ts[_unum].yarnManufacturerID=_yarnManufacturerID;
        ts[_unum].yarnManufacturerName=yarnManufacturerdetails[_yarnManufacturerID].yarnManufacturerName;
        emit Yarn_collected(_unum);
    }

    function collectDye(bytes32 _unum,address _dyerID,string memory _dyeMaterials,string memory _coloursUsed, string memory _certification, uint _temperature, uint _soakingTime, uint _pH) public isDyer(msg.sender){
        require(msg.sender==_dyerID);
        fabricdescrip[_unum].dyeMaterials=_dyeMaterials;
        fabricdescrip[_unum].coloursUsed=_coloursUsed;
        fabricdescrip[_unum].collectionTime=block.timestamp;
        fabricdescrip[_unum].certification=_certification;
        fabricdescrip[_unum].fabricstate=State.Dyed;
        Supplychainmapping[_unum].pH=_pH;
        Supplychainmapping[_unum].temperature=_temperature;
        Supplychainmapping[_unum].soakingTime=_soakingTime;
        ts[_unum].dyerID=_dyerID;
        ts[_unum].dyerName=dyerdetails[_dyerID].dyerName;
        emit Dyed(_unum);
    }

    function collectWeave(bytes32 _unum,address _weaverID,string memory _warp,string memory _weft, string memory _certification, string memory _colourfastness, uint _strength) public isWeaver(msg.sender){
        require(msg.sender==_weaverID);
        fabricdescrip[_unum].warp=_warp;
        fabricdescrip[_unum].weft=_weft;
        fabricdescrip[_unum].collectionTime=block.timestamp;
        fabricdescrip[_unum].certification=_certification;
        fabricdescrip[_unum].fabricstate=State.Weaved;
        Supplychainmapping[_unum].strength=_strength;
        Supplychainmapping[_unum].colourFastness=_colourfastness;
        ts[_unum].weaverID=_weaverID;
        ts[_unum].weaverName=weaverdetails[_weaverID].weaverName;
        emit Weaved(_unum);
    }

    function retailerDetails(bytes32 uID,address _retailerID, uint _price) public isRetailer(msg.sender) weaved(uID){
        require(msg.sender==_retailerID);
        fabricdescrip[uID].price=_price;
        ts[uID].retailerID=_retailerID;
        ts[uID].retailerName=retailerdetails[_retailerID].retailerName;
        fabricdescrip[uID].fabricstate=State.Retailed;
        emit Retailed(uID);
    }

    function getFabricDetails(bytes32 uID) public view returns(uint _price, string memory _seedVariety, string memory _farmingMethod, string memory _harvestingMethod, uint _yeildQuantity, uint256 _collectionTime, string memory  _certification, string memory _coloursUsed, string memory _dyeMaterials, string memory _warp, string memory _weft){
        bytes32 fabricID=uID;
        return (fabricdescrip[fabricID].price,fabricdescrip[fabricID].seedVariety,fabricdescrip[fabricID].farmingMethod, fabricdescrip[fabricID].harvestingMethod,fabricdescrip[fabricID].yieldQuantity,fabricdescrip[fabricID].collectionTime,fabricdescrip[fabricID].certification,fabricdescrip[fabricID].coloursUsed,fabricdescrip[fabricID].dyeMaterials,fabricdescrip[fabricID].warp, fabricdescrip[fabricID].weft);
    }

    function getFabricQualityMetrics(bytes32 uID) public view returns(uint _strength, uint _moisture, uint _stapleLength, uint _micronairValue, uint _pH, uint _temperature, uint _soakingTime, string memory _fabricState){
        bytes32 fabricID=uID;
        return (Supplychainmapping[uID].strength,Supplychainmapping[uID].moisture,Supplychainmapping[uID].stapleLength,Supplychainmapping[uID].micronaireValue,Supplychainmapping[uID].pH,Supplychainmapping[fabricID].temperature,Supplychainmapping[fabricID].soakingTime,Supplychainmapping[fabricID].colourFastness);
    }

    function getSupplychainDetails(bytes32 uID) public view returns(Textilesupplychain memory, string memory){
        bytes32 fabricID=uID;
        uint fabricStatenum=uint(fabricdescrip[fabricID].fabricstate);
        return (Textilesupplychain(ts[fabricID].farmerID, ts[fabricID].farmerName, ts[fabricID].yarnManufacturerID, ts[fabricID].yarnManufacturerName, ts[fabricID].dyerID, ts[fabricID].dyerName, ts[fabricID].weaverID, ts[fabricID].weaverName, ts[fabricID].retailerID, ts[fabricID].retailerName,ts[fabricID].customerID), Statechange[fabricStatenum]);
    }

    function getBalance(address bal) public view returns(uint){
        return bal.balance;
    }


}