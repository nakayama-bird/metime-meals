document.addEventListener('turbo:load', function() {
    let postImagesInput = document.getElementById('post-images-input');
    let previewImages = document.getElementById('preview-post-images');

    if (!postImagesInput) {
        return;
    }

    postImagesInput.addEventListener('change', function(event) {
        previewImages.innerHTML = '';

        let files = event.target.files;

        if (files.length === 0) {
            return;
        }

        for (let i = 0; i < files.length; i++) {
            let file = files[i];
            let reader = new FileReader();

            reader.onload = function(e) {
                let img = document.createElement('img');
                img.src = e.target.result;
                img.classList.add("w-1/3", "h-auto", "object-contain", "m-2");
                previewImages.appendChild(img);
            }

            reader.onerror = function(e) {
                // 何かエラーハンドリングが必要な場合はここに追加
            }

            reader.readAsDataURL(file);
        }
    });

    // エラーメッセージ表示後に空にする
    // if (document.getElementById('error_explanation')) {
    //     previewImages.innerHTML = '';
    // }
});
