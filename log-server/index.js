const express = require("express");
const app = express();
const port = 3000;

app.use(express.json());

app.post("/logs", (req, res) => {
  const logData = req.body;
  console.log("Received log:", logData);
  res.status(200).send("Log received");
});

app.listen(port, () => {
  console.log(`Log server listening at http://localhost:${port}`);
});
