document.addEventListener('DOMContentLoaded', function() {
    let postImagesInput = document.getElementById('post-images-input');
    let previewImages = document.getElementById('preview-post-images');

    postImagesInput.addEventListener('change', function(event) {
        // 新しい画像が選択された場合、既存のプレビュー画像を消す
        previewImages.innerHTML = '';

        let files = event.target.files;

        for (let i = 0; i < files.length; i++) {
            let file = files[i];
            let reader = new FileReader();

            reader.onload = function(e) {
                let img = document.createElement('img');
                img.src = e.target.result;
                img.classList.add("w-1/3", "h-auto", "object-contain", "m-2");
                previewImages.appendChild(img);
            }

            reader.readAsDataURL(file);
        }
    });
});