echo '/* === HARD MOBILE OVERRIDE === */' >> static/css/main.css
echo '@media (max-width: 768px) {' >> static/css/main.css
echo '  body * { max-width: 100% !important; }' >> static/css/main.css
echo '  main, section, article, .container, .content, .page, .wrapper { width: 100% !important; margin: 0 !important; padding: 12px !important; }' >> static/css/main.css
echo '  .grid, .row, .col { display: block !important; width: 100% !important; }' >> static/css/main.css
echo '  h1 { font-size: 1.5rem !important; }' >> static/css/main.css
echo '  h2 { font-size: 1.25rem !important; }' >> static/css/main.css
echo '  h3 { font-size: 1.1rem !important; }' >> static/css/main.css
echo '  p, li { font-size: 0.95rem !important; line-height: 1.5 !important; }' >> static/css/main.css
echo '  table { display: block !important; overflow-x: auto !important; }' >> static/css/main.css
echo '  pre, code { overflow-x: auto !important; }' >> static/css/main.css
echo '}' >> static/css/main.css
