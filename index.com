<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GracePrint Kids</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@400;600&family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
  
  <style>
    body { 
      font-family: 'Nunito', sans-serif; 
      background: linear-gradient(180deg, #E0F7FA 0%, #FFFFFF 100%);
      min-height: 100vh;
    }
    
    h1, h2, h3, .font-bubbly { font-family: 'Fredoka', sans-serif; }

    .btn-magic { 
      background: linear-gradient(135deg, #00C6FF 0%, #0072FF 100%);
      box-shadow: 0 4px 15px rgba(0, 114, 255, 0.3);
      transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .btn-magic:hover { transform: scale(1.05) translateY(-2px); box-shadow: 0 8px 20px rgba(0, 114, 255, 0.4); }
    .btn-magic:active { transform: scale(0.95); }

    .show-card { transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
    .show-card:hover { transform: scale(1.05) rotate(1deg); z-index: 10; }
    
    .play-overlay { background: rgba(0, 0, 0, 0.3); opacity: 0; transition: opacity 0.3s ease; }
    .show-card:hover .play-overlay { opacity: 1; }

    .modal-backdrop { background-color: rgba(14, 11, 22, 0.9); backdrop-filter: blur(5px); }
    .hidden { display: none !important; }

    .format-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        padding: 4px 10px;
        border-radius: 12px;
        font-weight: 800;
        font-size: 0.7rem;
        color: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        z-index: 20;
    }
    .badge-pdf { background-color: #EF4444; } 
    .badge-epub { background-color: #10B981; } 

    @keyframes bounce-gentle {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }
    .animate-bounce-custom { animation: bounce-gentle 2s infinite; }
  </style>
</head>
<body>

  <div id="loginSection" class="min-h-screen flex flex-col items-center justify-center p-6 relative overflow-hidden">
    <div class="absolute top-10 left-10 w-32 h-32 bg-yellow-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-pulse"></div>
    <div class="absolute bottom-10 right-10 w-32 h-32 bg-blue-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-pulse" style="animation-delay: 1s;"></div>

    <div class="bg-white/80 backdrop-blur-md p-10 md:p-14 rounded-[3rem] shadow-2xl w-full max-w-md text-center border-4 border-white relative z-10">
      
      <div class="mb-6 flex justify-center">
        <img src="https://drive.google.com/thumbnail?id=1iL6LGoJa4v6_Rb2hwLjwGGk1nk1R2rE1&sz=w400" 
             class="w-40 h-auto animate-bounce-custom drop-shadow-lg" 
             alt="GracePrint Logo">
      </div>
      
      <h1 class="text-4xl font-bold text-blue-900 mb-2 tracking-wide font-bubbly">GracePrint<span class="text-yellow-500">Kids</span></h1>
      <p class="text-slate-500 mb-8 font-bold text-lg">Your adventure starts here!</p>
      
      <input type="email" id="userEmail" placeholder="Enter your email here..." 
             class="w-full p-5 bg-blue-50 border-none rounded-2xl mb-6 outline-none focus:ring-4 focus:ring-blue-200 text-center text-xl font-bold text-blue-800 placeholder-blue-300 transition-all shadow-inner">
      
      <button onclick="login()" class="w-full btn-magic text-white font-bold py-4 rounded-2xl text-xl tracking-wide uppercase">
        Enter
      </button>
    </div>
  </div>

  <div id="mainSection" class="hidden">
    
    <nav class="fixed top-0 left-0 right-0 z-50 px-4 py-3">
      <div class="max-w-6xl mx-auto bg-white/90 backdrop-blur-md rounded-full shadow-lg px-6 py-2 flex justify-between items-center border border-white/50">
        <div class="flex items-center gap-3">
           <img src="https://drive.google.com/thumbnail?id=1iL6LGoJa4v6_Rb2hwLjwGGk1nk1R2rE1&sz=w100" class="h-12 w-auto" alt="Logo">
           <span class="font-bubbly text-2xl font-bold text-blue-800 hidden sm:block">GracePrint<span class="text-yellow-500">Kids</span></span>
        </div>
        
        <div class="flex items-center gap-4">
          <span class="text-sm font-bold text-slate-400 hidden md:block" id="userDisplay">Hello, Believer</span>
          <button onclick="location.reload()" class="bg-red-50 text-red-400 hover:bg-red-500 hover:text-white px-5 py-2 rounded-full font-bold transition-colors text-sm border-2 border-red-100">
            Logout
          </button>
        </div>
      </div>
    </nav>

    <header class="relative mt-24 md:mt-28 w-[95%] mx-auto rounded-[2.5rem] overflow-hidden shadow-2xl h-56 md:h-96 group border-4 border-white bg-blue-100">
      <img src="https://drive.google.com/thumbnail?id=163oB2qTOX727a2zwZy8gOhHP-xOGblSa&sz=w3000" 
           class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-[3s]" 
           alt="GracePrint Family Banner">
      
      <div class="absolute inset-0 bg-gradient-to-t from-blue-900/90 via-transparent to-transparent flex flex-col justify-end p-6 md:p-12">
        <h2 class="text-white text-3xl md:text-5xl font-bubbly drop-shadow-lg mb-2">Stories that Transform</h2>
        <p class="text-blue-100 text-sm md:text-xl font-bold max-w-2xl drop-shadow-md bg-black/20 backdrop-blur-sm p-2 rounded-lg inline-block">Biblical resources to learn and color together as a family.</p>
      </div>
    </header>

    <main class="max-w-7xl mx-auto p-6 md:p-10 pb-24">
      
      <div id="adminUpload" class="hidden mb-12 bg-yellow-50 p-8 rounded-[2rem] border-4 border-yellow-200 border-dashed text-center relative overflow-hidden shadow-inner">
        <div class="relative z-10">
          <h3 class="text-2xl font-bold text-yellow-700 mb-2 font-bubbly">Teacher Panel</h3>
          <p class="text-yellow-600 mb-6 font-bold">Upload new books (PDF or EPUB) here</p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <input type="file" id="fileInput" accept="application/pdf, application/epub+zip" class="block w-full text-sm text-slate-500 file:mr-4 file:py-3 file:px-6 file:rounded-full file:border-0 file:text-sm file:font-bold file:bg-yellow-200 file:text-yellow-800 hover:file:bg-yellow-300 cursor-pointer">
            <button onclick="handleUpload()" id="uploadBtn" class="bg-yellow-500 hover:bg-yellow-600 text-white px-8 py-3 rounded-full font-bold shadow-lg transition-transform hover:scale-105">Publish Book</button>
          </div>
        </div>
      </div>

      <div class="flex items-center gap-3 mb-8 ml-2">
        <div class="bg-blue-100 p-2 rounded-full"><span class="text-2xl">📚</span></div>
        <h3 class="text-3xl font-bold text-slate-700 font-bubbly">Available Books</h3>
      </div>

      <div id="fileList" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8"></div>
    </main>
  </div>

  <div id="pdfModal" class="fixed inset-0 modal-backdrop z-[100] hidden flex flex-col items-center justify-center p-4">
    <div class="w-full max-w-6xl h-[85vh] bg-white rounded-[2rem] overflow-hidden shadow-2xl flex flex-col relative"> 
      <div class="bg-blue-600 p-4 flex justify-between items-center text-white">
        <div class="flex items-center gap-2">
            <span class="text-xl">📖</span>
            <span id="pdfTitle" class="font-bold text-lg truncate px-2 font-bubbly">Reading</span>
        </div>
        <button onclick="closeModal()" class="bg-white/20 hover:bg-white/40 rounded-full p-2 transition-colors">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
        </button>
      </div>
      <iframe id="pdfIframe" src="" class="flex-1 w-full border-none bg-slate-100"></iframe>
    </div>
  </div>

  <script>
    const ADMINS = ['tv.editores@gmail.com', 'eliezeralvarado@gmail.com', 'maryta68c@gmail.com'];
    let currentUser = "";

    function login() {
      const email = document.getElementById('userEmail').value.toLowerCase().trim();
      if (email.includes('@')) {
        currentUser = email;
        google.script.run.registrarAcceso(currentUser);
        document.getElementById('loginSection').style.display = 'none';
        document.getElementById('mainSection').classList.remove('hidden');
        document.getElementById('userDisplay').innerText = "Hello, " + email.split('@')[0];
        if (ADMINS.includes(currentUser)) {
          document.getElementById('adminUpload').classList.remove('hidden');
        }
        loadFiles();
      } else {
        alert("Oops! We need a valid email to enter. 📧");
      }
    }

    function loadFiles() {
      const list = document.getElementById('fileList');
      list.innerHTML = `<div class="col-span-full flex flex-col items-center py-20"><div class="w-16 h-16 border-4 border-blue-200 border-t-blue-600 rounded-full animate-spin mb-4"></div><p class="text-blue-400 font-bold text-xl animate-pulse font-bubbly">Looking for magic books...</p></div>`;
      
      google.script.run.withSuccessHandler(files => {
        if (files.length === 0) {
          list.innerHTML = '<div class="col-span-full text-center py-10 text-slate-400 font-bold text-xl">No stories here yet 😢</div>';
          return;
        }
        list.innerHTML = '';
        files.forEach(f => {
          const isEpub = f.name.toLowerCase().endsWith('.epub');
          const badgeClass = isEpub ? 'badge-epub' : 'badge-pdf';
          const badgeText = isEpub ? 'EPUB' : 'PDF';

          list.innerHTML += `
            <div class="show-card bg-white rounded-[2rem] shadow-lg overflow-hidden cursor-pointer relative group aspect-[3/4]" onclick="openPdf('${f.url}', '${f.name}')">
              
              <div class="format-badge ${badgeClass}">${badgeText}</div>

              <img src="${f.thumbnail}" class="w-full h-full object-cover" alt="${f.name}">
              <div class="play-overlay absolute inset-0 flex items-center justify-center">
                <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center shadow-lg transform scale-0 group-hover:scale-100 transition-transform duration-300">
                  <svg class="w-8 h-8 text-blue-600 ml-1" fill="currentColor" viewBox="0 0 20 20"><path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"/></svg>
                </div>
              </div>
              <div class="absolute bottom-0 left-0 right-0 p-4 bg-gradient-to-t from-black/80 to-transparent pt-12">
                <h4 class="text-white font-bold text-lg truncate drop-shadow-md text-center font-bubbly">${f.name}</h4>
              </div>
            </div>`;
        });
      }).getFiles();
    }

    function openPdf(url, name) {
      const modal = document.getElementById('pdfModal');
      const iframe = document.getElementById('pdfIframe');
      iframe.src = url.replace('/view', '/preview');
      document.getElementById('pdfTitle').innerText = name;
      modal.classList.remove('hidden');
      modal.style.display = 'flex';
    }

    function closeModal() {
      const modal = document.getElementById('pdfModal');
      const iframe = document.getElementById('pdfIframe');
      modal.classList.add('hidden');
      modal.style.display = 'none';
      iframe.src = "";
    }

    function handleUpload() {
      const input = document.getElementById('fileInput');
      const btn = document.getElementById('uploadBtn');
      if (!input.files[0]) return;
      const file = input.files[0];
      const reader = new FileReader();
      btn.disabled = true; btn.innerHTML = "Uploading... 🚀";
      
      reader.onload = e => {
        google.script.run.withSuccessHandler(res => {
          if(res.success) { 
            alert("Book published! 🎉"); 
            input.value = ""; 
            loadFiles(); 
          } else { 
            alert("Error: " + res.error); 
          }
          btn.disabled = false; btn.innerText = "Publish Book";
        }).uploadFile(e.target.result, file.name, currentUser);
      };
      reader.readAsDataURL(file);
    }
  </script>
</body>
</html>
