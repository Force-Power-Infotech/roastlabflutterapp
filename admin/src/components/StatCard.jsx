export function StatCard({ label, value, caption }) {
  return (
    <div className="panel stat-card">
      <span className="label">{label}</span>
      <strong className="value">{value}</strong>
      <span className="caption">{caption}</span>
    </div>
  );
}
