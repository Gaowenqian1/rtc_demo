function chooseFile () {

    var input = event.target;
    if(input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            // document.querySelector("#photo").src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}