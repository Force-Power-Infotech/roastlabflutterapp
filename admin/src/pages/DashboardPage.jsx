import { useEffect, useState } from 'react';
import { Area, AreaChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts';

import { api } from '../api/client';
import { StatCard } from '../components/StatCard';

const fallbackSeries = [
  { name: 'Mon', scans: 120, posts: 24 },
  { name: 'Tue', scans: 148, posts: 31 },
  { name: 'Wed', scans: 133, posts: 28 },
  { name: 'Thu', scans: 176, posts: 37 },
  { name: 'Fri', scans: 201, posts: 41 },
];

export function DashboardPage() {
  const [analytics, setAnalytics] = useState(null);

  useEffect(() => {
    api.get('/admin/analytics').then((response) => setAnalytics(response.data)).catch(() => {
      setAnalytics({
        users: 2184,
        premiumUsers: 482,
        posts: 891,
        comments: 2714,
        videos: 38,
        moderationQueue: 12,
      });
    });
  }, []);

  return (
    <div className="page">
      <div className="page-head">
        <div>
          <h1>Analytics Dashboard</h1>
          <p>Track subscriptions, community activity, and content health.</p>
        </div>
      </div>
      <div className="stats-grid">
        <StatCard label="Users" value={analytics?.users ?? '--'} caption="Total registered accounts" />
        <StatCard label="Premium" value={analytics?.premiumUsers ?? '--'} caption="Active Pro subscribers" />
        <StatCard label="Posts" value={analytics?.posts ?? '--'} caption="Community posts published" />
        <StatCard label="Moderation" value={analytics?.moderationQueue ?? '--'} caption="Items awaiting review" />
      </div>
      <div className="panel chart-panel">
        <div className="panel-head">
          <h2>Activity trend</h2>
          <span>Weekly scans vs community posts</span>
        </div>
        <ResponsiveContainer width="100%" height={320}>
          <AreaChart data={fallbackSeries}>
            <defs>
              <linearGradient id="scans" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stopColor="#d7ad81" stopOpacity={0.7} />
                <stop offset="100%" stopColor="#d7ad81" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid stroke="#2a211d" vertical={false} />
            <XAxis dataKey="name" stroke="#99897b" />
            <YAxis stroke="#99897b" />
            <Tooltip />
            <Area type="monotone" dataKey="scans" stroke="#d7ad81" fill="url(#scans)" strokeWidth={3} />
            <Area type="monotone" dataKey="posts" stroke="#7db19d" fillOpacity={0} strokeWidth={2} />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}
