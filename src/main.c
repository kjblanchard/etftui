#include <Supergoon/log.h>
#include <Supergoon/lua.h>

void StartImpl(void) {
	LuaRunFile("assets/lua/main.lua");
}
