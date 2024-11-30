const TokenERC20 = artifacts.require("Shayan");

module.exports = async function (deployer) {
  try {
    console.log("Starting deployment...");
    
    // استقرار قرارداد
    await deployer.deploy(TokenERC20);
    
    // // گرفتن آدرس قرارداد پس از استقرار
    // const instance = await TokenERC20.deployed();
    // console.log("Contract deployed to:", instance.address);
    // console.log("Deployment finished.");
  } catch (error) {
    // مدیریت خطا
    console.error("Deployment failed with error:", error.message);
    console.error("Full error details:", error);
  }
  process.on("unhandledRejection", (reason, promise) => {
    console.error("Unhandled Rejection at:", promise, "reason:", reason);
  });
};

