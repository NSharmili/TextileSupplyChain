const Farmer = artifacts.require("farmer");

module.exports = function (deployer) {
  deployer.deploy(Farmer);
};
