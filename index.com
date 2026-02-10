<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GracePrint Kids</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@400;600&family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Nunito', sans-serif; background: linear-gradient(180deg, #E0F7FA 0%, #FFFFFF 100%); min-height: 100vh; }
    h1, h2, h3, .font-bubbly { font-family: 'Fredoka', sans-serif; }
    .show-card { transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
    .show-card:hover { transform: scale(1.05); }
    .btn-download { background: linear-gradient(135deg, #00C6FF 0%, #0072FF 100%); }
  </style>
</head>
<body>

  <nav class="p-6">
    <div class="max-w-6xl mx-auto flex justify-between items-center bg-white/80 backdrop-blur-md p-4 rounded-3xl shadow-lg">
      <h1 class="text-2xl font-bold text-blue-900 font-bubbly">GracePrint<span class="text-yellow-500">Kids</span></h1>
      <span class="text-sm font-bold text-blue-400">Welcome! 📚</span>
    </div>
  </nav>

  <main class="max-w-6xl mx-auto p-6">
    <header class="text-center mb-12">
      <h2 class="text-4xl font-bold text-blue-800 mb-4 font-bubbly">Download Your Books</h2>
      <p class="text-slate-600">Scan, click, and enjoy your Bible stories!</p>
    </header>

    <div id="fileList" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      <p class="col-span-full text-center text-blue-400 animate-pulse">Loading magic books...</p>
    </div>
  </main>

  <script>
    // 1. REEMPLAZA ESTA URL con la URL de "Ejecución" de tu Google Web App
    const WEB_APP_URL = "TU_URL_DE_GOOGLE_APPS_SCRIPT_AQUI";

    async function loadBooks() {
      const list = document.getElementById('fileList');
      try {
        const response = await fetch(WEB_APP_URL);
        const files = await response.json();
        
        list.innerHTML = '';
        files.forEach(f => {
          list.innerHTML += `
            <div class="show-card bg-white rounded-[2.5rem] shadow-xl overflow-hidden border-4 border-white">
              <img src="${f.thumbnail}" class="w-full h-52 object-cover">
              <div class="p-6 text-center">
                <h3 class="font-bold text-xl text-slate-800 mb-4 truncate">${f.name}</h3>
                <a href="${f.url}" target="_blank" class="btn-download block w-full py-3 rounded-2xl text-white font-bold shadow-lg hover:opacity-90 transition-all">
                  Download Now ⬇️
                </a>
              </div>
            </div>`;
        });
      } catch (error) {
        list.innerHTML = '<p class="col-span-full text-center text-red-400">Error loading books. Please refresh.</p>';
      }
    }

    loadBooks();
  </script>
</body>
</html>
