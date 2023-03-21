const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('certs/server.key'),
  cert: fs.readFileSync('certs/server.crt'),
  ca: fs.readFileSync('certs/ca.crt'),
  requestCert: true,
  rejectUnauthorized: true
};

https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end('Guia de AppSec');
}).listen(443);
