#include <Windows.h>

LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);

char szClassName[] = "zad1";

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
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
		"zad1",
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT,
		512, 512,
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

int xSize, ySize;

LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	HDC hdc;
	int i = 0;
	PAINTSTRUCT ps;
	RECT r;
	HPEN hPen;
	HBRUSH hBrush;
	int k = xSize / 200;

	switch (message)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_SIZE:
		xSize = LOWORD(lParam);
		ySize = HIWORD(lParam);

		GetClientRect(hwnd, &r);
		InvalidateRect(hwnd, &r, true);

		break;
	case WM_PAINT:
		
		hdc = BeginPaint(hwnd, &ps);

		hPen = CreatePen(PS_SOLID, 2, RGB(0, 0, 0));
		
		//linie
		SelectObject(hdc, hPen);
		MoveToEx(hdc, xSize / 2, 0, NULL);
		LineTo(hdc, xSize / 2, ySize);
		MoveToEx(hdc, 0, ySize / 2, NULL);
		LineTo(hdc, xSize, ySize / 2);
		for (i = 0; i < xSize/2; i+= xSize / 40)
		{
			MoveToEx(hdc, xSize / 2 + i, ySize/2 - 5, NULL);
			LineTo(hdc, xSize / 2 + i, ySize / 2 + 5);
			MoveToEx(hdc, xSize / 2 - i, ySize / 2 - 5, NULL);
			LineTo(hdc, xSize / 2 - i, ySize / 2 + 5);
		}
		for (i = 0; i < ySize / 2; i += ySize / 40)
		{
			MoveToEx(hdc, xSize / 2 - 5, ySize / 2 + i, NULL);
			LineTo(hdc, xSize / 2 + 5, ySize / 2 + i);
			MoveToEx(hdc, xSize / 2 - 5, ySize / 2 - i, NULL);
			LineTo(hdc, xSize / 2 + 5, ySize / 2 - i);
		}
		DeleteObject(hPen);
		
		//wykres |x|
		hPen = CreatePen(PS_DOT, 1, RGB(255, 0, 0));
		SelectObject(hdc, hPen);
		
		MoveToEx(hdc, xSize / 2, ySize / 2, NULL);
		for (i = 1; i  < ySize / 2; i++)
		{
			LineTo(hdc, xSize / 2 + i, ySize / 2 - i);
		}
		MoveToEx(hdc, xSize / 2, ySize / 2, NULL);
		for (i = 1; i  < ySize / 2; i++)
		{
			LineTo(hdc, xSize / 2 - i, ySize / 2 - i);
		}
		DeleteObject(hPen);

		//wykres x^2
		hPen = CreatePen(PS_DASH, 2, RGB(0, 255, 0));
		SelectObject(hdc, hPen);

		MoveToEx(hdc, xSize / 2, ySize / 2, NULL);
		for (i = 1; i*i < ySize / 2; i++)
		{
			LineTo(hdc, xSize / 2 + i, ySize / 2 - i*i);
		}
		MoveToEx(hdc, xSize / 2, ySize / 2, NULL);
		for (i = 1; i * i < ySize / 2; i++)
		{
			LineTo(hdc, xSize / 2 - i, ySize / 2 - i*i);
		}
		DeleteObject(hPen);

		
		EndPaint(hwnd, &ps);
		break;
	default:
		return DefWindowProc(hwnd, message, wParam, lParam);
	}

	return 0;
}