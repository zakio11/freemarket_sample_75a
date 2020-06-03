$(function(){
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <label data-index="${num}" for="item_item_images_attributes_${num}_url">
                      <input class="js-file" type="file"
                      name="item[item_images_attributes][${num}][url]"
                      id="item_item_images_attributes_${num}_url">
                    </label>
                    <span class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<img id = "image-${index}" data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }


  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('url', blobUrl);
    } else {  
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#file-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
    if (fileIndex.length == 10) {
      $(".js-file_group").css('display', 'none')   
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    var targetCheckBox = "#destroy-" + targetIndex;
    const hiddenCheck = $(targetCheckBox);
    if (hiddenCheck.length) {
      hiddenCheck.prop('checked', true);
    }
    var id_str = '#image-' + targetIndex;
    var isExist = $(id_str).length;
    if(isExist) $(this).parent().remove();
    $(id_str).remove();
    if ($('.js-file').length == 0) $('#file-box').append(buildFileField(fileIndex[0]));
  });
});