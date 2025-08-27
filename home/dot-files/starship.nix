{
  enable = true;
  settings = {
    # Get editor completions based on the config schema
    "$schema" = "https://starship.rs/config-schema.json";

    git_branch = {
      symbol = "🌱 ";
      truncation_length = 50;
      truncation_symbol = "";
      ignore_branches = [ "main" "master" ];
    };

    git_commit = {
      commit_hash_length = 7;
      tag_symbol = " 🏷️ ";
      only_detached = false;
    };

    git_state = {
      format = "[\($state( $progress_current of $progress_total)\)]($style) ";
      cherry_pick = "[🍒 PICKING(bold red)]";
    };

    git_metrics = {
      added_style = "bold blue";
      format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
    };

    git_status = {
      conflicted = "🏳 what?!? you might be confuzzled...";
      ahead = "🏎💨 ⇡$count";
      behind = "😰 ⇣$count backwards";
      diverged = "😵 ⇕⇡$ahead_count⇣$behind_count where are you?!?";
      up_to_date = "✅ #synced";
      untracked = "🤷 keeping that?";
      stashed = "📦 #setAside";
      modified = "📝 #changes";
      staged = "[++\($count\)](green)";
      renamed = "👅 #newPhoneWhoDis?";
      deleted = "🗑 ";
    };

    nodejs = {
      format = "via [🤖 $version](bold green) ";
    };

    docker_context = {
      format = "via [🐋 $context](blue bold)";
    };

    kubernetes = {
      format = "on [⛵ ($user on )($cluster in )$context \($namespace\)](dimmed green) ";
      disabled = false;
    };
  };
}
