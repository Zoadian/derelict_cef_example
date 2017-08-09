module cef_client;
import derelict.cef.cef;
import core.stdc.stdio;
import core.stdc.stdlib;

import cef_base;
extern(Windows) {

	extern cef_life_span_handler_t g_life_span_handler;

	cef_context_menu_handler_t* get_context_menu_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_context_menu_handler\n");
		return null;
	}

	cef_dialog_handler_t* get_dialog_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_dialog_handler\n");
		return null;
	}

	cef_display_handler_t* get_display_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_display_handler\n");
		return null;
	}

	cef_download_handler_t* get_download_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_download_handler\n");
		return null;
	}

	cef_drag_handler_t* get_drag_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_drag_handler\n");
		return null;
	}

	cef_focus_handler_t* get_focus_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_focus_handler\n");
		return null;
	}

	cef_geolocation_handler_t* get_geolocation_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_geolocation_handler\n");
		return null;
	}

	cef_jsdialog_handler_t* get_jsdialog_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_jsdialog_handler\n");
		return null;
	}

	cef_keyboard_handler_t* get_keyboard_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_keyboard_handler\n");
		return null;
	}

	cef_life_span_handler_t* get_life_span_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_life_span_handler\n");
		// Implemented!
		return &g_life_span_handler;
	}

	cef_load_handler_t* get_load_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_load_handler\n");
		return null;
	}

	cef_render_handler_t* get_render_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_render_handler\n");
		return null;
	}

	cef_request_handler_t* get_request_handler(cef_client_t* self) nothrow @nogc {
		// DEBUG_CALLBACK("get_request_handler\n");
		return null;
	}

	int on_process_message_received(cef_client_t* self, cef_browser_t* browser, cef_process_id_t source_process, cef_process_message_t* message) nothrow @nogc {
		// DEBUG_CALLBACK("on_process_message_received\n");
		return 0;
	}

	void initialize_cef_client(cef_client_t* client) {
		// DEBUG_CALLBACK("initialize_client_handler\n");
		client.base.size = cef_client_t.sizeof;
		initialize_cef_base_ref_counted(&client.base);
		// callbacks
		client.get_context_menu_handler = &get_context_menu_handler;
		client.get_dialog_handler = &get_dialog_handler;
		client.get_display_handler = &get_display_handler;
		client.get_download_handler = &get_download_handler;
		client.get_drag_handler = &get_drag_handler;
		client.get_focus_handler = &get_focus_handler;
		client.get_geolocation_handler = &get_geolocation_handler;
		client.get_jsdialog_handler = &get_jsdialog_handler;
		client.get_keyboard_handler = &get_keyboard_handler;
		client.get_life_span_handler = &get_life_span_handler;  // Implemented!
		client.get_load_handler = &get_load_handler;
		client.get_render_handler = &get_render_handler;
		client.get_request_handler = &get_request_handler;
		client.on_process_message_received = &on_process_message_received;
	}
}