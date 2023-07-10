import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { config as dotenvConfig } from "dotenv";
dotenvConfig();

const privateKey = process.env.WALLET_PRIVATE_KEY as string
const rpcUrlSepolia = process.env.RPC_URL_SEPOLIA as string
const rpcUrlShibuya = process.env.RPC_URL_SHIBUYA as string
const etherscanApiKey = process.env.ETHERSCAN_API_KEY as string

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      accounts: [privateKey],
      url: rpcUrlSepolia,
    },
    shibuya: {
      accounts: [privateKey],
      url: rpcUrlShibuya
    }
  },
  etherscan: {
    apiKey: etherscanApiKey,
  }
};

export default config;
