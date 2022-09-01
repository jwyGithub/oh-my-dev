const path = require('path');
const http = require('http');
const fs = require('fs');

const base_os = {
    content: path.resolve(__dirname, './repo/CentOS-Stream-BaseOS.repo'),
    url: '/base_os'
};
const stream = {
    content: path.resolve(__dirname, './repo/CentOS-Stream-AppStream.repo'),
    url: '/stream'
};

const repo = {
    content: path.resolve(__dirname, './local/repo.sh'),
    url: '/repo'
};

function getIPAddress() {
    var interfaces = require('os').networkInterfaces();
    for (var devName in interfaces) {
        var iface = interfaces[devName];
        for (var i = 0; i < iface.length; i++) {
            var alias = iface[i];
            if (alias.family === 'IPv4' && alias.address !== '127.0.0.1' && !alias.internal) {
                return alias.address;
            }
        }
    }
}

function createServe() {
    try {
        return http.createServer((req, res) => {
            console.log(`request info : ${req.url}`);
            if (req.url === '/base_os') {
                res.end(fs.readFileSync(base_os.content), 'utf-8');
            } else if (req.url === '/stream') {
                res.end(fs.readFileSync(stream.content), 'utf-8');
            } else if (req.url === '/repo') {
                res.end(fs.readFileSync(repo.content), 'utf-8');
            } else {
                res.end('');
            }
        });
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    createServe,
    getIPAddress
};

