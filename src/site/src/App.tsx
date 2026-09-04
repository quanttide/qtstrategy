import { Link, Outlet } from 'react-router-dom'

export default function App() {
  return (
    <div className="app">
      <header>
        <h1>量潮战略中心</h1>
        <nav>
          <Link to="/">首页</Link>
          <Link to="/strategies">战略档案</Link>
        </nav>
      </header>
      <main>
        <Outlet />
      </main>
      <footer>© 2026 量潮 · 战略管理档案公开披露</footer>
    </div>
  )
}
