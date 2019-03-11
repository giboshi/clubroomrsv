#$(".datetimepicker").datetimepicker({
  # 日本語化 
 # locale: 'ja'
  # 年月日を時間を横に並べる
  #sideBySide: true
  # テキストフィールドの表示形式
  #format: 'YYYY/MM/DD HH:mm'
  # カレンダーのヘッダーの表示形式
  #dayViewHeaderFormat: 'YYYY MMMM'
  # 5分ごとに変更できる
  #stepping: 5
#})

#asserts/javascripts/new..js.coffee

#$('.date-picker').datetimepicker(pickTime: false);

#$ ->
#  $(".date-picker").datetimepicker();
  
$ ->
  $(".date-picker").datetimepicker( format : "YYYY/MM/DD" );