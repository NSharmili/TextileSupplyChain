const Retailer = artifacts.require("retailer");

module.exports = function (deployer) {
  deployer.deploy(Retailer);
};
