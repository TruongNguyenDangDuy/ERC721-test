require("@nomiclabs/hardhat-ethers");
const privateKey =
  "85f6342020f4f803de67e6b1db7b6af0d80d36e0bb64552b14024860e2dab7ac";
module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {},
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [privateKey],
    },
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
