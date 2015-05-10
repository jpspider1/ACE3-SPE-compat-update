/*
 * Author: Bohemia Interactive
 * Module function for spawning mines
 * Edited to remove forced map markers and mines being revealed to players
 *
 * Arguments:
 * 0: The logic object <OBJECT>
 *
 * Return Value:
 * nil
 *
 * Public: No
 */

_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

if (_activated) then {
    _explosive = gettext (configfile >> "cfgvehicles" >> typeof _logic >> "explosive");
    if (_explosive != "") then {
        _explosive = createvehicle [_explosive,position _logic,[],0,"none"];
        _explosive attachto [_logic];

        /* Removed by ACE
        //--- Reveal the mine to curator's side
        {
            _side = (getassignedcuratorunit _x) call bis_fnc_objectSide;
            _side revealmine _explosive;
        } foreach (objectcurators _logic);

        //--- Mark minefields in the map
        [] spawn bis_fnc_drawMinefields;
        */

        //--- Show hint to curator who placed the object
        [[["Curator","PlaceMines"],nil,nil,nil,nil,nil,nil,true],"bis_fnc_advHint",_logic] call bis_fnc_mp;

        waituntil {sleep 0.1; isnull _explosive || isnull _logic || !alive _logic};
        if (isnull _logic) then {deletevehicle _explosive;} else {_explosive setdamage 1;};
        deletevehicle _logic;
    };
};