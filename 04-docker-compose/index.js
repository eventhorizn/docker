const express = require('express');
const redis = require('redis');

const app = express();
// usually we'd reference a url
// but since we are dockerized, we use image name
const client = redis.createClient({
	host: 'redis-server',
	port: 6379, // default, not required
});

client.set('visits', 0);

app.get('/', (req, res) => {
	client.get('visits', (err, visits) => {
		res.send('Number of visits is ' + visits);
		client.set('visits', parseInt(visits) + 1);
	});
});

app.listen(8081, () => {
	console.log('Listening on port 8081');
});
