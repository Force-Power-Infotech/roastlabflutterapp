import { useEffect, useState } from 'react';

import { api } from '../api/client';

export function VideosPage() {
  const [videos, setVideos] = useState([]);
  const [form, setForm] = useState({
    title: '',
    category: 'Brewing',
    youtubeId: '',
    duration: '',
    description: '',
  });

  useEffect(() => {
    api.get('/admin/videos').then((response) => setVideos(response.data)).catch(() => {
      setVideos([
        {
          _id: 'video_1',
          title: 'Brew Better V60 Cups',
          category: 'Brewing',
          youtubeId: 'AI4ynXzkSQo',
          duration: '11 min',
        },
      ]);
    });
  }, []);

  const submit = async (event) => {
    event.preventDefault();
    try {
      const response = await api.post('/admin/videos', form);
      setVideos((current) => [response.data, ...current]);
    } catch {
      setVideos((current) => [{ _id: String(Date.now()), ...form }, ...current]);
    }
    setForm({ title: '', category: 'Brewing', youtubeId: '', duration: '', description: '' });
  };

  return (
    <div className="page">
      <div className="page-head">
        <div>
          <h1>Video Management</h1>
          <p>Publish learning content for brewing, roasting, grinder guides, and beginners.</p>
        </div>
      </div>
      <div className="grid-two">
        <form className="panel form" onSubmit={submit}>
          <h2>Add video</h2>
          <input
            placeholder="Title"
            value={form.title}
            onChange={(event) => setForm({ ...form, title: event.target.value })}
          />
          <input
            placeholder="Category"
            value={form.category}
            onChange={(event) => setForm({ ...form, category: event.target.value })}
          />
          <input
            placeholder="YouTube ID"
            value={form.youtubeId}
            onChange={(event) => setForm({ ...form, youtubeId: event.target.value })}
          />
          <input
            placeholder="Duration"
            value={form.duration}
            onChange={(event) => setForm({ ...form, duration: event.target.value })}
          />
          <textarea
            placeholder="Description"
            rows="4"
            value={form.description}
            onChange={(event) => setForm({ ...form, description: event.target.value })}
          />
          <button type="submit">Publish video</button>
        </form>
        <div className="panel">
          <h2>Current library</h2>
          <div className="video-list">
            {videos.map((video) => (
              <div key={video._id} className="video-item">
                <div>
                  <strong>{video.title}</strong>
                  <p>
                    {video.category} · {video.duration}
                  </p>
                </div>
                <span>{video.youtubeId}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
