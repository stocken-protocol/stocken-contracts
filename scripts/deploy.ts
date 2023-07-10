import { ethers } from "hardhat";
import { config as dotenvConfig } from "dotenv";
dotenvConfig();

const baseTokenURI = process.env.BASE_TOKEN_URL as string;

async function main() {
  const PhysicsNFT = await ethers.getContractFactory("PhysicsNFT");
  const physicsNFT = await PhysicsNFT.deploy(baseTokenURI);

  await physicsNFT.deployed();

  console.log(
    `Deployed to ${physicsNFT.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
