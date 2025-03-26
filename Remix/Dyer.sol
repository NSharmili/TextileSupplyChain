// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./YarnManufacturer.sol";

contract dyer is yarnmanufacturer{
    struct Dyer{
        string dyerName;
        address dyerID;
        bool isdyer;
        string usertype;
        string location;
    }

    mapping(address=>Dyer) dyerdetails;
    modifier isDyer(address uniqueID){
        require(dyerdetails[uniqueID].isdyer==true, "Not a dyer");
        _;
    }

    function registerDyer(string memory _dyerName,address _dyerID,string memory _location) public
    { 
        require(exists[_dyerID]==false," Already occupied");
        dyerdetails[_dyerID]=Dyer({
            dyerName:_dyerName,
            dyerID:_dyerID,
            isdyer:true,
            usertype:"Dyer",
            location:_location
        });
        exists[_dyerID]=true;
    }

    function getDyerdetails(address _dyer) public view returns(string memory, string memory){
        return (dyerdetails[_dyer].dyerName, dyerdetails[_dyer].location);
    }


}