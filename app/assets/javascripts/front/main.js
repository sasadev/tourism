"use strict";

////////////////////////
//// Document Ready ////
////////////////////////
jQuery(document).ready(function () {
    sayit_countdown();
	
    jQuery('.sayit_header_menu .sub-menu').wrap('<div class="sayit_sub_menu_wrapper"></div>');
	
	// Header Menu Hover
	jQuery('header .sayit_menu li').on({
		mouseenter: function (e) {
			e.stopPropagation();

			var menu_item = jQuery(this);

			jQuery(menu_item).find('.sayit_sub_menu_wrapper:first').css('display', 'block');
			setTimeout(function (menu_item) {
				jQuery(menu_item).find('.sayit_sub_menu_wrapper:first').addClass('visible');
			}, 100, menu_item);
		},

		mouseleave: function (e) {
			// e.stopPropagation();

			var menu_item = jQuery(this);

			jQuery(menu_item).find('.sayit_sub_menu_wrapper:first').removeClass('visible');
			setTimeout(function (menu_item) {
				jQuery(menu_item).find('.sayit_sub_menu_wrapper:first').css('display', 'none');
			}, 100, menu_item);
		}
	});

    jQuery(".widget ul li a").hover(
        function (event) {
	        event.preventDefault();
            jQuery(this).parent().addClass('sayit_link_hover');
        }, function (event) {
		    event.preventDefault();
            jQuery(this).parent().removeClass('sayit_link_hover');
        }
    );

	// JS Styles
    var sayit_js_bg_color = jQuery('.sayit_js_bg_color'),
        sayit_js_bg_image = jQuery('.sayit_js_bg_image'),
        sayit_js_color = jQuery('.sayit_js_color'),
        sayit_js_font_size = jQuery('.sayit_js_font_size'),
        sayit_js_height = jQuery('.sayit_js_height');

    if (jQuery(sayit_js_bg_color).length > 0) {
        jQuery(sayit_js_bg_color).each(function () {
            jQuery(this).css('background-color', jQuery(this).attr('data-bgcolor'));
        });
    }

    if (jQuery(sayit_js_bg_image).length > 0) {
        jQuery(sayit_js_bg_image).each(function () {
            jQuery(this).css('background-image', 'url(' + jQuery(this).attr('data-src') + ')');
        });
    }

    if (jQuery(sayit_js_color).length > 0) {
        jQuery(sayit_js_color).each(function () {
            jQuery(this).css('color', jQuery(this).attr('data-color'));
        });
    }

    if (jQuery(sayit_js_font_size).length > 0) {
        jQuery(sayit_js_font_size).each(function(){
	        var font_size = jQuery(this).attr('data-font-size'),
		        line_height = jQuery(this).attr('data-line-height');
	
	        if (typeof line_height !== 'undefined') {
		        jQuery(this).css({'font-size': font_size, 'line-height': line_height});
	        } else {
		        jQuery(this).css({'font-size': font_size, 'line-height': font_size});
	        }
        });
    }

    if (jQuery(sayit_js_height).length > 0) {
        jQuery(sayit_js_height).each(function(){
            var block_height = jQuery(this).attr('data-height');

            jQuery(this).height(block_height);
        });
    }

    if (jQuery('.sayit_testimonials_slider_slick').length > 0) {
        jQuery(".sayit_testimonials_slider_slick").each(function () {
            var sayit_slider_options = jQuery(this).data('slider_options');

            jQuery(this).slick({
                slidesToShow: 1,
                centerMode: true,
                adaptiveHeight: true,
                centerPadding: 0,
                focusOnSelect: true,
                pauseOnHover: sayit_slider_options['pauseOnHover'],
                autoplay: sayit_slider_options['autoplay'],
                autoplaySpeed: sayit_slider_options['autoplaySpeed'],
                speed: sayit_slider_options['speed'],
                arrows: sayit_slider_options['arrows'],
                dots: sayit_slider_options['dots'],
                infinite: sayit_slider_options['infinite']
            });
        });
    }

    // Sharing
    var window_width = jQuery(window).width(),
        window_height = jQuery(window).height(),
        button = jQuery('.sayit_sharing_url_button'),
        input = jQuery('.sayit_sharing_url');
	
    jQuery('.sayit_sharing_button').on('click', function(){
        var window_width = jQuery(window).width(),
            window_height = jQuery(window).height(),
            sayit_sharing_popup = jQuery('.sayit_sharing_popup');
	    
        setTimeout("window_height = jQuery(window).height();", 100);

        sayit_sharing_popup.width(window_width).height(window_height);
        jQuery(sayit_sharing_popup).addClass('active');
    });

    jQuery('.sayit_sharing_popup_close').on('click', function(){
        jQuery('.sayit_sharing_popup').removeClass('active');
    });

    button.on("click", function(event) {
        event.preventDefault();
        input.select();
        document.execCommand("copy");
        jQuery('.sayit_title_default').addClass('inactive');
        setTimeout("jQuery('.sayit_title_default').css('display', 'none')", 300);
        setTimeout("jQuery('.sayit_title_copied').css('display', 'block');", 300);
        setTimeout("jQuery('.sayit_title_copied').addClass('active');", 350);
    });

    // Flickr Photostream Options
    var sayit_flickr_container = jQuery('.sayit_photostream_cont');

    if (jQuery(sayit_flickr_container).is('.sayit_flickr_link_off')) {
        jQuery(sayit_flickr_container).find('a').attr('href', 'javascript:void(0)').addClass('sayit_no_link');
    } else {
        if (jQuery(sayit_flickr_container).is('.sayit_target_blank')) {
            jQuery(sayit_flickr_container).find('a').attr('target', '_blank');
        }
    }

    var isiPad = navigator.userAgent.match(/iPad/i) != null;
    if (isiPad) {
        jQuery('body').addClass('device_ipad');
    }
    
    jQuery('.sayit_curr_calculator').each(function () {
        jQuery(this).find('select').wrap('<div class="sayit_calc_curr_select"></div>');
    });
    
    // Header Search Open
    jQuery('.sayit_header_search_button').on('click', function () {
    	var open_button = jQuery(this),
	        popup_width = jQuery(open_button).parent().parent().width();
	
	    jQuery(open_button).parent().find('.sayit_header_search_popup').width(popup_width);
        jQuery(open_button).parent().find('.sayit_header_search_popup').addClass('active');

        setTimeout(function () {
	        jQuery(open_button).parent().find('.sayit_header_search_popup').toggleClass('visible');
        }, 100, open_button);
    });
	
	// Header Search Close
    jQuery(document).on('click', function (event) {
	    if (jQuery(event.target).closest('.sayit_header_search_container').length) {} else {
	    	var search_cont = jQuery('.sayit_header_search_container');
		
		    search_cont.find('.sayit_header_search_popup').removeClass('visible');
	    	setTimeout(function () {
			    search_cont.find('.sayit_header_search_popup').removeClass('active');
		    }, 300, search_cont);
	    }
    });
	
	// Popup Button
	jQuery('.sayit_popup_button').on('click', function(){
		jQuery(this).parent().find('.sayit_popup_button_popup').addClass('active');
	});
	
	jQuery('.sayit_popup_button_popup_close').on('click', function(){
		jQuery(this).parent().removeClass('active');
	});
	
	// Post Slider Widget
	jQuery('.sayit_post_slider_cont').each(function () {
		var slider_cont = jQuery(this).find('.sayit_post_slider_wrapper'),
			slider_id = jQuery(slider_cont).attr('id'),
			slider_item = jQuery(slider_cont).find('.sayit_post_slider_item'),
			number_of_items = jQuery(slider_item).length,
			current_slide_number,
			slider_autoplay = jQuery(slider_cont).attr('data-autoplay'),
			slider_pause = jQuery(slider_cont).attr('data-pause'),
			slider_speed = jQuery(slider_cont).attr('data-speed'),
			i, temp_arr = [];
		
		if (window_width < 737) {
			for (i=0; i < number_of_items; i++) {
				var slider_inner_height = jQuery('.item_' + (i + 1) + '').find('.sayit_post_meta_cont').height();
				
				temp_arr.push(slider_inner_height);
			}
			
			var max_height = Math.max.apply(null, temp_arr);
			
			slider_cont.height(max_height + 200);
		}
		
		jQuery(slider_item).first().addClass('current_slide');
		setTimeout("jQuery('.sayit_post_slider_wrapper').find('.current_slide').addClass('top_slide')", 1000);
		
		current_slide_number = jQuery(this).find('.current_slide').attr('data-number');
		
		jQuery(this).find('.button_' + current_slide_number + '').first().addClass('current_button');
		
		jQuery(this).find('.sayit_post_slider_nav_button').on('click', function () {
			var next_slide = jQuery(this).attr('data-slide');
			
			sayit_next_post_slide(slider_id, next_slide);
		});
		
		jQuery(this).find('.sayit_inner_post_slide_button').on('click', function (event) {
			var next_post_number = jQuery(this).attr('data-number');
			
			if (next_post_number === '0') {
				var next_slide = '.item_' + number_of_items + '';
				
				sayit_next_post_slide(slider_id, next_slide);
			} else if (next_post_number > number_of_items) {
				next_slide = '.item_1';
				
				sayit_next_post_slide(slider_id, next_slide);
			} else {
				next_slide = jQuery(this).attr('data-slide');
				
				sayit_next_post_slide(slider_id, next_slide);
			}
		});
		
		if (slider_autoplay === 'on') {
			var intervalID;
			
			intervalID = setInterval(sayit_post_slider_autoplay, slider_speed, slider_id, number_of_items);
			
			if (slider_pause === 'yes') {
				jQuery('#' + slider_id + '').on({
					mouseenter: function () {
						clearInterval(intervalID);
					},
					
					mouseleave: function () {
						intervalID = setInterval(sayit_post_slider_autoplay, slider_speed, slider_id, number_of_items);
					}
				});
			}
		}
		
		function sayit_post_slider_autoplay(slider_id, number_of_items) {
			var current_slide_number = parseInt(jQuery('#' + slider_id +'').find('.current_slide').attr('data-number'), 10),
				next_slide_number,
				next_slide;
			
			if (current_slide_number === number_of_items) {
				next_slide = '.item_1';
				
				sayit_next_post_slide(slider_id, next_slide);
			} else {
				next_slide_number = current_slide_number + 1;
				next_slide = '.item_' + next_slide_number + '';
				
				sayit_next_post_slide(slider_id, next_slide);
			}
		}
		
		function sayit_next_post_slide(slider_id, next_slide) {
			var current_slider = jQuery('#' + slider_id +'');
			
			jQuery(current_slider).find('.current_slide').removeClass('current_slide');
			jQuery(current_slider).find('.current_button').removeClass('current_button');
			jQuery(current_slider).find(next_slide).addClass('current_slide');
			setTimeout(function () {
				jQuery(current_slider).find('.top_slide').removeClass('top_slide');
				jQuery(current_slider).find('.current_slide').addClass('top_slide');
			}, 500);
			
			current_slide_number = jQuery(current_slider).find('.current_slide').attr('data-number');
			
			jQuery(current_slider).find('.button_' + current_slide_number + '').first().addClass('current_button');
		}
	});
	
	// Info Box Widget
	if (jQuery('.sayit_info_box_item.view_type_2').length) {
		jQuery('.sayit_info_box_item.view_type_2').each(function () {
			var description_height = jQuery(this).find('.sayit_info_box_description').height();
			
			if (description_height !== null) {
				jQuery(this).find('.sayit_inbo_box_content').css('bottom', -description_height + 'px');
			} else {
				jQuery(this).find('.sayit_inbo_box_content').css('bottom', '0');
			}
		});
	}
	
	if (window_width < 600) {
		jQuery('#wpadminbar').css('position', 'fixed');
	}
	
	// Grid Blog Listing
	jQuery('.sayit_blog_grid_page').each(function () {
		var items_set = [
			{post_link: 'post_audio.html', img_url: 'img/clipart/places/germany/germany-10.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Etiam Dapibus Euismod', post_excerpt: 'Proin posuere tincidunt diam vitae feugiat. Sed tincidunt, metus ut facilisis accumsan, ipsum lorem venenatis nunc, sagittis malesuada...'},
			{post_link: 'post_quote.html', img_url: 'img/clipart/places/germany/germany-11.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Vivamus Tempor Interdum', post_excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget sodales enim, et viverra est. Aenean ac enim nulla. Nunc auctor...'},
			{post_link: 'post_link.html', img_url: 'img/clipart/places/germany/germany-12.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Mollis Elit Pulvinar Cursus', post_excerpt: 'Integer sollicitudin facilisis neque et convallis. Phasellus eu porttitor ante, sed fringilla libero. Sed tincidunt est massa, porta...'},
			{post_link: 'post_standard.html', img_url: 'img/clipart/places/germany/germany-13.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Viverra Pharetra Justo', post_excerpt: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque efficitur lectus vitae iaculis tempor...'},
			{post_link: 'post_image.html', img_url: 'img/clipart/places/germany/germany-14.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Nulla Mattis Lacinia Libero', post_excerpt: 'Aliquam malesuada lacinia ullamcorper. Suspendisse eget metus lorem. Aliquam sit amet pulvinar libero, et ultrices lectus. Fusce a...'},
			{post_link: 'post_video.html', img_url: 'img/clipart/places/germany/germany-15.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'In Porta Tempor Lectus', post_excerpt: 'Proin posuere tincidunt diam vitae feugiat. Sed tincidunt, metus ut facilisis accumsan, ipsum lorem venenatis nunc, sagittis malesuada...'},
			{post_link: 'post_audio.html', img_url: 'img/clipart/places/germany/germany-16.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Nunc Dictum Commodo', post_excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget sodales enim, et viverra est. Aenean ac enim nulla. Nunc auctor...'},
			{post_link: 'post_quote.html', img_url: 'img/clipart/places/germany/germany-17.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Mauris Bibendum', post_excerpt: 'Integer sollicitudin facilisis neque et convallis. Phasellus eu porttitor ante, sed fringilla libero. Sed tincidunt est massa, porta...'},
			{post_link: 'post_link.html', img_url: 'img/clipart/places/germany/germany-18.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Nulla Vitae Sem Libero', post_excerpt: 'Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque efficitur lectus vitae iaculis tempor...'},
			{post_link: 'post_standard.html', img_url: 'img/clipart/places/germany/germany-19.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Consectetur Adipiscing', post_excerpt: 'Aliquam malesuada lacinia ullamcorper. Suspendisse eget metus lorem. Aliquam sit amet pulvinar libero, et ultrices lectus. Fusce a...'},
			{post_link: 'post_image.html', img_url: 'img/clipart/places/germany/germany-20.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Donec Ut Justo Sem', post_excerpt: 'Proin posuere tincidunt diam vitae feugiat. Sed tincidunt, metus ut facilisis accumsan, ipsum lorem venenatis nunc, sagittis malesuada...'},
			{post_link: 'post_video.html', img_url: 'img/clipart/places/germany/germany-21.jpg', post_category: 'Germany', post_date: 'July 10, 2018', post_title: 'Quisque Porttitor Tincid', post_excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget sodales enim, et viverra est. Aenean ac enim nulla. Nunc auctor...'}
		];
		
		jQuery('#list').blog_listing_addon({
			load_count: 3,
			items: items_set
		});
	});
	
	// Masonry Blog Listing
	jQuery('.sayit_blog_masonry_page').each(function () {
		var items_set = [
			{post_link: 'post_quote.html', img_url: 'img/clipart/places/uk/uk-11.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Tellus Orci Rhoncus Massa', post_excerpt: 'Nunc mattis tellus sit amet tincidunt elementum. Sed cursus, ligula in scelerisque facilisis, metus mauris placerat dolor, nec fermentum...'},
			{post_link: 'post_link.html', img_url: 'img/clipart/places/uk/uk-12.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Class Aptent Taciti Sociosqu', post_excerpt: 'Sed at magna eget orci ultricies blandit nec vitae diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per...'},
			{post_link: 'post_standard.html', img_url: 'img/clipart/places/uk/uk-13.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Pellentesque Iin Dolor', post_excerpt: 'Pellentesque eu nulla est. Duis leo urna, facilisis nec libero vitae, viverra interdum purus. Phasellus ac mollis risus. Mauris felis...'},
			{post_link: 'post_image.html', img_url: 'img/clipart/places/uk/uk-14.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Tortor Auctor Dapibus', post_excerpt: 'Nullam vel mi sagittis dolor vulputate viverra id suscipit tortor. Etiam eleifend cursus metus non sagittis. Vivamus pretium...'},
			{post_link: 'post_video.html', img_url: 'img/clipart/places/uk/uk-15.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Maecenas Libero Tortor', post_excerpt: 'Aenean vel sollicitudin orci. Vivamus a dignissim dui, id hendrerit ex. Maecenas porta libero eget tellus euismod, ut posuere ligula...'},
			{post_link: 'post_audio.html', img_url: 'img/clipart/places/uk/uk-16.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Tempus Consequat Elit', post_excerpt: 'Nunc mattis tellus sit amet tincidunt elementum. Sed cursus, ligula in scelerisque facilisis, metus mauris placerat dolor, nec fermentum...'},
			{post_link: 'post_quote.html', img_url: 'img/clipart/places/uk/uk-17.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Curabitur Imperdiet Dolor', post_excerpt: 'Sed at magna eget orci ultricies blandit nec vitae diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per...'},
			{post_link: 'post_link.html', img_url: 'img/clipart/places/uk/uk-18.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Vestibulum Rhoncus Dictum', post_excerpt: 'Pellentesque eu nulla est. Duis leo urna, facilisis nec libero vitae, viverra interdum purus. Phasellus ac mollis risus. Mauris felis...'},
			{post_link: 'post_standard.html', img_url: 'img/clipart/places/uk/uk-19.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Lobortis Neque Euismod', post_excerpt: 'Nullam vel mi sagittis dolor vulputate viverra id suscipit tortor. Etiam eleifend cursus metus non sagittis. Vivamus pretium...'},
			{post_link: 'post_image.html', img_url: 'img/clipart/places/uk/uk-20.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Donec Interdum Orci', post_excerpt: 'Aenean vel sollicitudin orci. Vivamus a dignissim dui, id hendrerit ex. Maecenas porta libero eget tellus euismod, ut posuere ligula...'},
			{post_link: 'post_video.html', img_url: 'img/clipart/places/uk/uk-21.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Pellentesque Efficitur Urna', post_excerpt: 'Nunc mattis tellus sit amet tincidunt elementum. Sed cursus, ligula in scelerisque facilisis, metus mauris placerat dolor, nec fermentum...'},
			{post_link: 'post_audio.html', img_url: 'img/clipart/places/uk/uk-22.jpg', post_category: 'United Kingdom', post_date: 'July 11, 2018', post_title: 'Sapien Eu Pharetra', post_excerpt: 'Cras non accumsan nulla. Duis nec bibendum sem. Aenean dictum tincidunt quam, non hendrerit ligula imperdiet at. Duis dolor diam,...'}
		];
		
		jQuery('#list').masonry_listing_addon({
			load_count: 3,
			items: items_set
		});
	});
	
	// Masonry Blog Listing Type 2
	jQuery('.sayit_blog_masonry_2_page').each(function () {
		var items_set = [];
		
		if (jQuery(this).is('.sayit_place_farnce_page')) {
			items_set = [
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/france/france-11.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Pharetra Sed Ipsum', post_comments: '5'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/france/france-12.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Lovely Dinner', post_comments: '7'},
				{post_link: 'post_standard.html', img_url: 'img/clipart/places/france/france-13.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Amet Venenatis Nibh', post_comments: '2'},
				{post_link: 'post_image.html', img_url: 'img/clipart/places/france/france-14.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Dapibus Nunc Justo', post_comments: '6'},
				{post_link: 'post_video.html', img_url: 'img/clipart/places/france/france-15.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'About Public Transport', post_comments: '2'},
				{post_link: 'post_audio.html', img_url: 'img/clipart/places/france/france-16.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Donec Sagittis', post_comments: '8'},
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/france/france-17.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Euismod Vestibulum', post_comments: '3'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/france/france-18.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Vestibulum Quis Nunc', post_comments: '0'},
				{post_link: 'post_standard.html', img_url: 'img/clipart/places/france/france-19.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Quisque Sodales Lacus', post_comments: '12'},
				{post_link: 'post_image.html', img_url: 'img/clipart/places/france/france-20.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Morbi Non Auctor', post_comments: '4'},
				{post_link: 'post_video.html', img_url: 'img/clipart/places/france/france-21.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Interdum Lacus Nec', post_comments: '8'},
				{post_link: 'post_audio.html', img_url: 'img/clipart/places/france/france-22.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Dapibus Suscipit', post_comments: '2'},
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/france/france-23.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Bibendum Sollicitudin', post_comments: '1'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/france/france-24.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Consectetur Posuere', post_comments: '2'},
				{post_link: 'post_standard.html', img_url: 'img/clipart/places/france/france-25.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Mauris Libero Mauris', post_comments: '15'},
				{post_link: 'post_image.html', img_url: 'img/clipart/places/france/france-26.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Quisque Porttitor', post_comments: '5'},
				{post_link: 'post_video.html', img_url: 'img/clipart/places/france/france-27.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Nam Dapibus Suscipit', post_comments: '1'},
				{post_link: 'post_audio.html', img_url: 'img/clipart/places/france/france-28.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Nullam Tincidunt Nisi', post_comments: '7'},
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/france/france-29.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Lorem Ipsum Dolor', post_comments: '0'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/france/france-30.jpg', post_category: 'France', post_date: 'July 17, 2018', post_title: 'Donec Dignissim', post_comments: '9'}
			];
			
			jQuery('#list').masonry_2_listing_addon({
				load_count: 6,
				items: items_set
			});
		}
		
		if (jQuery(this).is('.sayit_place_turkey_page')) {
			items_set = [
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/turkey/turkey-11.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Congue Elementum Quis', post_comments: '5'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/turkey/turkey-12.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Sed Sit Amet Massa Eget', post_comments: '7'},
				{post_link: 'post_standard.html', img_url: 'img/clipart/places/turkey/turkey-13.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Pretium Dui Diam Vitae Urna', post_comments: '2'},
				{post_link: 'post_image.html', img_url: 'img/clipart/places/turkey/turkey-14.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Maximus Magna Sit Amet', post_comments: '6'},
				{post_link: 'post_video.html', img_url: 'img/clipart/places/turkey/turkey-15.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Massa Vitae Lobortis', post_comments: '2'},
				{post_link: 'post_audio.html', img_url: 'img/clipart/places/turkey/turkey-16.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Fermentum Tempus Nulla Lobortis', post_comments: '8'},
				{post_link: 'post_quote.html', img_url: 'img/clipart/places/turkey/turkey-17.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Nam Lobortis Quam At', post_comments: '3'},
				{post_link: 'post_link.html', img_url: 'img/clipart/places/turkey/turkey-18.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Aenean a Faucibus Nibh', post_comments: '0'},
				{post_link: 'post_standard.html', img_url: 'img/clipart/places/turkey/turkey-19.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Vestibulum Lorem Nisi', post_comments: '12'},
				{post_link: 'post_image.html', img_url: 'img/clipart/places/turkey/turkey-20.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Elementum Quam Porta', post_comments: '4'},
				{post_link: 'post_video.html', img_url: 'img/clipart/places/turkey/turkey-21.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Condimentum Porta', post_comments: '8'},
				{post_link: 'post_audio.html', img_url: 'img/clipart/places/turkey/turkey-22.jpg', post_category: 'Turkey', post_date: 'July 11, 2018', post_title: 'Mauris Egestas Metus', post_comments: '2'}
			];
			
			jQuery('#list').masonry_2_listing_addon({
				load_count: 3,
				items: items_set
			});
		}
	});
	
	jQuery('.sayit_blog_packery_page').each(function () {
		var items_set = [
			{item_number: '1', post_link: 'post_video.html', img_url: 'img/clipart/places/usa/usa-9.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Commodo Rutrum', post_excerpt: 'Sed fermentum erat tellus, in aliquam ipsum bibendum et. Duis pulvinar consectetur eros non tincidunt. Nunc malesuada sem nec erat tincidunt consequat. Suspendisse potenti. Fusce in nisi feugiat, lobortis velit vitae, pretium...', post_comments: '7'},
			{item_number: '2', post_link: 'post_audio.html', img_url: 'img/clipart/places/usa/usa-10.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Suspendisse Potenti', post_excerpt: 'Duis eget libero sit amet erat faucibus facilisis ut ut elit. Nulla facilisi. Etiam tincidunt enim lacus, vel vulputate ex pretium congue. Vivamus in velit eget erat molestie dapibus. Morbi a rutrum justo. Praesent venenatis...', post_comments: '8'},
			{item_number: '3', post_link: 'post_link.html', img_url: 'img/clipart/places/usa/usa-11.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Aliquam Elementum', post_excerpt: 'Proin gravida tellus et urna consequat, eget suscipit sem interdum. Proin in lorem vel elit...', post_comments: '1'},
			{item_number: '4', post_link: 'post_standard.html', img_url: 'img/clipart/places/usa/usa-12.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Congue Posuere Libero', post_excerpt: 'Morbi placerat orci non sollicitudin dapibus. Pellentesque habitant morbi tristique senectus et...', post_comments: '4'},
			{item_number: '5', post_link: 'post_image.html', img_url: 'img/clipart/places/usa/usa-13.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Etiam Eget Arcu', post_excerpt: 'Sed bibendum sed quam vel blandit. Nam imperdiet luctus sapien id eleifend. Nunc eu nisl vitae ligula sollicitudin accumsan. Fusce non tortor eu nisl gravida aliquet. Duis fringilla tempor auctor. Ut sagittis justo non...', post_comments: '11'},
			{item_number: '6', post_link: 'post_video.html', img_url: 'img/clipart/places/usa/usa-14.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Aenean Vulputate', post_excerpt: 'Sed fermentum erat tellus, in aliquam ipsum bibendum et. Duis pulvinar consectetur eros non tincidunt. Nunc malesuada sem nec erat tincidunt consequat. Suspendisse potenti. Fusce in nisi feugiat, lobortis velit vitae, pretium...', post_comments: '9'},
			{item_number: '7', post_link: 'post_audio.html', img_url: 'img/clipart/places/usa/usa-15.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Cras Tristique Nisi', post_excerpt: 'Duis eget libero sit amet erat faucibus facilisis ut ut elit. Nulla facilisi. Etiam tincidunt...', post_comments: '3'},
			{item_number: '8', post_link: 'post_link.html', img_url: 'img/clipart/places/usa/usa-16.jpg', post_category: 'USA', post_date: 'July 11, 2018', post_title: 'Proin Gravida Tellus', post_excerpt: 'Proin gravida tellus et urna consequat, eget suscipit sem interdum. Proin in lorem vel elit...', post_comments: '5'}
		];
		
		jQuery('#list').packery_listing_addon({
			load_count: 4,
			items: items_set
		});
	});
});

/////////////////////
//// Window Load ////
/////////////////////
jQuery(window).on('load', function () {
	var sayit_window = jQuery(window),
		window_width = jQuery(window).width(),
		window_height = jQuery(window).height(),
		header_height = jQuery('header').height(),
		adminbar = jQuery('#wpadminbar').height();
	
	jQuery('body').css('opacity', '1');
	setTimeout("", 100);
	
	// Isotope Activation
	if (jQuery('div').is('.sayit_isotope_trigger')) {
		jQuery('.sayit_isotope_trigger').isotope();
	}
	
	// Back To Top
	if (jQuery('html').is('.sayit_page_mode_standard')) {
		
		jQuery('.sayit_back_to_top').attr('data-bottom', parseInt(jQuery('.sayit_back_to_top').css('bottom'), 10));
		
		if (sayit_window.scrollTop() > sayit_window.height()) {
			jQuery('.sayit_back_to_top').addClass('sayit_show_me');
		} else {
			jQuery('.sayit_back_to_top').removeClass('sayit_show_me');
			if (jQuery('.sayit_footer').length > 0) {
				var footer_offset = jQuery('.sayit_footer').offset().top,
					check_footer_state = sayit_window.scrollTop() + sayit_window.height(),
					sayit_footer_showed = 'no',
					sayit_b2t_fixer = 0;
				
				if ( check_footer_state >= footer_offset) {
					sayit_b2t_fixer = check_footer_state - footer_offset;
					sayit_footer_showed = 'yes';
				} else {
					sayit_footer_showed = 'no';
					sayit_b2t_fixer = 0;
				}
				jQuery('.sayit_back_to_top').css('bottom', parseInt(jQuery('.sayit_back_to_top').attr('data-bottom'), 10) + sayit_b2t_fixer + 'px');
			}
		}
		
		sayit_window.on('scroll', function(){
			if (sayit_window.scrollTop() > sayit_window.height()) {
				jQuery('.sayit_back_to_top').addClass('sayit_show_me');
			} else {
				jQuery('.sayit_back_to_top').removeClass('sayit_show_me');
			}
			
			if (jQuery('.sayit_footer').length > 0) {
				var footer_offset = jQuery('.sayit_footer').offset().top,
					check_footer_state = sayit_window.scrollTop() + sayit_window.height(),
					sayit_footer_showed = 'no',
					sayit_b2t_fixer = 0;
				
				if ( check_footer_state >= footer_offset) {
					sayit_b2t_fixer = check_footer_state - footer_offset;
					sayit_footer_showed = 'yes';
				} else {
					sayit_footer_showed = 'no';
					sayit_b2t_fixer = 0;
				}
				jQuery('.sayit_back_to_top').css('bottom', parseInt(jQuery('.sayit_back_to_top').attr('data-bottom'), 10) + sayit_b2t_fixer + 'px');
			}
		});
	}
	
	jQuery('.sayit_back_to_top').on('click', function(){
		jQuery('html, body').stop().animate({scrollTop: 0}, 400, function(){
			jQuery('.sayit_back_to_top').removeClass('sayit_show_me');
		});
	});
	
	// Main Menu Marker
	if (jQuery('ul').is('.sayit_header_menu')) {
		jQuery('.sayit_header_menu').each(function(){
			sayit_main_menu_marker_load(jQuery(this));
		});
	}
	
	// Fullscreen Page Mode
	if (jQuery('.sayit_page_mode_fullscreen').length) {
		jQuery('.sayit_page_mode_fullscreen header').css('top', adminbar);
	}
	sayit_fullscreen_page_mode();
	
	
	if (window_width < 737) {
		jQuery('.sayit_fullscreen_mode_page .sayit_image_cont').height(window_height + 200);
	}
	
	// Sticky Menu
	if (window_width < 1200) {
		jQuery('html').removeClass('sayit_sticky_menu_on');
	}
	
	if (jQuery('html').is('.sayit_sticky_menu_on')) {
		var header = jQuery('header'),
			header_height = jQuery(header).height(),
			empty_item = jQuery('.sayit_empty_item'),
			temp_scroll_top,
			current_scroll_top = 0;
		
		jQuery(window).on('scroll', function(){
			current_scroll_top = jQuery(window).scrollTop();
			
			if (temp_scroll_top < current_scroll_top) {
				if (jQuery(window).scrollTop() > (header_height + 50)) {
					jQuery(header).addClass('sayit_ready')/*.addClass('sayit_narrow_menu')*/;
					jQuery(empty_item).height(header_height);
					
					if (jQuery('html').is('.sayit_transparent_header')){
						jQuery(empty_item).height(0);
					} else if (jQuery('html').is('.sayit_fimage_position_over')) {
						jQuery(empty_item).height(0);
					} else {
						jQuery(empty_item).height(header_height);
					}
					
					setTimeout("jQuery('header').removeClass('sayit_ready').addClass('sayit_sticky_menu')", 100);
				}
			} else if (temp_scroll_top > current_scroll_top) {
				if (jQuery(window).scrollTop() === 0) {
					jQuery(header).removeClass('sayit_sticky_menu');
					jQuery(empty_item).height(0);
				}
			}
			
			temp_scroll_top = current_scroll_top;
		});
	}
	
	if (jQuery('.sayit_ajax_query_posts').length > 0) {
		jQuery('.sayit_ajax_query_posts').each(function () {
			sayit_ajax_query_posts(jQuery(this), true);
		});
		
		jQuery(document).on('click', '.sayit_ajax_query_posts', function () {
			sayit_ajax_query_posts(jQuery(this), false);
		});
	}
	
	// OWL Carousel Initialize
	if (jQuery('.sayit_owlCarousel').length) {
		jQuery('.sayit_owlCarousel').on('initialized.owl.carousel', function(e) {
			jQuery('.sayit_owlCarousel').css('opacity', '1');
		});
		jQuery('.sayit_owlCarousel').owlCarousel(
			{
				items:1,
				lazyLoad:true,
				loop:true,
				dots:false,
				nav:true,
				navText:["", ""],
				autoplay:true,
				autoplayTimeout:5000,
				autoplayHoverPause:true,
				autoHeight:true
			}
		);
	}
	
	// Coming Soon Page
	sayit_coming_soon_template();
	
	// Post Format Video Output
	if (jQuery('.sayit_pf_video').length) {
		jQuery('.sayit_pf_video').each(function () {
			var video_cont_width = jQuery(this).find('.sayit_pf_video_cont').width(),
				video_width = jQuery(this).find('.sayit_pf_video_cont > iframe').attr('width'),
				video_height = jQuery(this).find('.sayit_pf_video_cont > iframe').attr('height'),
				ratio = video_width / video_height;
			
			jQuery(this).find('.sayit_pf_video_cont').height(video_cont_width / ratio);
		});
	}
	
	// Additional Sidebar Open
	jQuery('.sayit_additional_sidebar_trigger').on('click', function () {
		jQuery(this).addClass('active');
		jQuery('.sayit_additional_sidebar_cont').addClass('active');
		jQuery('.sayit_additional_overlay').css('display', 'block');
		
		setTimeout(function () {
			jQuery('.sayit_additional_sidebar_cont').addClass('open_panel');
			jQuery('.sayit_additional_overlay').addClass('visible');
		}, 200);
	});
	
	// Additional Sidebar Close
	jQuery('.sayit_additional_sidebar_close_button').on('click', function () {
		jQuery('.sayit_additional_sidebar_trigger').removeClass('active');
		jQuery('.open_panel').removeClass('active');
		jQuery('.sayit_additional_overlay').removeClass('visible');
		
		setTimeout(function () {
			jQuery('.open_panel').removeClass('open_panel');
			jQuery('.sayit_additional_overlay').css('display', 'none');
		}, 200);
	});
	
	jQuery(document).on('click', function (event) {
		if (jQuery('.open_panel').length) {
			if (jQuery(event.target).closest('.open_panel').length) {} else {
				var sidebar_cont = jQuery('.open_panel');
				
				jQuery('.sayit_additional_sidebar_trigger').removeClass('active');
				sidebar_cont.removeClass('active');
				jQuery('.sayit_additional_overlay').removeClass('visible');
				
				setTimeout(function () {
					sidebar_cont.removeClass('open_panel');
					jQuery('.sayit_additional_overlay').css('display', 'none');
				}, 200);
			}
		}
	});
	
	sayit_person_overlays();
	
	// Blog List Modern
	if (window_width < 769) {
		if (jQuery('.sayit_modern_blog_listing_cont').length) {
			jQuery('.sayit_modern_blog_listing_cont').find('.sayit_blog_item').each(function () {
				var row_height = jQuery(this).find('.row').height();
				
				jQuery(this).find('.row').height(row_height);
			});
		}
	}
	
	sayit_post_slider_height();
	setTimeout(sayit_post_slider_height, 100);
	sayit_fullwidth_block();
	sayit_masonry_2_overlays();
	sayit_packery_overlays();
});

///////////////////////
//// Window Resize ////
///////////////////////
jQuery(window).on('resize', function () {
	var window_width = jQuery(window).width(),
		window_height = jQuery(window).height(),
		header_height = jQuery('header').height(),
		adminbar = jQuery('#wpadminbar').height();
	
	// Fullscreen Mode Page
	sayit_fullscreen_page_mode();
	
	if (window_width < 600) {
		jQuery('#wpadminbar').css('position', 'fixed');
	}
	
	// Blog List Modern
	if (window_width < 769) {
		if (jQuery('.sayit_modern_blog_listing_cont').length) {
			jQuery('.sayit_modern_blog_listing_cont').find('.sayit_blog_item').each(function () {
				jQuery(this).find('.row').css('height', 'auto');
				
				var row_height = jQuery(this).height();
				
				jQuery(this).find('.row').height(row_height);
			});
		}
	} else {
		jQuery(this).find('.row').css('height', 'auto');
	}
	
	jQuery('.sayit_sharing_popup').width(window_width).height(window_height);
	
	if (window_width > 737) {
		jQuery('.sayit_menu_mobile').css('display', 'none');
		jQuery('.sayit_menu_mobile_trigger').removeClass('active');
	}
	
	// Coming Soon Page
	sayit_coming_soon_template();
	
	sayit_post_slider_height();
	setTimeout(sayit_post_slider_height, 100);
	
	sayit_fullwidth_block();
	
	// Post Format Video Output
	if (jQuery('.sayit_pf_video').length) {
		jQuery('.sayit_pf_video').each(function () {
			var video_cont_width = jQuery(this).find('.sayit_pf_video_cont').width(),
				video_width = jQuery(this).find('.sayit_pf_video_cont > iframe').attr('width'),
				video_height = jQuery(this).find('.sayit_pf_video_cont > iframe').attr('height'),
				ratio = video_width / video_height;
			
			jQuery(this).find('.sayit_pf_video_cont').height(video_cont_width / ratio);
		});
	}
});

function sayit_fullwidth_block() {
	if (jQuery('div').is('.sayit_fullwidth_block')) {
		jQuery('.sayit_fullwidth_block').each(function () {
			var window_width = jQuery(window).width(),
				content_width = jQuery(this).parent().width(),
				margin = (window_width - content_width) / 2;
			
			jQuery(this).width(window_width).css('margin-left', -margin);
		});
	}
}

function sayit_post_slider_height() {
	jQuery('.sayit_post_slider_cont').each(function () {
		var window_width = jQuery(window).width(),
			slider_cont = jQuery(this).find('.sayit_post_slider_wrapper'),
			slider_item = jQuery(slider_cont).find('.sayit_post_slider_item'),
			number_of_items = jQuery(slider_item).length,
			default_height = jQuery(slider_cont).attr('data-default-height'),
			i, temp_arr = [];
		
		if (window_width < 737) {
			for (i=0; i < number_of_items; i++) {
				var slider_inner_height = jQuery('.item_' + (i + 1) + '').find('.sayit_post_meta_cont').height();
				
				temp_arr.push(slider_inner_height);
			}
			
			var max_height = Math.max.apply(null, temp_arr);
			
			slider_cont.height(max_height + 200);
		} else {
			slider_cont.height(default_height);
		}
	});
}

// Coming Soon Template
function sayit_coming_soon_template() {
	var body = jQuery('body');
	
	if (jQuery(body).is('.page-template-page-coming-soon')) {
		var window_height = jQuery(window).height(),
			cs_header = jQuery('header'),
			cs_footer = jQuery('footer'),
			cs_content = jQuery('.sayit_coming_soon_content'),
			header_height = jQuery(cs_header).height(),
			cs_content_height = jQuery(cs_content).height(),
			white_space = window_height - header_height - cs_content_height;
		
		if (white_space > 0) {
			body.height(window_height);
			jQuery(cs_footer).css({'position': 'absolute', 'bottom': '0'});
			jQuery(cs_content).css({'padding-top': (white_space / 2), 'padding-bottom': (white_space / 2)});
		}
	}
}

jQuery('a[href="#"]').on('click', function(event){
    event.preventDefault();
});

jQuery('.sayit_menu_mobile_trigger').on('click', function(){
    jQuery(this).toggleClass('active');
    jQuery('.sayit_menu_mobile').slideToggle(300);
});

function sayit_masonry_2_overlays() {
	if (jQuery('.sayit_blog_type_masonry_2').length) {
		jQuery('.sayit_blog_type_masonry_2 .sayit_blog_item').each(function () {
			var top_overlay_height = jQuery(this).find('.sayit_top_cont').height(),
				bottom_overlay_height = jQuery(this).find('.sayit_bottom_cont').height();

			jQuery(this).find('.sayit_top_overlay').height(top_overlay_height + 60);
			jQuery(this).find('.sayit_bottom_overlay').height(bottom_overlay_height + 60);
		});
	}
}

function sayit_packery_overlays() {
	if (jQuery('.sayit_packery_blog_listing_cont').length) {
		jQuery('.sayit_packery_blog_listing_cont .sayit_blog_item').each(function () {
			var bottom_overlay_height = jQuery(this).find('.sayit_post_content_cont').height();
			
			jQuery(this).find('.sayit_bottom_overlay').height(bottom_overlay_height + 160);
		});
	}
}

function sayit_person_overlays() {
	if (jQuery('.sayit_person_widget').length) {
		jQuery('.sayit_person_item').each(function () {
			var content_overlay_height = jQuery(this).find('.sayit_person_info').height();
			
			jQuery(this).find('.sayit_bottom_overlay').height(content_overlay_height + 100);
		});
	}
}

function sayit_fullscreen_page_mode() {
    var window_width = jQuery(window).width(),
        window_height = jQuery(window).height(),
        admin_panel = jQuery('#wpadminbar').height(),
        header_height = jQuery('header').height(),
        visible_content_height = window_height - admin_panel/* + header_height*/,
        fullscreen_content = jQuery('.sayit_fullscreen_mode_page .sayit_content_wrapper'),
        fullscreen_content_height = jQuery(fullscreen_content).height(),
        white_space = window_height - admin_panel/* - header_height*/ - fullscreen_content_height;
        
    if (window_width > 737) {
        jQuery('.sayit_fullscreen_mode_page').height(visible_content_height);
    }


    if (fullscreen_content_height < visible_content_height) {
        jQuery('.sayit_fullscreen_mode_page .sayit_content_cont').css({'padding-top': ((white_space + header_height) / 2), 'padding-bottom': (white_space / 2)});
    } else {
        jQuery('.sayit_fullscreen_mode_page .sayit_content_cont').css({'padding-top': (header_height + 40), 'padding-bottom': '40px'});
    }
}

function sayit_countdown() {
    jQuery('.sayit_countdown').each(function(){
        var pm_year = jQuery(this).attr('data-year'),
            pm_month = jQuery(this).attr('data-month'),
            pm_day = jQuery(this).attr('data-day'),
            austDay = new Date(pm_year, pm_month - 1, pm_day);

        jQuery(this).countdown({
            until: austDay,
            padZeroes: true
        });
    });
}

function sayit_main_menu_marker_load(sayit_menu_cont_this) {
	var sayit_menu_item = jQuery('ul.sayit_header_menu > li'),
		sayit_current_item = jQuery('ul.sayit_header_menu > .current-menu-item'),
		sayit_current_ancestor = jQuery('ul.sayit_header_menu > .current-menu-ancestor'),
		sayit_scroll_current = jQuery('ul.sayit_header_menu > .active');
	
	if (sayit_menu_item.is('.active')) {
		var sayit_active_item = sayit_scroll_current;
	} else {
		if (sayit_menu_item.is('.current-menu-item')) {
			sayit_active_item = sayit_current_item;
		} else if (sayit_menu_item.is('.current-menu-ancestor')) {
			sayit_active_item = sayit_current_ancestor;
		} else {
			sayit_active_item = sayit_menu_item.first();
		}
	}
	
	jQuery(sayit_menu_cont_this).append('<li class="sayit_menu_marker"></li>');
	
	var sayit_menu_marker = jQuery('.sayit_menu_marker'),
		sayit_left_items = sayit_active_item.prevAll(),
		sayit_width_left_items = 0,
		sayit_left_items_count = sayit_left_items.length;
	
	sayit_left_items.each(function(){
		sayit_width_left_items = sayit_width_left_items + jQuery(this).width();
	});
	
	sayit_menu_marker.width(sayit_active_item.width()).css('left', (sayit_width_left_items + (sayit_left_items_count * 28)));
}

function sayit_main_menu_marker_move_on_hover(sayit_menu_item_this) {
	var sayit_menu_marker = jQuery('.sayit_menu_marker'),
		sayit_left_items = jQuery(sayit_menu_item_this).prevAll(),
		sayit_width_left_items = 0,
		sayit_left_items_count = sayit_left_items.length;
	
	sayit_left_items.each(function(){
		sayit_width_left_items = sayit_width_left_items + jQuery(this).width();
	});
	
	sayit_menu_marker.width(jQuery(sayit_menu_item_this).width()).css('left', (sayit_width_left_items + (sayit_left_items_count * 28)));
}

function sayit_main_menu_marker_back() {
	var sayit_menu_item = jQuery('ul.sayit_header_menu > li'),
		sayit_current_item = jQuery('ul.sayit_header_menu > .current-menu-item'),
		sayit_current_ancestor = jQuery('ul.sayit_header_menu > .current-menu-ancestor'),
		sayit_scroll_current = jQuery('ul.sayit_header_menu > .active');
	
	if (sayit_menu_item.is('.active')) {
		var sayit_active_item = sayit_scroll_current;
	} else {
		if (sayit_menu_item.is('.current-menu-item')) {
			sayit_active_item = sayit_current_item;
		} else if (sayit_menu_item.is('.current-menu-ancestor')) {
			sayit_active_item = sayit_current_ancestor;
		} else {
			sayit_active_item = sayit_menu_item.first();
		}
	}
	
	var sayit_menu_marker = jQuery('.sayit_menu_marker'),
		sayit_left_items = sayit_active_item.prevAll(),
		sayit_width_left_items = 0,
		sayit_left_items_count = sayit_left_items.length;
	
	sayit_left_items.each(function(){
		sayit_width_left_items = sayit_width_left_items + jQuery(this).width();
	});
	
	sayit_menu_marker.width(sayit_active_item.width()).css('left', (sayit_width_left_items + (sayit_left_items_count * 28)));
}

jQuery('.sayit_header_menu > .menu-item').on({
	mouseenter: function() {
		sayit_main_menu_marker_move_on_hover(this)
	},
	mouseleave: function() {
		sayit_main_menu_marker_back();
	}
});

// Grid Blog Listing
jQuery.fn.blog_listing_addon = function (addon_options) {
	"use strict";
	//Set Variables
	var addon_el = jQuery(this),
		addon_base = this,
		img_count = addon_options.items.length,
		img_per_load = addon_options.load_count,
		$newEls = '',
		loaded_object = '',
		$container = jQuery('.sayit_blog_type_grid');
	
	jQuery('.grid_blog_trigger').on('click', function () {
		$newEls = '';
		loaded_object = '';
		var loaded_images = $container.find('.added').length;
		if ((img_count - loaded_images) > img_per_load) {
			var now_load = img_per_load;
		} else {
			now_load = img_count - loaded_images;
		}
		
		if ((loaded_images + now_load) == img_count) {
			jQuery(this).fadeOut();
			jQuery(this).parent().addClass('all_posts_loaded');
		}
		
		if (loaded_images < 1) {
			var i_start = 1;
		} else {
			i_start = loaded_images + 1;
		}
		
		if (now_load > 0) {
			// load more elements
			for (var i = i_start - 1; i < i_start + now_load - 1; i++) {
				loaded_object = loaded_object +
					'<div class="sayit_blog_item added sayit_load">' +
						'<div class="sayit_blog_item_wrapper">' +
							'<div class="sayit_blog_item_fimage">' +
								'<a href="' + addon_options.items[i].post_link + '">' +
									'<img src="' + addon_options.items[i].img_url + '" alt="" />' +
								'</a>' +
							'</div>' +
							'<div class="sayit_meta">' +
								'<div class="sayit_post_categories">' +
									'<a href="#">' + addon_options.items[i].post_ctagory + '</a>' +
								'</div>' +
								'<span> / </span>' +
								'<div class="sayit_post_date">' + addon_options.items[i].post_date + '</div>' +
							'</div>' +
							'<h4 class="sayit_post_title">' +
								'<a href="' + addon_options.items[i].post_link + '">' + addon_options.items[i].post_title + '</a>' +
							'</h4>' +
							'<div class="sayit_post_excerpt">' +
								addon_options.items[i].post_excerpt  +
							'</div>' +
						'</div>' +
					'</div>';
			}
			
			$newEls = jQuery(loaded_object);
			$container.append($newEls);
			
			setTimeout(function () {
				jQuery('.sayit_blog_type_grid').find('.sayit_load').removeClass('sayit_load');
			}, 400);
		}
	});
};

// Masonry Blog Listing
jQuery.fn.masonry_listing_addon = function (addon_options) {
	"use strict";
	//Set Variables
	var addon_el = jQuery(this),
		addon_base = this,
		img_count = addon_options.items.length,
		img_per_load = addon_options.load_count,
		$newEls = '',
		loaded_object = '',
		$container = jQuery('.sayit_blog_type_masonry');
	
	jQuery('.masonry_blog_trigger').on('click', function () {
		$newEls = '';
		loaded_object = '';
		var loaded_images = $container.find('.added').length;
		if ((img_count - loaded_images) > img_per_load) {
			var now_load = img_per_load;
		} else {
			now_load = img_count - loaded_images;
		}
		
		if ((loaded_images + now_load) == img_count) {
			jQuery(this).fadeOut();
			jQuery(this).parent().addClass('all_posts_loaded');
		}
		
		if (loaded_images < 1) {
			var i_start = 1;
		} else {
			i_start = loaded_images + 1;
		}
		
		if (now_load > 0) {
			// load more elements
			for (var i = i_start - 1; i < i_start + now_load - 1; i++) {
				loaded_object = loaded_object +
					'<div class="sayit_blog_item added sayit_load">' +
						'<div class="sayit_blog_item_wrapper">' +
							'<div class="sayit_blog_item_fimage">' +
								'<a href="' + addon_options.items[i].post_link + '">' +
									'<img src="' + addon_options.items[i].img_url + '" alt="" />' +
								'</a>' +
							'</div>' +
							'<div class="sayit_meta">' +
								'<div class="sayit_post_categories">' +
									'<a href="#">' + addon_options.items[i].post_ctagory + '</a>' +
								'</div>' +
								'<span> / </span>' +
								'<div class="sayit_post_date">' + addon_options.items[i].post_date + '</div>' +
							'</div>' +
							'<h4 class="sayit_post_title">' +
								'<a href="' + addon_options.items[i].post_link + '">' + addon_options.items[i].post_title + '</a>' +
							'</h4>' +
							'<div class="sayit_post_excerpt">' +
								addon_options.items[i].post_excerpt  +
							'</div>' +
						'</div>' +
					'</div>';
			}
			
			$newEls = jQuery(loaded_object);
			$container.isotope('insert', $newEls, function () {
				$container.isotope('reLayout');
			});
			
			setTimeout("jQuery('.sayit_blog_type_masonry').isotope();", 500);
			setTimeout("jQuery('.sayit_blog_type_masonry').isotope();", 1000);
			setTimeout("jQuery('.sayit_blog_type_masonry').isotope();", 2000);
			setTimeout("jQuery('.sayit_blog_type_masonry').isotope();", 3000);
			
			setTimeout(function () {
				jQuery('.sayit_blog_type_masonry').find('.sayit_load').removeClass('sayit_load');
			}, 700);
		}
	});
};

// Masonry Blog Listing Type 2
jQuery.fn.masonry_2_listing_addon = function (addon_options) {
	"use strict";
	//Set Variables
	var addon_el = jQuery(this),
		addon_base = this,
		img_count = addon_options.items.length,
		img_per_load = addon_options.load_count,
		$newEls = '',
		loaded_object = '',
		$container = jQuery('.sayit_blog_type_masonry_2');
	
	jQuery('.masonry_2_blog_trigger').on('click', function () {
		$newEls = '';
		loaded_object = '';
		var loaded_images = $container.find('.added').length;
		if ((img_count - loaded_images) > img_per_load) {
			var now_load = img_per_load;
		} else {
			now_load = img_count - loaded_images;
		}
		
		if ((loaded_images + now_load) == img_count) {
			jQuery(this).fadeOut();
			jQuery(this).parent().addClass('all_posts_loaded');
		}
		
		if (loaded_images < 1) {
			var i_start = 1;
		} else {
			i_start = loaded_images + 1;
		}
		
		if (now_load > 0) {
			// load more elements
			for (var i = i_start - 1; i < i_start + now_load - 1; i++) {
				loaded_object = loaded_object +
					'<div class="sayit_blog_item added sayit_load">' +
						'<div class="sayit_blog_item_wrapper">' +
							'<a href="' + addon_options.items[i].post_link + '">' +
								'<img src="' + addon_options.items[i].img_url + '" alt="" />' +
								'<div class="sayit_overlay"></div>' +
								'<div class="sayit_top_overlay"></div>' +
								'<div class="sayit_bottom_overlay"></div>' +
								'<div class="sayit_top_cont">' +
									'<div class="sayit_post_categories">' +
										'<span class="sayit_cat">' + addon_options.items[i].post_category + '</span>' +
									'</div>' +
									'<h4 class="sayit_post_title">' + addon_options.items[i].post_title + '</h4>' +
								'</div>' +
								'<div class="sayit_bottom_cont">' +
									'<div class="sayit_post_date">' + addon_options.items[i].post_date + '</div>' +
									'<div class="sayit_post_comments">' +
										'<i class="fa fa-comment-o"></i> ' + addon_options.items[i].post_comments + '' +
									'</div>' +
								'</div>' +
							'</a>' +
						'</div>' +
					'</div>';
			}
			
			$newEls = jQuery(loaded_object);
			$container.isotope('insert', $newEls, function () {
				$container.isotope('reLayout');
			});
			
			sayit_masonry_2_overlays();
			
			setTimeout("jQuery('.sayit_blog_type_masonry_2').isotope();", 500);
			setTimeout("jQuery('.sayit_blog_type_masonry_2').isotope();", 1000);
			setTimeout("jQuery('.sayit_blog_type_masonry_2').isotope();", 2000);
			setTimeout("jQuery('.sayit_blog_type_masonry_2').isotope();", 3000);
			
			setTimeout(function () {
				jQuery('.sayit_blog_type_masonry_2').find('.sayit_load').removeClass('sayit_load');
			}, 700);
		}
	});
};

// Packery Blog Listing
jQuery.fn.packery_listing_addon = function (addon_options) {
	"use strict";
	//Set Variables
	var addon_el = jQuery(this),
		addon_base = this,
		img_count = addon_options.items.length,
		img_per_load = addon_options.load_count,
		$newEls = '',
		loaded_object = '',
		$container = jQuery('.sayit_packery_blog_listing_cont');
	
	jQuery('.packery_blog_trigger').on('click', function () {
		$newEls = '';
		loaded_object = '';
		var loaded_images = $container.find('.added').length;
		if ((img_count - loaded_images) > img_per_load) {
			var now_load = img_per_load;
		} else {
			now_load = img_count - loaded_images;
		}
		
		if ((loaded_images + now_load) == img_count) {
			jQuery(this).fadeOut();
			jQuery(this).parent().addClass('all_posts_loaded');
		}
		
		if (loaded_images < 1) {
			var i_start = 1;
		} else {
			i_start = loaded_images + 1;
		}
		
		if (now_load > 0) {
			// load more elements
			for (var i = i_start - 1; i < i_start + now_load - 1; i++) {
				loaded_object = loaded_object +
					'<div class="sayit_blog_item item_' + addon_options.items[i].item_number + ' added sayit_load">' +
						'<div class="sayit_blog_item_wrapper">' +
							'<a href="' + addon_options.items[i].post_link + '">' +
								'<img src="' + addon_options.items[i].img_url + '" alt="" />' +
								'<div class="sayit_overlay"></div>' +
								'<div class="sayit_bottom_overlay"></div>' +
								'<div class="sayit_post_content_cont">' +
									'<div class="sayit_post_categories">' +
										'<span class="sayit_cat">' + addon_options.items[i].post_category + '</span>' +
									'</div>' +
									'<h4 class="sayit_post_title">' + addon_options.items[i].post_title + '</h4>' +
									'<div class="sayit_post_excerpt">' + addon_options.items[i].post_excerpt + '</div>' +
									'<div class="sayit_post_date_cont">' +
										'<div class="sayit_post_date">' + addon_options.items[i].post_date + '</div>' +
										'<div class="sayit_post_comments"><i class="fa fa-comment-o"></i> ' + addon_options.items[i].post_comments + '</div>' +
										'<div class="clear"></div>' +
									'</div>' +
								'</div>' +
							'</a>' +
						'</div>' +
					'</div>';
			}
			
			$newEls = jQuery(loaded_object);
			$container.append($newEls);
			
			sayit_packery_overlays();
			
			setTimeout(function () {
				jQuery('.sayit_packery_blog_listing_cont').find('.sayit_load').removeClass('sayit_load');
			}, 400);
		}
	});
};
