const TokenERC20 = artifacts.require("TokenERC20");
const MyICO = artifacts.require("MyICO");
module.exports = async function (deployer) {
  try {
    console.log("Starting deployment...");
    
    // استقرار قرارداد
    await deployer.deploy(TokenERC20);
    // // گرفتن آدرس قرارداد پس از استقرار
    const instance = await TokenERC20.deployed();
    await deployer.deploy(MyICO,instance.address,"0x8e39495F73be3fDEE81a6440730E67e3e0bC448F");
    console.log("Contract deployed to:", instance.address);
    console.log("Deployment finished.");
  } catch (error) {
    // مدیریت خطا
    console.error("Deployment failed with error:", error.message);
    console.error("Full error details:", error);
  }
  process.on("unhandledRejection", (reason, promise) => {
    console.error("Unhandled Rejection at:", promise, "reason:", reason);
  });
};

