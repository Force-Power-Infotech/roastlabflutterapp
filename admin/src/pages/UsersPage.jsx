import { useEffect, useState } from 'react';

import { api } from '../api/client';

export function UsersPage() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    api.get('/admin/users').then((response) => setUsers(response.data)).catch(() => {
      setUsers([
        {
          _id: '1',
          name: 'Rohit Menon',
          email: 'rohit@roastlab.app',
          subscriptionTier: 'pro',
          role: 'admin',
        },
        {
          _id: '2',
          name: 'Aisha Bean',
          email: 'aisha@brewmail.com',
          subscriptionTier: 'free',
          role: 'user',
        },
      ]);
    });
  }, []);

  return (
    <div className="page">
      <div className="page-head">
        <div>
          <h1>Users</h1>
          <p>Subscription status, roles, and account visibility.</p>
        </div>
      </div>
      <div className="panel">
        <table className="table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Tier</th>
              <th>Role</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user._id}>
                <td>{user.name}</td>
                <td>{user.email}</td>
                <td>{user.subscriptionTier}</td>
                <td>{user.role}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
