import { useEffect, useState } from 'react'
import './App.css'

const WELCOME_TEXT =
  'Improve your working memory by mentally converting numbers between numeral systems in challenging exercises.'

function useTypewriter(text: string, speed = 40) {
  const [count, setCount] = useState(0)

  useEffect(() => {
    const id = setInterval(() => {
      setCount((c) => {
        if (c >= text.length) {
          clearInterval(id)
          return c
        }
        return c + 1
      })
    }, speed)

    return () => clearInterval(id)
  }, [text, speed])

  return { typed: text.slice(0, count), done: count >= text.length }
}

function App() {
  const { typed, done } = useTypewriter(WELCOME_TEXT)

  return (
    <div className="terminal">
      <h1 className="title">Brain-Train</h1>

      <main className="content">
        <p className="welcome" aria-label={WELCOME_TEXT}>
          {typed}
          <span className="caret" aria-hidden="true"></span>
        </p>
        {done && (
          <div className="actions">
            <button type="button" className="btn">
              Try it
            </button>
            <button type="button" className="btn">
              Login
            </button>
          </div>
        )}
      </main>

      <div className="scanlines" aria-hidden="true"></div>
    </div>
  )
}

export default App