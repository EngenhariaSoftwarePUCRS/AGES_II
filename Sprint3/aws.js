const AWS = require('aws-sdk')

const s3 = new AWS.S3({
    accessKeyId: process.env.ACCESS_KEY_ID,
    secretAccessKey: process.env.SECRET_ACCESS_KEY
})

function uploadFile(filePath, fileName) {
    return new Promise((resolve, reject) => {
        try {
            const fs = require('fs');
            const file = fs.readFileSync(filePath);

            const uploadParams = {
                Bucket: BUCKET_NAME,
                Key: fileName,
                Body: file
            };

            s3.upload(uploadParams, (err, data) => {
                // console.log(1, { err, data })
                if (err) {
                    return reject(err);
                }
                if (data) {
                    return resolve(data);
                }
            });
        } catch (err) {
            return reject(err);
        }
    })
}

uploadFile('./fotos/felipe_freitas.jpg', 'felipe_freitas.jpg')
.then(({ key }) => readFile(key))
.then((data) => {
    console.log(data)
    const image = data.Body.toString('base64')
    console.log(image)
})

function readFile(fileName) {
    return new Promise((resolve, reject) => {
        try {
            const params = {
                Bucket: BUCKET_NAME,
                Key: fileName
            };

            s3.getObject(params, (err, data) => {
                // console.log(2, { err, data })
                if (err) {
                    return reject(err);
                }
                if (data) {
                    return resolve(data);
                }
            });
        } catch (err) {
            return reject(err);
        }
    })
}
