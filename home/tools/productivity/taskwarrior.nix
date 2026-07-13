{pkgs, ...}: {
  home.packages = [pkgs.taskwarrior-tui];

  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior2;

    config = {
      default.command = "next";
      confirmation = "false";
      journal.time = "true";
      verbose = "blank,label,new-id,affected,edit,special,project,sync,unwait";

      ## GTD-aligned tag urgency — inbox/someday demoted so "next" and "today" surface
      urgency.user.tag.today.coefficient = "15.0";
      urgency.user.tag.next.coefficient = "12.0";
      urgency.user.tag.inbox.coefficient = "-3.0";
      urgency.user.tag.someday.coefficient = "-5.0";
      urgency.active.coefficient = "10.0";
      urgency.scheduled.coefficient = "5.0";
      urgency.due.coefficient = "12.0";
      urgency.priority.H.coefficient = "6.0";
      urgency.priority.M.coefficient = "3.9";
      urgency.priority.L.coefficient = "-1.8";

      ## UDA for linking tasks back to zk notes (8-char alphanum ID)
      uda.note.type = "string";
      uda.note.label = "Note";
      uda.note.values = "";

      ## Contexts mirror work/personal split
      context.work.read = "+work";
      context.work.write = "+work";
      context.personal.read = "-work";
      context.personal.write = "-work";

      ## taskwarrior-tui behaviour, read from taskrc
      uda.taskwarrior-tui.task-report.next-date-to-ude-days = "7";
      uda.taskwarrior-tui.task-report.prompt-on-done = "true";
      uda.taskwarrior-tui.task-report.looping = "true";
      uda.taskwarrior-tui.mouse = "true";
    };
  };
}
