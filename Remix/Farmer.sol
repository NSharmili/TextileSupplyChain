// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract farmer{
    struct Farmer{
        string farmerName;
        address farmerID;
        bool isfarmer;
        string usertype;
        string location;
    }

    mapping(address=>bool) internal exists;
    mapping(address=>Farmer) farmerdetails;
    modifier isFarmer(address uniqueID){
        require(farmerdetails[uniqueID].isfarmer==true, "Not a farmer");
        _;
    }

    function registerFarmer(string memory _farmerName,address _farmerID,string memory _location) public
    { 
        require(exists[_farmerID]==false," Already occupied");
        farmerdetails[_farmerID]=Farmer({
            farmerName:_farmerName,
            farmerID:_farmerID,
            isfarmer:true,
            usertype:"Farmer",
            location:_location
        });
        exists[_farmerID]=true;
    }

    function getFarmerdetails(address _farmer) public view returns(string memory, string memory){
        return (farmerdetails[_farmer].farmerName, farmerdetails[_farmer].location);
    }

}