#!/usr/bin/env node

const { createServe, getIPAddress } = require('../index');

function getEnv() {
    const args = process.argv.slice(2);
    return args.reduce((envs, item) => {
        const name = item.split('=')[0];
        const value = item.split('=')[1];
        envs[name] = value;
        return envs;
    }, {});
}

const env = getEnv();
const port = env.PORT || 20202;

createServe().listen(port, () =>
    console.log(`
    serve running at http://${getIPAddress()}:${port}   \n
    you can use curl http://${getIPAddress()}:${port}/repo | SERVER=${getIPAddress()} sh
`)
);

