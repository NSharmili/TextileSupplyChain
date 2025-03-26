// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Dyer.sol";

contract weaver is dyer{
    struct Weaver{
        string weaverName;
        address weaverID;
        bool isweaver;
        string usertype;
        string location;
    }

    mapping(address=>Weaver) weaverdetails;
    modifier isWeaver(address uniqueID){
        require(weaverdetails[uniqueID].isweaver==true, "Not a weaver");
        _;
    }

    function registerWeaver(string memory _weaverName,address _weaverID,string memory _location) public
    { 
        require(exists[_weaverID]==false," Already occupied");
        weaverdetails[_weaverID]=Weaver({
            weaverName:_weaverName,
            weaverID:_weaverID,
            isweaver:true,
            usertype:"Weaver",
            location:_location
        });
        exists[_weaverID]=true;
    }

    function getWeaverdetails(address _weaver) public view returns(string memory, string memory){
        return (weaverdetails[_weaver].weaverName, weaverdetails[_weaver].location);
    }

}