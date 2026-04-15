const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const users = [
  { email: 'user@smartbee.com', password: 'password123', name: 'User', role: 'siswa', class: 'KELAS 12 A - SMA' },
  { email: 'fathia@smartbee.com', password: 'password123', name: 'Fathia Suhailah Triadi', role: 'siswa', class: 'KELAS 12 A - SMA' },
  { email: 'guru@smartbee.com', password: 'password123', name: 'Dr. ANDI WIJAYA', role: 'guru', title: 'GURU MATEMATIKA' },
  { email: 'admin@smartbee.com', password: 'password123', name: 'Super Admin', role: 'super_admin' }
];

const mockData = {
  students: [
    { id: 1, name: 'Ahmad Fauzi', class: 'KELAS 10 A', activity: 45 },
    { id: 2, name: ' Siti Nurhaliza', class: 'KELAS 10 B', activity: 38 },
    { id: 3, name: 'Budi Santoso', class: 'KELAS 11 A', activity: 52 },
    { id: 4, name: 'Dewi Lestari', class: 'KELAS 11 B', activity: 41 },
    { id: 5, name: 'Eko Prasetyo', class: 'KELAS 12 A', activity: 49 },
    { id: 6, name: 'Fani Rahmawati', class: 'KELAS 12 B', activity: 35 },
  ],
  activities: [
    { date: '2024-04-01', count: 120 },
    { date: '2024-04-02', count: 145 },
    { date: '2024-04-03', count: 98 },
    { date: '2024-04-04', count: 167 },
    { date: '2024-04-05', count: 132 },
    { date: '2024-04-06', count: 89 },
    { date: '2024-04-07', count: 156 },
  ]
};

const authenticate = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ success: false, message: 'Unauthorized' });
  }
  const token = authHeader.split(' ')[1];
  const user = users.find(u => u.token === token);
  if (!user) {
    return res.status(401).json({ success: false, message: 'Invalid token' });
  }
  req.user = user;
  next();
};

const rolesGuard = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user || !allowedRoles.includes(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Forbidden: Insufficient permissions' });
    }
    next();
  };
};

app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  const user = users.find(u => u.email === email && u.password === password);

  if (user) {
    const token = 'token_' + Date.now();
    user.token = token;
    const { password, token: _, ...userData } = user;
    res.json({ success: true, message: 'Login successful', user: userData, token });
  } else {
    res.status(401).json({ success: false, message: 'Invalid email or password' });
  }
});

app.get('/api/dashboard-stats', authenticate, (req, res) => {
  res.json({
    success: true,
    data: {
      totalStudents: mockData.students.length,
      totalActivities: mockData.activities.reduce((sum, a) => sum + a.count, 0),
      recentActivities: mockData.activities.slice(-7),
      topStudents: mockData.students.sort((a, b) => b.activity - a.activity).slice(0, 5)
    }
  });
});

app.get('/api/users', authenticate, rolesGuard('super_admin'), (req, res) => {
  const safeUsers = users.map(({ password, token, ...u }) => u);
  res.json({ success: true, users: safeUsers });
});

app.put('/api/users/:id', authenticate, rolesGuard('super_admin'), (req, res) => {
  const { id } = req.params;
  const userIndex = users.findIndex(u => u.id === parseInt(id) || u.email === id);
  if (userIndex === -1) {
    return res.status(404).json({ success: false, message: 'User not found' });
  }
  users[userIndex] = { ...users[userIndex], ...req.body };
  const { password, token, ...updatedUser } = users[userIndex];
  res.json({ success: true, message: 'User updated', user: updatedUser });
});

app.delete('/api/users/:id', authenticate, rolesGuard('super_admin'), (req, res) => {
  const { id } = req.params;
  const userIndex = users.findIndex(u => u.id === parseInt(id) || u.email === id);
  if (userIndex === -1) {
    return res.status(404).json({ success: false, message: 'User not found' });
  }
  users.splice(userIndex, 1);
  res.json({ success: true, message: 'User deleted' });
});

app.get('/api/system-config', authenticate, rolesGuard('super_admin'), (req, res) => {
  res.json({
    success: true,
    config: {
      appName: 'SmartBee',
      version: '1.0.0',
      maintenanceMode: false,
      maxUploadSize: '10MB'
    }
  });
});

app.get('/', (req, res) => {
  res.send('SmartBee Backend is running!');
});

app.listen(port, () => {
  console.log(`SmartBee backend listening at http://localhost:${port}`);
});