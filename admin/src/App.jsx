import { NavLink, Route, Routes } from 'react-router-dom';

import { DashboardPage } from './pages/DashboardPage';
import { UsersPage } from './pages/UsersPage';
import { VideosPage } from './pages/VideosPage';

const links = [
  { to: '/', label: 'Analytics' },
  { to: '/users', label: 'Users' },
  { to: '/videos', label: 'Videos' },
];

export function App() {
  return (
    <div className="admin-shell">
      <aside className="sidebar">
        <div>
          <div className="brand">RoastLab Admin</div>
          <p className="brand-copy">Moderation, premium ops, and content control.</p>
        </div>
        <nav className="nav">
          {links.map((link) => (
            <NavLink
              key={link.to}
              to={link.to}
              end={link.to === '/'}
              className={({ isActive }) => (isActive ? 'nav-link active' : 'nav-link')}
            >
              {link.label}
            </NavLink>
          ))}
        </nav>
      </aside>
      <main className="content">
        <Routes>
          <Route path="/" element={<DashboardPage />} />
          <Route path="/users" element={<UsersPage />} />
          <Route path="/videos" element={<VideosPage />} />
        </Routes>
      </main>
    </div>
  );
}
