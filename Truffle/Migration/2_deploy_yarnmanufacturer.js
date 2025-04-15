const YarnManufacturer = artifacts.require("yarnmanufacturer");

module.exports = function (deployer) {
  deployer.deploy(YarnManufacturer);
};
