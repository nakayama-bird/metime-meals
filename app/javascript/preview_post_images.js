document.addEventListener('turbo:load', function() {
    let postImagesInput = document.getElementById('post-images-input');
    let previewImages = document.getElementById('preview-post-images');

    if (!postImagesInput) {
        console.error('No element found with ID "post-images-input"');
        return;
    }

    postImagesInput.addEventListener('change', function(event) {
        previewImages.innerHTML = '';

        let files = event.target.files;

        if (files.length === 0) {
            console.warn('No files selected.');
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
                console.log('Image loaded:', e.target.result);
            }

            reader.onerror = function(e) {
                console.error('Error reading file:', file.name);
            }

            reader.readAsDataURL(file);
        }
    });
});