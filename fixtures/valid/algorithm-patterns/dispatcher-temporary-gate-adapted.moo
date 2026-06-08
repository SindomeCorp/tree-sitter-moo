":temporary_gate(LIST gates, MIXED group, MIXED location, STR mode, ?INT ttl) => LIST|INT";
"Called by dispatcher-style helpers to test or add a temporary duplicate-suppression gate.";
{gates, group, location, mode, ?ttl = 300} = args;
if (mode == "check")
  for gate in (gates)
    {gate_location, gate_group, gate_expires} = gate;
    if (location == gate_location && group == gate_group && time() < gate_expires)
      return 0;
    endif
  endfor
  return 1;
elseif (mode == "add")
  return {@gates, {location, group, time() + ttl}};
endif
return E_INVARG;
