const TokenERC20 = artifacts.require("TokenERC20");

async function deploy() {
  try {
    console.log("Starting manual deployment...");

    const instance = await TokenERC20.new(); // استقرار دستی
    console.log("Contract deployed at:", instance.address);
  } catch (error) {
    console.error("Manual deployment failed:", error);
  }
}

module.exports = deploy;