#include <SDL3/SDL_main.h>
#include <Supergoon/engine.h>
#include <Supergoon/log.h>
#include <Supergoon/lua.h>

static void Start(void) {
	LuaRunFile("assets/lua/main.lua");
}

int main(int argc, char* argv[]) {
	SetStartFunction(Start);
	Run();
	return 0;
}
