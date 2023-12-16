$(document).ready(function() {
	$('#saveJobDetails').submit(function(event) {
		event.preventDefault(); // Prevent the default form submission

		// Your AJAX request logic here
		ajaxPost();
	});

	function ajaxPost() {
		var form = $('#saveJobDetails')[0];
		var data = new FormData(form);

		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/Recruiter/saveJob",
			data: data,
			processData: false,
			contentType: false,
			cache: false,
			success: function(response) {
				if (response != null) {
					$("#postResultDiv").html(
						"<p>" + response.companyName + " in " + response.city +
						" Save Successfully!</p>"
					);
					setTimeout(function() {
						location.reload();
					}, 5);
				}
			},
			error: function(xhr, status, error) {
				console.error("AJAX Error: " + status, error);
				// Handle the error or log it for debugging
			}
		});
	}
});
