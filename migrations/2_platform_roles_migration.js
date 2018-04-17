const BytesToUint256 = artifacts.require("./BytesToUint256");
const PlatformRoles = artifacts.require("./PlatformRoles");

module.exports = function(deployer, accounts) {
  deployer.deploy(BytesToUint256);
  deployer.link(BytesToUint256, PlatformRoles);
  deployer.deploy(PlatformRoles, '0xf7A299884aD7be5Bc3465a0b1D8Bb2bE2B00fD0A');
};