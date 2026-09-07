amount = toint(dobjstr);
if (amount < 1 || tostr(amount) != dobjstr)
  return player:tell("Try 'slot <positive whole amount> in ", this:name(), "'.");
elseif (!this:can_play(player))
  return player:tell("Someone is using the machine, or it is processing a transaction.");
elseif (this:needs_maintenance())
  return player:tell("The machine needs maintenance before it can accept chyen.");
elseif (player.cash_value < amount)
  return player:tell("You don't have that much on you.");
endif
this.gambling_task = task_id();
try
  if (!$money:transact(player, amount, this, $money.LOG_CHYEN_TO_CREDITS))
    return player:tell("The machine could not accept your chyen.");
  endif
  this:issue_credits(amount);
  this.last_player = player;
finally
  this.gambling_task = 0;
endtry
$you:do_action("%N %<slots> some chyen into the %t.");
player:tell("Deposited ", $money:format(amount), ". Balance: ", $money:format(this.credits), ".");
"VMS NOTE Implement reusable gambling machine credit and session behavior. #107451 09/04/26 10:56";
"VMS VERSION 1.0";
"Last modified by MOOBot22684 (#107451) on Fri Sep  4 22:56:12 2026 PDT";
