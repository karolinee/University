#include <Windows.h>

LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);

char szClassName[] = "zad2";

DWORD xSize, ySize;
HKEY hKey;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{

	//odczyt z rejstru
	//RegCreateKeyEx(HKEY_CURRENT_USER, "Software\\Programowanie pod Windows", 0, NULL, 0, 0, NULL, &hKey, NULL);
	RegOpenKey(HKEY_CURRENT_USER, "Software\\Programowanie pod Windows", &hKey);
	DWORD sizeofx = sizeof(xSize);
	DWORD sizeofy  = sizeof(ySize);
	RegQueryValueEx(hKey, "x_size", NULL, NULL, (LPBYTE)&xSize, &sizeofx);
	RegQueryValueEx(hKey, "y_size", NULL, NULL, (LPBYTE)&ySize, &sizeofy);

	HWND hwnd;
	MSG messages;
	WNDCLASSEX wincl;

	

	wincl.hInstance = hInstance;
	wincl.lpszClassName = szClassName;
	wincl.lpfnWndProc = WindowProcedure;
	wincl.style = CS_DBLCLKS;
	wincl.cbSize = sizeof(WNDCLASSEX);

	wincl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wincl.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
	wincl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wincl.lpszMenuName = NULL;
	wincl.cbClsExtra = 0;
	wincl.cbWndExtra = 0;
	wincl.hbrBackground = (HBRUSH)GetStockObject(LTGRAY_BRUSH);

	if (!RegisterClassEx(&wincl)) return 0;

	hwnd = CreateWindowEx(
		0, szClassName,
		"zad2",
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT,
		xSize, ySize,
		HWND_DESKTOP, NULL,
		hInstance, NULL
		);

	ShowWindow(hwnd, nShowCmd);

	while (GetMessage(&messages, NULL, 0, 0))
	{
		TranslateMessage(&messages);
		DispatchMessage(&messages);
	}

	return messages.wParam;
}



LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	HDC hdc;

	switch (message)
	{
	case WM_SIZE:
		xSize = LOWORD(lParam);
		ySize = HIWORD(lParam);
		break;

	case WM_DESTROY:
		RegOpenKey(HKEY_CURRENT_USER, "Software\\Programowanie pod Windows", &hKey);
		RegSetValueEx(hKey, "x_size", NULL, REG_DWORD, (LPBYTE)&xSize, sizeof(xSize));
		RegSetValueEx(hKey, "y_size", NULL, REG_DWORD, (LPBYTE)&ySize, sizeof(ySize));
		RegCloseKey(hKey);
		PostQuitMessage(0);
		break;
	
	default:
		return DefWindowProc(hwnd, message, wParam, lParam);
	}

	return 0;
}