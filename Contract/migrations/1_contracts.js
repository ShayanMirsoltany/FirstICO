const TokenERC20 = artifacts.require("TokenERC20");
const MyICO = artifacts.require("MyICO");
module.exports = async function (deployer) {
  try {
    
    // استقرار قرارداد
    await deployer.deploy(TokenERC20,1000000);
    // // گرفتن آدرس قرارداد پس از استقرار
    const instance = await TokenERC20.deployed();
    await deployer.deploy(MyICO,instance.address,"0xDf8Aa6A5424Ef345f959ab1b429e2374d610Afa4");
    console.log("Contract deployed to:", instance.address);
  } catch (error) {
    // مدیریت خطا
    console.error("Deployment failed with error:", error.message);
    console.error("Full error details:", error);
  }
  process.on("unhandledRejection", (reason, promise) => {
    console.error("Unhandled Rejection at:", promise, "reason:", reason);
  });
};

