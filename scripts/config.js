const YAML = require("yaml");
const fs = require("fs");
const { Account, Ed25519PrivateKey } = require("@aptos-labs/ts-sdk");

const readConfig = async () => {
  const file = fs.readFileSync("../.aptos/config.yaml", "utf8");
  const config = YAML.parse(file);

  const CONTRACT_ADDR = config.profiles.default.account;
  const adminPrivKey = new Ed25519PrivateKey(config.profiles.default.private_key);
  const admin = Account.fromPrivateKey({ privateKey: adminPrivKey });
  const playerPrivKey = new Ed25519PrivateKey(config.profiles.player.private_key);
  const player = Account.fromPrivateKey({ privateKey: playerPrivKey });

  return {
    CONTRACT_ADDR,
    admin,
    player
  }
};

module.exports = {
  readConfig,
};
