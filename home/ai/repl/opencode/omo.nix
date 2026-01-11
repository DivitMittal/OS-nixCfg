_: let
  ohMyOpencodeConfig = {
    "$schema" = "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json";
    google_auth = false;
    agents = {
      # Sisyphus - Main orchestration agent (use Copilot Claude Sonnet)
      Sisyphus = {
        model = "github-copilot/claude-opus-4.5";
      };
      # Planner-Sisyphus - Planning agent (use Copilot Claude Sonnet)
      Planner-Sisyphus = {
        model = "github-copilot/claude-sonnet-4.5";
      };
      # Oracle - Expert advisor (use Copilot Claude Opus for highest quality)
      oracle = {
        model = "github-copilot/claude-opus-4.5";
      };
      # Frontend engineer (use Gemini for visual/UI work)
      frontend-ui-ux-engineer = {
        model = "google/gemini-3-pro-high";
      };
      # Document writer (use Gemini Flash for speed)
      document-writer = {
        model = "google/gemini-3-flash";
      };
      # Multimodal analysis (use Gemini 2.5 Flash)
      multimodal-looker = {
        model = "google/gemini-2.5-flash";
      };
      # Explore agent - codebase search (use Copilot Claude Sonnet)
      explore = {
        model = "github-copilot/claude-sonnet-4.5";
      };
      # Librarian - external docs search (use Gemini for speed/cost)
      librarian = {
        model = "google/gemini-3-pro-medium";
      };
    };
  };
in {
  ## oh-my-opencode
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON ohMyOpencodeConfig;
}
