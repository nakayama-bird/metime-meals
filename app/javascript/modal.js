document.addEventListener('turbo:load', function() {
    const submitButton = document.getElementById('submit-button');
  
    submitButton.addEventListener('click', function(event) {
      event.preventDefault(); // デフォルトの送信を防止
      submitButton.disabled = true; // ボタンを無効化
      document.getElementById('loading-modal').classList.remove('hidden'); // モーダルを表示
  
      // 少し遅延させてフォームを送信
      setTimeout(function() {
        submitButton.form.submit();
      }, 100); // 100ミリ秒遅延させる
    });
  });