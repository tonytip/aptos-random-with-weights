require("dotenv").config();
const dayjs = require("dayjs");
const { sendTx, view } = require("./utils");
const { readConfig } = require("./config");

const main = async () => {
  const config = await readConfig();
  const ts = dayjs().unix();
  await sendTx(config.player, `${config.CONTRACT_ADDR}::main::roll`, [ts]);
  const data = await view(`${config.CONTRACT_ADDR}::main::get_random_result`, [config.player.accountAddress, ts]);
  console.log(data);
};

main();
