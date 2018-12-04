const options = {
  client: 'mysql',
  connection: {
    host: process.env.DBHOST || '127.0.0.1',
    user: process.env.DBUSER || 'root',
    password: process.env.DBPASS,
    database: 'fetchr_db',
  },
};

module.exports = options;
