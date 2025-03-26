// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Farmer.sol";

contract yarnmanufacturer is farmer{
    struct YarnManufacturer{
        string yarnManufacturerName;
        address yarnManufacturerID;
        bool isyarnManufacturer;
        string usertype;
        string location;
    }

    mapping(address=>YarnManufacturer) yarnManufacturerdetails;
    modifier isYarnManufacturer(address uniqueID){
        require(yarnManufacturerdetails[uniqueID].isyarnManufacturer==true, "Not a yarn manufacturer");
        _;
    }

    function registerYarnManufacturer(string memory _yarnManufacturerName,address _yarnManufacturerID,string memory _location) public
    { 
        require(exists[_yarnManufacturerID]==false," Already occupied");
        yarnManufacturerdetails[_yarnManufacturerID]=YarnManufacturer({
            yarnManufacturerName:_yarnManufacturerName,
            yarnManufacturerID:_yarnManufacturerID,
            isyarnManufacturer:true,
            usertype:"Yarn-Manufacturer",
            location:_location
        });
        exists[_yarnManufacturerID]=true;
    }

    function getYarnManufacturerdetails(address _yarnManufacturer) public view returns(string memory, string memory){
        return (yarnManufacturerdetails[_yarnManufacturer].yarnManufacturerName, yarnManufacturerdetails[_yarnManufacturer].location);
    }

}