const https = require('https');
const fs = require('fs');

const options = {
  hostname: 'localhost',
  port: 443,
  path: '/',
  method: 'GET',
  key: fs.readFileSync('certs/client.key'),
  cert: fs.readFileSync('certs/client.crt'),
  ca: fs.readFileSync('certs/ca.crt'),
  rejectUnauthorized: true
};

https.request(options, (res) => {
  console.log(`statusCode: ${res.statusCode}`);
  res.on('data', (d) => {
    process.stdout.write(d);
  });
}).end();
