// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Weaver.sol";

contract retailer is weaver{
    struct Retailer{
        string retailerName;
        address retailerID;
        bool isretailer;
        string usertype;
        string location;
    }

    mapping(address=>Retailer) retailerdetails;
    modifier isRetailer(address uniqueID){
        require(retailerdetails[uniqueID].isretailer==true, "Not a retailer");
        _;
    }

    function registerRetailer(string memory _retailerName,address _retailerID,string memory _location) public
    { 
        require(exists[_retailerID]==false," Already occupied");
        retailerdetails[_retailerID]=Retailer({
            retailerName:_retailerName,
            retailerID:_retailerID,
            isretailer:true,
            usertype:"Retailer",
            location:_location
        });
        exists[_retailerID]=true;
    }

    function getRetailerdetails(address _retailer) public view returns(string memory, string memory){
        return (retailerdetails[_retailer].retailerName, retailerdetails[_retailer].location);
    }


}