const mytoken = artifacts.require("TokenERC20");

module.exports = async function (deployer) {
  console.log("Starting deployment...");
  // uint256 _initialAmount, string memory _tokenName, uint8 _decimalUnits, string  memory _tokenSymbol
  await deployer.deploy(mytoken);
  console.log("Deployment finished.");

  // دسترسی به آدرس قرارداد پس از استقرار
  const instance = await mytoken.deployed();
  console.log("Contract deployed to:", instance.address);
};