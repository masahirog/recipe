function onLoad() {
  // メニュー選択にselect2を適用
  initProductMenuSelect2();

  // 保存方法プリセット選択の処理
  $(document).on('click', '.preservation-preset', function(e) {
    e.preventDefault();
    const preservationText = $(this).data('value');
    $('#how_to_save_field').val(preservationText);
  });

  // 原価率計算の初期化
  function updateCostRatio() {
    var sellPrice = parseFloat($('.product_sell_price').val()) || 0;
    var costPrice = parseFloat($('.product_cost_price').val()) || 0;
    
    var costRatio = 0;
    if (sellPrice > 0) {
      costRatio = (costPrice / sellPrice) * 100;
    }
    
    // 原価率を表示（小数点第1位まで）
    $('.product_cost_ratio').val(costRatio.toFixed(1));
    
    // 原価率によって色を変更
    if (costRatio >= 30) {
      $('.product_cost_ratio').addClass('text-danger').removeClass('text-success');
    } else {
      $('.product_cost_ratio').addClass('text-success').removeClass('text-danger');
    }
  }
  
  // 売価が変更されたときに原価率を更新
  $('.product_sell_price').on('change keyup', function() {
    updateCostRatio();
  });
  
  // ページ読み込み時に初期化
  updateCostRatio();
  
  // メッセージを表示する関数
  function showMessage(message, type) {
    const alertDiv = $('<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                      message +
                      '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="閉じる"></button>' +
                      '</div>');
    
    // メッセージを表示
    $('#message-container').html(alertDiv);
    
    // 数秒後に自動的に消える
    setTimeout(function() {
      alertDiv.alert('close');
    }, 5000);
  }
  
  // メニュー選択にselect2を適用する関数
  function initProductMenuSelect2() {
    // 既存のselect2を破棄（二重初期化防止）
    $('.menu-select').each(function() {
      if ($(this).hasClass('select2-hidden-accessible')) {
        $(this).select2('destroy');
      }
    });

    // select2を適用
    $('.menu-select').select2({
      placeholder: 'メニューを選択',
      allowClear: true,
      width: '100%'
    });

    // select2の選択イベントを設定
    $('.menu-select').on('select2:select', function(e) {
      // 既存のchangeイベントを手動でトリガー
      $(this).trigger('change');
    });
  }

  // 商品メニュー追加時のイベント
  $("#product_menus-container").on('cocoon:after-insert', function(e, insertedItem) {
    // 新しく追加されたメニュー選択に対してselect2を適用
    const newSelect = insertedItem.find('.menu-select');
    
    if (newSelect.length) {
      newSelect.select2({
        placeholder: 'メニューを選択',
        allowClear: true,
        width: '100%'
      });
      
      // フォーカスを設定
      setTimeout(function() {
        newSelect.select2('focus');
      }, 100);
    }
  });

  // フォーム送信時のバリデーション
  $('#product-form').on('submit', function(e) {
    // 必須項目のチェック
    const requiredFields = $('.form-control.required');
    let hasErrors = false;
    
    requiredFields.each(function() {
      if (!$(this).val()) {
        $(this).addClass('is-invalid');
        hasErrors = true;
      } else {
        $(this).removeClass('is-invalid');
      }
    });
    
    if (hasErrors) {
      e.preventDefault();
      showMessage('必須項目が入力されていません。', 'danger');
      
      // 最初のエラーフィールドにフォーカス
      $('.form-control.is-invalid').first().focus();
    }
  });
  
  // Turbo処理前のselect2のクリーンアップ
  $(document).on('turbo:before-cache', function() {
    $('.menu-select.select2-hidden-accessible').select2('destroy');
  });

  // 画像削除ボタンのイベント処理
  $(document).on('click', '.image-delete-btn', function() {
    if (confirm('画像を削除してもよろしいですか？')) {
      // 画像削除用のhidden fieldを追加
      $('#product-form').append('<input type="hidden" name="product[remove_image]" value="1">');
      
      // 画像プレビューを非表示
      $(this).closest('.card-body').find('.img-thumbnail').parent().hide();
      
      // ファイル選択をクリア
      $('#product_image').val('');
      
      // ボタンを無効化
      $(this).prop('disabled', true);
    }
  });

  // 画像プレビュー機能
  $('#product_image').on('change', function() {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();
      const imgPreviewContainer = $(this).closest('.card-body').find('.img-preview');
      
      reader.onload = function(e) {
        // 既存のプレビューがなければ作成
        if (imgPreviewContainer.length === 0) {
          $(this).closest('.card-body').append(
            '<div class="mt-3 text-center img-preview">' +
            '<img src="' + e.target.result + '" class="img-thumbnail" style="max-height: 300px;">' +
            '</div>'
          );
        } else {
          // 既存のプレビューを更新
          imgPreviewContainer.find('img').attr('src', e.target.result);
          imgPreviewContainer.show();
        }
        
        // 削除ボタンを有効化
        $('.image-delete-btn').prop('disabled', false);
      }.bind(this);
      
      reader.readAsDataURL(file);
    }
  });

  // 商品一覧の検索機能
  function initProductSearch() {
    // Enterキーで検索を実行
    $('.js-product-search').on('keypress', function(e) {
      if (e.which === 13) { // Enterキー
        e.preventDefault();
        performSearch();
      }
    });
    
    // カテゴリフィルタのイベント
    $('.js-category-filter').on('change', function() {
      performSearch();
    });
    
    // 検索実行関数
    function performSearch() {
      const searchText = $('.js-product-search').val();
      const category = $('.js-category-filter').val();
      const params = new URLSearchParams();
      
      if (searchText) {
        params.append('search', searchText);
      }
      
      if (category) {
        params.append('category', category);
      }
      
      // Turboを使用してページを更新
      const url = window.location.pathname + '?' + params.toString();
      Turbo.visit(url);
    }
    
    // URLパラメータから初期値を設定
    const urlParams = new URLSearchParams(window.location.search);
    const searchParam = urlParams.get('search');
    const categoryParam = urlParams.get('category');
    
    if (searchParam) {
      $('.js-product-search').val(searchParam);
    }
    
    if (categoryParam) {
      $('.js-category-filter').val(categoryParam);
    }
  }

  // 商品一覧ページの場合のみ検索機能を初期化
  if ($('.js-product-search').length > 0) {
    initProductSearch();
  }
}

// ページ読み込み時に初期化
document.addEventListener("DOMContentLoaded", onLoad);
document.addEventListener("turbo:load", onLoad);