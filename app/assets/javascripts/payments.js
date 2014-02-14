$(document).on('ready page:load', function() {
	var $select = $("#selStampQuantity");
	for (i=1;i<=100;i++){
		$select.append($('<option></option>').val(i).html(i))
	}

	$('#btnPurchase').click(function(){
		var token = function(res){
			var $input = $('<input type=hidden name=stripeToken />').val(res.id);
			$('form').append($input).submit();
		};

		var stampQuantity = document.getElementById('selStampQuantity').value;

		StripeCheckout.open({
			key: 'pk_test_yPplECGm2DItWQQERis3ioli', //pk_live_gSnEpGgVrfYi109PlaJQcJTJ
			address: true,
			amount: stampQuantity * 200,
			currency: 'usd',
			name: 'AirPic!',
			description: [stampQuantity, " stamps for $", stampQuantity * 2, "."].join(''),
			panelLabel: 'Checkout',
			token: token
		});

		return false;
	});
});