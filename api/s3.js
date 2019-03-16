const multer = require('multer');
const multerS3 = require('multer-s3');
const aws = require('aws-sdk');
const path = require('path');

aws.config.update({
  secretAccessKey: process.env.SECRET_ACCESS_KEY,
  accessKeyId: process.env.ACCESS_KEY_ID,
  region: 'us-east-1', // region of your bucket
});

const s3 = new aws.S3();
const upload = multer({
  storage: multerS3({
    s3,
    bucket: 'fetchrapp',
    acl: 'public-read',
    contentType: multerS3.AUTO_CONTENT_TYPE,
    metadata(req, file, cb) {
      cb(null, { fieldName: file.fieldname });
    },
    key(req, file, cb) {
      cb(null, `Product Photos/${req.body.product_name}${path.extname(file.originalname)}`);
    },
  }),
});

module.exports = upload;
