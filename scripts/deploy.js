const hre = require("hardhat");

async function main() {
  const Duy = await hre.ethers.getContractFactory("Duy");
  console.log("Deploying Duy ERC721 token...");
  const duy = await Duy.deploy("Duy", "Dz");

  await duy.deployed();
  console.log("Duy deployed to:", duy.address);
  await duy.mint(
    "https://ipfs.io/ipfs/Qmc3rSQiMCvCGaiHvteLSPZQmttecj5sTA2zfn6xFE5EUo"
  );
  console.log("NFT successfully minted");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
