let http = require('http');
let fs = require('fs');
const path = require('path');

let server = http.createServer((req, res) => {
    if (req.url.indexOf('/base') !== -1) {
        const content = fs.readFileSync(path.resolve(__dirname, './CentOS-Stream-BaseOS.repo'), 'utf-8');
        res.end(content);
    } else if (req.url.indexOf('/stream') !== -1) {
        const content = fs.readFileSync(path.resolve(__dirname, './CentOS-Stream-AppStream.repo'), 'utf-8');
        res.end(content);
    } else if (req.url.indexOf('/repo-local') !== -1) {
        const content = fs.readFileSync(path.resolve(__dirname, '../repo-local.sh'), 'utf-8');
        res.end(content);
    } else {
        res.end('');
    }
});
server.listen(8090, () => {
    console.log('server is running');
});

