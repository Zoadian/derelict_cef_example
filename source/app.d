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
	writeln("hello");
	// writeln(hInstance, lpCmdLine[0..strlen(lpCmdLine)], nCmdShow);

	DerelictCEF.load();
	// CefEnableHighDPISupport();

	//###########################################################

	// Main args
	cef_main_args_t main_args;
	main_args.instance = GetModuleHandle(null);

	// App
	writeln("init app");
	cef_app_t app;
	initialize_cef_app(&app);

	// Execute subprocesses
	writeln("exec process");
	int exit_code = cef_execute_process(&main_args, null, null);
	if (exit_code >= 0) {
		return exit_code;
	}

	// Application settings
	cef_settings_t settings;
	settings.size = cef_settings_t.sizeof;
	settings.log_severity = LOGSEVERITY_WARNING; // Show only warnings/errors
	settings.no_sandbox = 1;
	string _locale = "us-US";
	cef_string_utf8_set(_locale.ptr, _locale.length, &settings.locale, 0);

	// Initialize CEF
	writeln("cef_initialize");
	cef_initialize(&main_args, &settings, &app, null);
// version(none)
{

	// Window info
	cef_window_info_t window_info;
	window_info.style = WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN | WS_CLIPSIBLINGS | WS_VISIBLE;
	window_info.parent_window = null;
	window_info.x = CW_USEDEFAULT;
	window_info.y = CW_USEDEFAULT;
	window_info.width = CW_USEDEFAULT;
	window_info.height = CW_USEDEFAULT;
	string _windowName = `CEF WORKING!`;
	cef_string_utf8_set(_windowName.ptr, _windowName.length, &window_info.window_name, 0);

	// Initial url
	string _url = `https://www.google.com/ncr`;
	cef_string_utf8_t url;
	cef_string_utf8_set(_url.ptr, _url.length, &url, 0);

	cef_browser_settings_t browser_settings;
	browser_settings.size = cef_browser_settings_t.sizeof;

	// Client handlers
	cef_client_t client;
	initialize_cef_client(&client);
	initialize_cef_life_span_handler(&g_life_span_handler);

	// Create browser asynchronously. There is also a
	// synchronous version of this function available.
	printf("cef_browser_host_create_browser\n");
	cef_browser_host_create_browser(&window_info, &client, &url, &browser_settings, null);

	printf("cef_run_message_loop\n");
	cef_run_message_loop();
}
	// cef_shutdown();

	writeln("byebye");
	return 0;
}
