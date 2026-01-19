echo '/* === MOBILE OPTIMIZATION: SECTION PAGES ONLY === */' >> static/css/main.css
echo '@media (max-width: 768px) {' >> static/css/main.css
echo '  main { padding: 16px !important; }' >> static/css/main.css
echo '  section { padding: 0 !important; }' >> static/css/main.css
echo '  .card, .content-card { width: 100% !important; margin: 0 auto 16px auto !important; }' >> static/css/main.css
echo '  .content, .post-content, .page-content { max-width: 100% !important; }' >> static/css/main.css
echo '  h1 { font-size: 1.6rem !important; }' >> static/css/main.css
echo '  h2 { font-size: 1.3rem !important; }' >> static/css/main.css
echo '  h3 { font-size: 1.1rem !important; }' >> static/css/main.css
echo '  p, li { font-size: 0.95rem !important; line-height: 1.5 !important; }' >> static/css/main.css
echo '  table { display: block !important; overflow-x: auto !important; }' >> static/css/main.css
echo '  pre, code { overflow-x: auto !important; }' >> static/css/main.css
echo '}' >> static/css/main.css
