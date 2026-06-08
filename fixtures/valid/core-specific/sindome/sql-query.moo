{connection, query, ?params = {}} = args;
if (typeof(query) != STR || !query)
  raise(E_INVARG, "query must be a non-empty string");
endif

return sql_query(connection, query, @params);
