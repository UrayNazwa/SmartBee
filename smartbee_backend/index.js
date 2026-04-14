const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// Mock database
const users = [
  { email: 'user@smartbee.com', password: 'password123', name: 'User' },
  { email: 'fathia@smartbee.com', password: 'password123', name: 'Fathia Suhailah Triadi', class: 'KELAS 12 A - SMA' }
];

app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  console.log(`Login attempt for: ${email}`);

  const user = users.find(u => u.email === email && u.password === password);

  if (user) {
    res.json({
      success: true,
      message: 'Login successful',
      user: { 
        email: user.email,
        name: user.name,
        class: user.class
      }
    });
  } else {
    res.status(401).json({
      success: false,
      message: 'Invalid email or password'
    });
  }
});

app.get('/', (req, res) => {
  res.send('SmartBee Backend is running!');
});

app.listen(port, () => {
  console.log(`SmartBee backend listening at http://localhost:${port}`);
});
