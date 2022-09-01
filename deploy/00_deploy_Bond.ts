import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

// If you have more than one IPFS node, use the key from the default.hardhat.config.ts file to choose which one to use.
const preferredIpfsNode: string | undefined = undefined;

const migrate: DeployFunction = async ({
  getNamedAccounts,
  deployments: { deploy },
}: HardhatRuntimeEnvironment) => {
  const { deployer } = await getNamedAccounts();
  if (!deployer) {
    console.error(
      "\n\nERROR!\n\nThe node you are deploying to does not have access to a private key to sign this transaction. Add a Private Key in this application to solve this.\n\n"
    );
    process.exit(1);
  }

  const collectionName = "Bond";
  const collectionSymbol = "BND";

  await deploy("Bond", {
    from: deployer,
    args: [collectionName, collectionSymbol],
    log: true,
  });

  return true;
};

export default migrate;

migrate.id = "00_deploy_bond";
migrate.tags = ["bond"];
