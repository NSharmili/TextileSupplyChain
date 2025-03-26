// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Retailer.sol";

contract customer is retailer{
    struct Customer{
        string customerName;
        address customerID;
        bool iscustomer;
        string usertype;
        string location;
    }

    mapping(address=>Customer) customerdetails;
    modifier isCustomer(address uniqueID){
        require(customerdetails[uniqueID].iscustomer==true, "Not a customer");
        _;
    }

    function registerCustomer(string memory _customerName,address _customerID,string memory _location) public
    { 
        require(exists[_customerID]==false," Already occupied");
        customerdetails[_customerID]=Customer({
            customerName:_customerName,
            customerID:_customerID,
            iscustomer:true,
            usertype:"Customer",
            location:_location
        });
        exists[_customerID]=true;
    }

    function getCustomerdetails(address _customer) public view returns(string memory, string memory){
        return (customerdetails[_customer].customerName, customerdetails[_customer].location);
    }

}