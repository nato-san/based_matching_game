// Hardhat deployment script for BaseMatchingNFT
// Usage: npx hardhat run scripts/deploy.js --network base

const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);
  console.log("Account balance:", (await deployer.provider.getBalance(deployer.address)).toString());

  // Deploy BaseMatchingNFT
  const BaseMatchingNFT = await hre.ethers.getContractFactory("BaseMatchingNFT");
  const nft = await BaseMatchingNFT.deploy(
    "Based Matching Game NFT",
    "BMGNFT",
    deployer.address // initial owner
  );

  await nft.waitForDeployment();
  const address = await nft.getAddress();

  console.log("BaseMatchingNFT deployed to:", address);
  console.log("\nCopy this address to index.html:");
  console.log(`const NFT_CONTRACT_ADDRESS = "${address}";`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
