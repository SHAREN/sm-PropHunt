
#include "prophunt/include/phclient.inc"

public Action Debug_ModelInfo(int client, int args) {
    ReplyToCommand(client, "Child entities: %d", g_iNumEntities);
    ReplyToCommand(client, "Clients: %d", GetTeamClientCount(CS_TEAM_CT) + GetTeamClientCount(CS_TEAM_T));

    for (int i = 1; i <= MaxClients; i++) {
        char name[64];
        if (IsClientInGame(i) && GetClientTeam(i) == CS_TEAM_T) {
            GetClientName(i, name, sizeof(name));
            RenderMode modeParent = GetEntityRenderMode(i);
            RenderMode modeChild;

            if (Entity_HasChild(i))
                modeChild = GetEntityRenderMode(Entity_GetChild(i));

            char strMP[16] = "other";
            char strMC[16] = "other";
            if (modeParent == RENDER_TRANSCOLOR) strMP = "TRANSCOLOR";
            if (modeParent == RENDER_NONE) strMP = "NONE";
            if (modeChild == RENDER_TRANSCOLOR) strMC = "TRANSCOLOR";
            if (modeChild == RENDER_NONE) strMC = "NONE";

            ReplyToCommand(client, "%s render mode: %s", name, strMP);
            if (Entity_HasChild(i))
                ReplyToCommand(client, "- Child render mode: %s", strMC);
        }
    }

    return Plugin_Handled;
}

public Action ReloadModels(int client, int args) {
    OnMapEnd();
    BuildMainMenu();
    ReplyToCommand(client, "PropHunt: Reloaded config.");
    return Plugin_Handled;
}
