":map_default_list(MAP buckets, STR key, ANY value) => MAP";
"Called by ToastStunt grouping helpers to append values under a key.";
{buckets, key, value} = args;
if (typeof(buckets) != MAP)
  buckets = [];
endif
bucket = `buckets[key] ! E_RANGE => {}';
buckets[key] = {@bucket, value};
return buckets;
