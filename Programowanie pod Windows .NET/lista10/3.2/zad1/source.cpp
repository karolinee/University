#include <Windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>
#include <Shlwapi.h>
#include <commdlg.h> 
#include <shlobj.h> 

int main(void)
{
	//pobranie czasu systemowego
	SYSTEMTIME st;
	GetLocalTime(&st);

	char currentTime[32] = "";
	static wchar_t path[32];

	sprintf_s(currentTime, "%d-%d-%d  %d:%d:%d", st.wDay, st.wMonth, st.wYear, st.wHour, st.wMinute, st.wSecond);

	//znalezienie œcie¿ki pulpitu
	SHGetFolderPath(NULL, CSIDL_DESKTOP, NULL, 0, path);
	PathAppend(path, L"system_time.txt");

	OPENFILENAME openFile;
	HANDLE hFile = CreateFile(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS ,FILE_ATTRIBUTE_NORMAL, NULL);
	WriteFile(hFile, &currentTime, 19, 0, NULL);
	CloseHandle(hFile);


	//drukowanie
	ShellExecute(NULL, L"print", path, NULL, NULL, SW_HIDE);
	

	return 0;
}