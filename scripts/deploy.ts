import { ethers } from "hardhat";

async function main() {
  const Stocken = await ethers.getContractFactory("Stocken");
  const stocken = await Stocken.deploy();

  await stocken.deployed();

  console.log(
    `Deployed to ${stocken.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
