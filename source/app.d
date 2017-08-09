import core.runtime;
import core.sys.windows.windows;
import std.stdio;
import core.stdc.string;
import derelict.cef.cef;
import core.stdc.stdio;

import cef_app;
import cef_base;
import cef_client;
import cef_life_span_handler;

extern (Windows) {
	cef_life_span_handler_t g_life_span_handler = {};

	int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
		int result;

		try {
			Runtime.initialize();
			result = myWinMain(hInstance, hPrevInstance, lpCmdLine, nCmdShow);
			Runtime.terminate();
		}
		catch (Throwable e) {
			import std.string;
			MessageBoxA(null, e.toString().toStringz(), null, MB_ICONEXCLAMATION);
			result = 0;
		}

		return result;
	}
}

int myWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	DerelictCEF.load();
	// CefEnableHighDPISupport();

	static assert(is(cef_char_t == wchar));

	//###########################################################

	// Main args
	cef_main_args_t main_args = {};
	main_args.instance = GetModuleHandle(null);

	// App
	cef_app_t app = {};
	initialize_cef_app(&app);

	// Execute subprocesses
	int exit_code = cef_execute_process(&main_args, &app, null);
	if (exit_code >= 0) {
		return exit_code;
	}

	// Application settings
	cef_settings_t settings = {};
	settings.size = cef_settings_t.sizeof;
	settings.log_severity = LOGSEVERITY_WARNING; // Show only warnings/errors
	settings.no_sandbox = 1;
	// string _locale = "us-US";
	// cef_string_utf8_set(_locale.ptr, _locale.length, &settings.locale, 0);

	// Initialize CEF
	cef_initialize(&main_args, &settings, &app, null);

	// Window info
	cef_window_info_t window_info = {};
	window_info.style = WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN | WS_CLIPSIBLINGS | WS_VISIBLE;
	window_info.parent_window = null;
	window_info.x = CW_USEDEFAULT;
	window_info.y = CW_USEDEFAULT;
	window_info.width = CW_USEDEFAULT;
	window_info.height = CW_USEDEFAULT;

	string _windowName = `CEF WORKING`;
	cef_string_t cef_window_name = {};
	cef_string_utf8_to_utf16(_windowName.ptr, _windowName.length, &cef_window_name);
	window_info.window_name = cef_window_name;

	// Initial url
	// string _url = `https://www.google.com/ncr`;
	string _url = `zoadian.de`;
	cef_string_t cef_url = {};
	cef_string_utf8_to_utf16(_url.ptr, _url.length, &cef_url);

	cef_browser_settings_t browser_settings = {};
	browser_settings.size = cef_browser_settings_t.sizeof;

	// Client handlers
	cef_client_t client = {};
	initialize_cef_client(&client);
	initialize_cef_life_span_handler(&g_life_span_handler);

	// Create browser asynchronously. There is also a
	// synchronous version of this function available.
	cef_browser_host_create_browser_sync(&window_info, &client, &cef_url, &browser_settings, null);

	cef_run_message_loop();
	cef_shutdown();
	return 0;
}
