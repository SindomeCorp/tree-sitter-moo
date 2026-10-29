":run_tests([STR phase = \"workflow\"]) => MAP";
"Returns map of phase, namespace, passed checks, and recycled fixture ids; nonproduction wizards only.";
"Wizard-only isolated Anaconda integration harness. No mutable Production bypass.";
"Public API: validates the calling permissions and player before work.";
"whitespace change";
this:_authorize("test", caller_perms());
{?phase = "workflow"} = args;
namespace = tostr("test:", time(), ":", task_id(), ":", random(1000000));
this.test_targets[namespace] = {};
this.test_inputs[namespace] = {};
checks = {};
base_code = {"return 1;", "\"VMS " + "NOTE shared base\";", "\"VMS " + "VERSION 1.0\";"};
dev_code = {"return 2;", "\"VMS " + "NOTE tested dev update\";", "\"VMS " + "NOTE shared base\";", "\"VMS " + "VERSION 1.01\";"};
try
  base = this:_fixture(namespace, base_code);
  object = toobj(base["object"]["id"]);
  submitted = base;
  submitted["code"] = dev_code;
  if (phase == "core")
    checks = {@checks, this:_assert(this:_codec(this:_codec(["who" -> player, "nested" -> {true, 1, ["a" -> "b"]}]), 1) == (["who" -> player, "nested" -> {true, 1, ["a" -> "b"]}]), "lossless registry object/map/list/bool round trip")};
    vms = this:_vms(dev_code);
    checks = {@checks, this:_assert(vms["body"] == {"return 2;"} && vms["version"] == "1.01" && vms["notes"] == {"tested dev update", "shared base"}, "anchored VMS parser")};
    checks = {@checks, this:_assert(this:_ancestry(base, submitted, namespace)[1], "recognized ancestry")};
    divergent = submitted;
    divergent["code"] = {"return 3;", "\"VMS " + "NOTE different history\";", "\"VMS " + "VERSION 1.0\";"};
    checks = {@checks, this:_assert(!this:_ancestry(base, divergent, namespace)[1], "same version does not prove ancestry")};
    missing = submitted;
    missing["code"] = {"return 4;"};
    checks = {@checks, this:_assert(!this:_ancestry(base, missing, namespace)[1], "missing history requires override")};
    row = this:_test_submission(namespace, submitted);
    newer = this:_test_submission(namespace, divergent, row["id"]);
    retired = this:_rows("get", namespace, row["id"])[1];
    checks = {@checks, this:_assert(retired["status"] == "superseded" && retired["superseded_by"] == newer["id"] && retired["submission"] == row["submission"], "atomic supersession retains immutable submission")};
    checks = {@checks, this:_assert(`this:_test_submission(namespace, submitted) ! E_INVARG => 0' == 0, "unconfirmed duplicate submission rejected")};
    checks = {@checks, this:_assert(`this:_decline(newer, "", namespace) ! E_INVARG => 0' == 0, "decline reason required")};
    this:_decline(newer, "not ready", namespace);
    declined = this:_rows("get", namespace, newer["id"])[1];
    checks = {@checks, this:_assert(declined["status"] == "declined" && typeof(declined["declined_on"]) == STR && declined["review"]["reason"] == "not ready", "decline records actor, date, reason")};
    checks = {@checks, this:_assert(`this:pull() ! E_PERM => "blocked"' == "blocked", "public review remains blocked on dev")};
    checks = {@checks, this:_assert(`this:rollback() ! E_PERM => "blocked"' == "blocked", "public rollback remains blocked on dev")};
    checked_out = base;
    checked_out["registry"] = this:_codec(["owner" -> player, "checked-out-by" -> player]);
    checks = {@checks, this:_assert(`this:_available(checked_out) ! E_PERM => "blocked"' == "blocked", "checkout safeguard cannot be overridden")};
    checks = {@checks, this:_assert(this:_db(this.SQL_GET_CURRENT_DATABASE) == {{"sddb-dev"}}, "database pinning")};
    add_verb(object, {player, "rxd", "probe"}, {"any", "none", "none"});
    checks = {@checks, this:_assert(`this:commit(tostr(object, ":probe")) ! E_INVARG => "blocked"' == "blocked", "ambiguous submission rejected")};
    delete_verb(object, length(verbs(object)));
    checks = {@checks, this:_assert(`this:commit(tostr(object, ":probe any none none")) ! E_INVARG => "blocked"' == "blocked", "optional argument specifications rejected")};
  elseif (phase == "workflow")
    row = this:_test_submission(namespace, submitted);
    this.test_inputs[namespace] = {"skip"};
    checks = {@checks, this:_assert(this:_review_one(row, "apply", namespace) == "skip" && this:_rows("get", namespace, row["id"])[1]["status"] == "pending", "skip leaves pending")};
    this.test_inputs[namespace] = {"quit"};
    checks = {@checks, this:_assert(this:_review_one(row, "apply", namespace) == "quit", "quit leaves pending")};
    this.test_inputs[namespace] = {"apply", "yes"};
    checks = {@checks, this:_assert(this:_review_one(row, "apply", namespace) == "applied", "review application")};
    applied = this:_rows("get", namespace, row["id"])[1];
    installed = this:_snapshot(object, "probe", base["args"]);
    checks = {@checks, this:_assert(installed["info"] == base["info"] && installed["registry"] == base["registry"], "existing metadata and registry preserved")};
    checks = {@checks, this:_assert(this:_vms(installed["code"])["version"] == "1.01" && length(this:_vms(installed["code"])["notes"]) == 3, "dev version and notes retained with migration note")};
    checks = {@checks, this:_assert(this:_same(applied["application"]["before"], base) && this:_same(applied["application"]["after"], installed), "before and installed snapshots recorded")};
    next_dev = submitted;
    next_dev["code"] = {"return 3;", "\"VMS " + "NOTE subsequent update\";", @dev_code[2..$]};
    checks = {@checks, this:_assert(this:_ancestry(installed, next_dev, namespace)[1], "prior SQL snapshot recognizes Production migration note")};
    checks = {@checks, this:_assert(`this:_operate(row, "apply", base, installed, "", 0, namespace) ! E_INVARG => "blocked"' == "blocked", "stale second reviewer cannot apply twice")};
    this.test_inputs[namespace] = {"1"};
    checks = {@checks, this:_assert(this:_rollback_menu(namespace) == row["id"], "rollback menu selects applied change")};
    this.test_inputs[namespace] = {"rollback", "broken behavior", "yes"};
    checks = {@checks, this:_assert(this:_review_one(applied, "rollback", namespace) == "rolled_back", "rollback through review")};
    restored = this:_snapshot(object, "probe", base["args"]);
    rolled = this:_rows("get", namespace, row["id"])[1];
    checks = {@checks, this:_assert(this:_same(restored, base), "rollback restores exact code VMS metadata and registry")};
    checks = {@checks, this:_assert(rolled["applied_on"] == applied["applied_on"] && typeof(rolled["rolled_back_on"]) == STR, "rollback retains application date")};
    this.test_inputs[namespace] = {"1", "quit"};
    checks = {@checks, this:_assert(this:_rollback_menu(namespace) == 0, "rolled-back menu entry disabled")};
    checks = {@checks, this:_assert(`this:_review_one(rolled, "rollback", namespace) ! E_INVARG => "blocked"' == "blocked", "repeat rollback rejected")};
    blank = this:_snapshot(object, "brand_new", base["args"]);
    fresh = submitted;
    fresh["names"] = "brand_new";
    fresh["info"][3] = "brand_new";
    fresh["registry"] = this:_codec(["owner" -> player]);
    row = this:_test_submission(namespace, fresh);
    this.test_inputs[namespace] = {"apply", "yes"};
    this:_review_one(row, "apply", namespace);
    applied = this:_rows("get", namespace, row["id"])[1];
    checks = {@checks, this:_assert(this:_snapshot(object, "brand_new", base["args"])["exists"], "new verb created")};
    this.test_inputs[namespace] = {"rollback", "remove broken addition", "REMOVE", "yes"};
    this:_review_one(applied, "rollback", namespace);
    checks = {@checks, this:_assert(this:_same(this:_snapshot(object, "brand_new", base["args"]), blank), "new verb and registry entry removed")};
  elseif (phase == "recovery")
    row = this:_test_submission(namespace, submitted);
    proposed = this:_proposed(row, base);
    this.test_faults[namespace] = "after_claim";
    checks = {@checks, this:_assert(`this:_operate(row, "apply", base, proposed, "", 0, namespace) ! E_INVARG => "interrupted"' == "interrupted", "interruption before save injected")};
    this.test_faults = mapdelete(this.test_faults, namespace);
    checks = {@checks, this:_assert(this:_recover(namespace)[1][2] == "pending" && this:_same(this:_snapshot(object, "probe", base["args"]), base), "before-save recovery leaves original untouched")};
    broken = proposed;
    broken["code"] = {"this is invalid moo syntax !!!"};
    checks = {@checks, this:_assert(`this:_operate(row, "apply", base, broken, "", 0, namespace) ! E_INVARG => "failed"' == "failed", "compilation failure surfaced")};
    checks = {@checks, this:_assert(this:_rows("get", namespace, row["id"])[1]["status"] == "pending" && this:_same(this:_snapshot(object, "probe", base["args"]), base), "compile failure preserves original and returns pending")};
    this.test_faults[namespace] = "after_save";
    checks = {@checks, this:_assert(`this:_operate(row, "apply", base, proposed, "", 0, namespace) ! E_INVARG => "interrupted"' == "interrupted", "completion database failure injected")};
    this.test_faults = mapdelete(this.test_faults, namespace);
    checks = {@checks, this:_assert(this:_recover(namespace)[1][2] == "applied", "after-save recovery finalizes without replay")};
    installed = this:_snapshot(object, "probe", base["args"]);
    checks = {@checks, this:_assert(this:_same(installed, proposed) && !this:_recover(namespace), "recovery is idempotent")};
    applied = this:_rows("get", namespace, row["id"])[1];
    drift = installed;
    drift["code"] = {"return 99;"};
    this:_save(installed, drift);
    this.test_inputs[namespace] = {"rollback", "later edit also broken", "OVERRIDE", "yes"};
    checks = {@checks, this:_assert(this:_review_one(applied, "rollback", namespace) == "rolled_back", "rollback drift override")};
    rolled = this:_rows("get", namespace, row["id"])[1];
    checks = {@checks, this:_assert(this:_same(rolled["rollback"]["before"], drift) && rolled["rollback"]["override"] == 1 && this:_same(this:_snapshot(object, "probe", base["args"]), base), "override retains displaced work and restores exact baseline")};
    row = this:_test_submission(namespace, submitted);
    proposed = this:_proposed(row, base);
    this.test_inputs[namespace] = {"apply", ["snapshot" -> drift, "answer" -> "yes"]};
    checks = {@checks, this:_assert(`this:_review_one(row, "apply", namespace) ! E_INVARG => "blocked"' == "blocked", "edit during review blocks stale application")};
    checks = {@checks, this:_assert(this:_same(this:_snapshot(object, "probe", base["args"]), drift) && this:_rows("get", namespace, row["id"])[1]["status"] == "needs_attention", "recovery never overwrites intervening edits")};
  elseif (phase == "edges")
    row = this:_test_submission(namespace, submitted);
    divergent = base;
    divergent["code"] = {"return 77;", "\"VMS " + "NOTE production hotfix\";", "\"VMS " + "VERSION 1.01\";"};
    this:_save(base, divergent);
    this.test_inputs[namespace] = {"apply", "", "OVERRIDE", "yes"};
    checks = {@checks, this:_assert(`this:_review_one(row, "apply", namespace) ! E_INVARG => "blocked"' == "blocked", "application override requires a reason")};
    this.test_inputs[namespace] = {"apply", "reviewed hotfix replacement", "OVERRIDE", "yes"};
    checks = {@checks, this:_assert(this:_review_one(row, "apply", namespace) == "applied", "explicit application conflict override")};
    applied = this:_rows("get", namespace, row["id"])[1];
    installed = applied["application"]["after"];
    checks = {@checks, this:_assert(applied["application"]["override"] == 1 && this:_same(applied["application"]["before"], divergent), "application override preserves displaced hotfix")};
    this.test_faults[namespace] = "after_save";
    checks = {@checks, this:_assert(`this:_operate(applied, "rollback", installed, divergent, "rollback recovery test", 0, namespace) ! E_INVARG => "interrupted"' == "interrupted", "rollback completion failure injected")};
    this.test_faults = mapdelete(this.test_faults, namespace);
    checks = {@checks, this:_assert(this:_recover(namespace)[1][2] == "rolled_back" && this:_same(this:_snapshot(object, "probe", base["args"]), divergent), "rollback recovery finalizes exact restoration")};
    row = this:_test_submission(namespace, submitted);
    checked = divergent;
    checked["registry"] = this:_codec(["owner" -> player, "checked-out-by" -> player]);
    $vms2.registry[object][$vms2:build_verb_identifier(object, 1)] = this:_codec(checked["registry"], 1);
    this.test_inputs[namespace] = {"decline", "target is still being edited"};
    checks = {@checks, this:_assert(this:_review_one(row, "apply", namespace) == "declined", "blocked target can still be declined")};
    $vms2.registry[object][$vms2:build_verb_identifier(object, 1)] = this:_codec(divergent["registry"], 1);
    absent = this:_snapshot(object, "invalid_new", base["args"]);
    invalid = absent;
    invalid["exists"] = 1;
    invalid["info"] = {toint(player), "rxd", "invalid_new"};
    invalid["owner_name"] = player.name;
    invalid["registry"] = this:_codec(["owner" -> player]);
    invalid["object_registered"] = 1;
    invalid["code"] = {"not valid moo !!"};
    checks = {@checks, this:_assert(`this:_save(absent, invalid) ! E_INVARG => "failed"' == "failed" && this:_same(this:_snapshot(object, "invalid_new", base["args"]), absent), "new-verb compilation failure leaves no stub or registry entry")};
    row = this:_test_submission(namespace, submitted);
    fake_identity = row;
    fake_identity["submission"]["snapshot"]["object"]["created"] = "different incarnation";
    this.test_inputs[namespace] = {"decline", "target was recycled"};
    checks = {@checks, this:_assert(this:_review_one(fake_identity, "apply", namespace) == "declined", "identity mismatch cannot apply but can be declined")};
    real_player = player;
    actor = create($generic_utils, real_player);
    actor.name = tostr("Verb migration fixture ", namespace, " actor");
    this.test_targets[namespace] = {@this.test_targets[namespace], toint(actor)};
    try
      player = actor;
      actor.programmer = 0;
      nonprogrammer = `this:_authorize("commit", actor) ! E_PERM => "blocked"';
      actor.programmer = 1;
      programmer = this:_authorize("commit", actor);
      nonwizard = `this:_authorize("production", actor) ! E_PERM => "blocked"';
    finally
      player = real_player;
    endtry
    checks = {@checks, this:_assert(nonprogrammer == "blocked" && programmer == 1, "programmer flag controls submission authorization")};
    checks = {@checks, this:_assert(nonwizard == "blocked", "nonwizard cannot authorize Production operations")};
    checks = {@checks, this:_assert(!this:_rows("get", "live", row["id"]), "test namespace cannot enter live queue")};
  elseif (phase == "review")
    regressions = this:_review_regressions(namespace, base);
    player:tell("Review regression observations: ", generate_json(regressions));
    for regression in (regressions)
      checks = {@checks, this:_assert(regression[1], regression[2])};
    endfor
  elseif (phase == "history")
    template = this:_test_submission(namespace, submitted);
    this:_decline(template, "history fixture seed", namespace);
    operation = ["actor_name" -> player.name, "actor" -> toint(player), "before" -> base, "after" -> submitted];
    rows = this:_db(this.SQL_TEST_INSERT_APPLICATION_HISTORY, {namespace, toint(object), template["verb_key"], generate_json(template["submission"]), generate_json(operation)});
    history = this:_rows("history", namespace);
    checks = {@checks, this:_assert(length(history) == 50 && history[1]["id"] == toint(rows[$][1]) && history[$]["id"] == toint(rows[6][1]), "menu query returns exactly latest 50 in descending application order")};
    this.test_inputs[namespace] = {"51", "2"};
    checks = {@checks, this:_assert(this:_rollback_menu(namespace) == history[2]["id"], "menu rejects out-of-range selection and selects by displayed position")};
  else
    raise(E_INVARG, "Choose core, workflow, recovery, edges, review, or history.");
  endif
  result = ["phase" -> phase, "namespace" -> namespace, "passed" -> length(checks), "checks" -> checks, "fixture_objects" -> this.test_targets[namespace]];
finally
  for fixture_id in (this.test_targets[namespace])
    fixture = toobj(fixture_id);
    if ($recycler:valid(fixture) && fixture.owner == this.owner && index(fixture.name, tostr("Verb migration fixture ", namespace)) == 1)
      if (maphaskey($vms2.registry, fixture))
        $vms2.registry = mapdelete($vms2.registry, fixture);
      endif
      recycle(fixture);
    endif
  endfor
  this.test_inputs = mapdelete(this.test_inputs, namespace);
  if (maphaskey(this.test_faults, namespace))
    this.test_faults = mapdelete(this.test_faults, namespace);
  endif
  this.test_targets = mapdelete(this.test_targets, namespace);
endtry
return result;
"VMS NOTE Remove fixed-object guard and use existing VMS registry wrappers where applicable. #107451 10/29/26  7:39";
"VMS VERSION 1.02";
"Last modified by MOOBot22684 (#107451) on Thu Oct 29 07:39:40 2026 PDT";
