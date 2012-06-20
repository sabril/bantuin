// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require ckeditor/init
$('a').live('ajax:complete', function(xhr, status) {
  $(".ajaxful-rating-wrapper").replaceWith(status.responseText)
});

$(document).ready(function(){
	var defaultValue = 10000;
	$("#salary").val(defaultValue);
	$("#salary").keyup(function(){
		var currentValue = parseInt($("#salary").val());
		if(currentValue < 10000){
			$('#error_count').text("minimal pembayaran Rp10.000");
			$("#salary").val(10000);
		}
	});
	$("#sal-up").click(function(){
		var currentValue = parseInt($("#salary").val());
		var newValue = currentValue + 1000;
		$("#salary").val(newValue);
	});
	$("#sal-down").click(function(){
		var currentValue = parseInt($("#salary").val());
		var newValue = currentValue - 1000;
		if(newValue < 10000){
			$('#error_count').text("minimal pembayaran Rp10.000");
		}
		else{
			$("#salary").val(newValue);
		}
	});
	$(function() {
		$( "#job_time_start" ).datepicker({ dateFormat: 'yy-mm-dd' });
	});
	
	$( "#candidate_born_date" ).datepicker({ dateFormat: 'yy-mm-dd',  defaultDate: "1985-01-01", changeMonth: true,
  			changeYear: true });
  			
  $('#candidate_full_name').popover({title: "Nama Lengkap", content: "Sesuai dengan yang ada di ijazah."})
	$('#candidate_address').popover({title: "Alamat", content: "Alamat surat harus dijamin sampai. Kalau perlu lengkap dengan RT/RW dan Kode Pos."})
  $('#candidate_born_place').popover({title: "Tempat Lahir", content: "Sesuai dengan yang ada di ijazah/KTP."})
  $('#candidate_born_date').popover({title: "Tanggal Lahir", content: "Sesuai dengan yang ada di ijazah/KTP."})
  $('#candidate_email').popover({title: "Email", content: "Email harus valid."})
  $('#candidate_phone').popover({title: "Telepon/Handphone", content: "yang dapat dihubungi."})
  $('#candidate_from_university').popover({title: "Asal Universitas", content: "Nama Perguruan Tinggi dan Kota."})
  $('#candidate_from_program').popover({title: "Asal Program Studi", content: "Nama Program Studi jangan disingkat."})
  $('#candidate_toefl').popover({title: "TOEFL/EPrT", content: "Tulis Score terakhir, maksimal 2 tahun."})
  $('#candidate_ipk').popover({title: "IPK", content: "Tulis IPK dengan skala 4. Khusus untuk Program Studi Teknik Informatika, IPK harus >= 3.00."})
  $('#candidate_to_program').popover({title: "Program Studi", content: "Pilih Program Studi Tujuan."})
});
