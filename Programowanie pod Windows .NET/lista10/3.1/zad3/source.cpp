#include <Windows.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>


LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);

char windowName[] = "zad3";

struct
{
	TCHAR* szClass;
	int iStyle;
	TCHAR* szText;
}button[] =
{
	(TCHAR*)"BUTTON", BS_GROUPBOX, (TCHAR*)"Uczelnia",
	(TCHAR*)"BUTTON", BS_GROUPBOX, (TCHAR*)"Rodzaj studiów",
	(TCHAR*)"EDIT", WS_BORDER, (TCHAR*)"",
	(TCHAR*)"EDIT", WS_BORDER, (TCHAR*)"",
	(TCHAR*)"BUTTON", BS_AUTOCHECKBOX, (TCHAR*)"dzienne",
	(TCHAR*)"BUTTON", BS_AUTOCHECKBOX,(TCHAR*)"uzupelniajace",
	(TCHAR*)"BUTTON", BS_PUSHBUTTON, (TCHAR*)"Akceptuj",
	(TCHAR*)"BUTTON", BS_PUSHBUTTON, (TCHAR*)"Anuluj",
};

#define NUM (sizeof button/sizeof button[0])

int WINAPI WinMain(HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nShowCmd)
{
	HWND hwnd;
	MSG messages;
	WNDCLASSEX wincl;

	wincl.hInstance = hInstance;
	wincl.lpszClassName = windowName;
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

	if (!RegisterClassEx(&wincl))
		return 0;

	hwnd = CreateWindowEx(0,
		windowName,
		"zad3",
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		520,
		300,
		HWND_DESKTOP,
		NULL,
		hInstance,
		NULL);

	ShowWindow(hwnd, nShowCmd);

	while (GetMessage(&messages, NULL, 0, 0))
	{
		TranslateMessage(&messages);
		DispatchMessage(&messages);
	}

	return messages.wParam;
}

int xSize, ySize;

LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	static HWND hwndButton[NUM + 1];
	static int cxChar, cyChar;
	static RECT r;
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message)
	{
	
	case WM_CREATE:
		cxChar = LOWORD(GetDialogBaseUnits());
		cyChar = HIWORD(GetDialogBaseUnits());
		//groupbox1
		hwndButton[0] = CreateWindow(button[0].szClass,
			button[0].szText,
			WS_CHILD | WS_VISIBLE | button[0].iStyle,
			cxChar, cyChar, cxChar * 60, cyChar * 6, hwnd, (HMENU)0, ((LPCREATESTRUCT)lParam)->hInstance, NULL);
		//groupbox2
		hwndButton[1] = CreateWindow(button[1].szClass,
			button[1].szText,
			WS_CHILD | WS_VISIBLE | button[1].iStyle,
			cxChar, cyChar * 8, cxChar * 60, cyChar * 5.5, hwnd, (HMENU)1, ((LPCREATESTRUCT)lParam)->hInstance, NULL);

		//textbox1
		hwndButton[2] = CreateWindow(button[2].szClass,
			button[2].szText,
			WS_CHILD | WS_VISIBLE | button[2].iStyle,
			cxChar * 12, cyChar * 3, cxChar * 48, cyChar, hwnd, (HMENU)2, ((LPCREATESTRUCT)lParam)->hInstance, NULL);
		//textbox1
		hwndButton[3] = CreateWindow(button[3].szClass,
			button[3].szText,
			WS_CHILD | WS_VISIBLE | button[3].iStyle,
			cxChar * 12, cyChar * 5, cxChar * 48, cyChar, hwnd, (HMENU)3, ((LPCREATESTRUCT)lParam)->hInstance, NULL);

		//checkbox1
		hwndButton[4] = CreateWindow(button[4].szClass,
			button[4].szText,
			WS_CHILD | WS_VISIBLE | button[4].iStyle,
			cxChar * 12, cyChar * 12, cxChar * 10, cyChar, hwnd, (HMENU)4, ((LPCREATESTRUCT)lParam)->hInstance, NULL);
		//checkbox1
		hwndButton[5] = CreateWindow(button[5].szClass,
			button[5].szText,
			WS_CHILD | WS_VISIBLE | button[5].iStyle,
			cxChar * 23, cyChar * 12, cxChar * 15, cyChar, hwnd, (HMENU)5, ((LPCREATESTRUCT)lParam)->hInstance, NULL);

		//button1
		hwndButton[6] = CreateWindow(button[6].szClass,
			button[6].szText,
			WS_CHILD | WS_VISIBLE | button[6].iStyle,
			cxChar, cyChar * 14, cxChar * 10, cyChar*1.7, hwnd, (HMENU)6, ((LPCREATESTRUCT)lParam)->hInstance, NULL);
		//button2
		hwndButton[7] = CreateWindow(button[7].szClass,
			button[7].szText,
			WS_CHILD | WS_VISIBLE | button[7].iStyle,
			cxChar * 51, cyChar * 14, cxChar * 10, cyChar*1.7, hwnd, (HMENU)7, ((LPCREATESTRUCT)lParam)->hInstance, NULL);

		//bombobox
		hwndButton[8] = CreateWindow("COMBOBOX",
			"",
			WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST,
			cxChar * 12, cyChar * 10, cxChar * 48, 150, hwnd, (HMENU)8, ((LPCREATESTRUCT)lParam)->hInstance, NULL);
		SendMessage(hwndButton[8], CB_ADDSTRING, 0, (LPARAM)"3-letnie");
		SendMessage(hwndButton[8], CB_ADDSTRING, 0, (LPARAM)"3,5-letnie");
		SendMessage(hwndButton[8], CB_ADDSTRING, 0, (LPARAM)"5-letnie");

		break;
	case WM_PAINT:
		hdc = BeginPaint(hwnd, &ps);
		SetBkMode(hdc, TRANSPARENT);
		TextOut(hdc, cxChar * 2, cyChar * 3, "Nazwa:", strlen("Nazwa:"));
		TextOut(hdc, cxChar * 2, cyChar * 5, "Adres:", strlen("Adres:"));
		TextOut(hdc, cxChar * 2, cyChar * 10.3, "Cykl nauki:", strlen("Cykl nauki:"));
		EndPaint(hwnd, &ps);
		break;
	case WM_COMMAND: 
		if (LOWORD(wParam) == 6) 
		{
			char buffer[256];
			char tmp[64];

			SendMessage(hwndButton[2], WM_GETTEXT, sizeof(buffer) / sizeof(buffer[0]), (LPARAM)(buffer));
			strcat_s(buffer, "\n");
			
			SendMessage(hwndButton[3], WM_GETTEXT, sizeof(tmp) / sizeof(tmp[0]), (LPARAM)(tmp));
			strcat_s(buffer, tmp);
			strcat_s(buffer, "\n");

			SendMessage(hwndButton[8], WM_GETTEXT, sizeof(tmp) / sizeof(tmp[0]), (LPARAM)(tmp));
			strcat_s(buffer, tmp);
			strcat_s(buffer, "\n");

			LRESULT chBox1 = SendMessage((HWND)hwndButton[4], BM_GETCHECK, 0, 0);
			LRESULT chBox2 = SendMessage((HWND)hwndButton[5], BM_GETCHECK, 0, 0);
			if (chBox1 == BST_CHECKED) {
				strcat_s(buffer, "dzienne");
				strcat_s(buffer, "\n");
			}
			if (chBox2 == BST_CHECKED) {
				strcat_s(buffer, "uzupelniajace");
				strcat_s(buffer, "\n");
			}
			
			MessageBox(NULL, buffer, "OK", MB_OK);
		}
		if (LOWORD(wParam) == 7) 
		{
			PostQuitMessage(0);
		}
		break;
		
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hwnd, message, wParam, lParam);
	}

	return 0;
}

