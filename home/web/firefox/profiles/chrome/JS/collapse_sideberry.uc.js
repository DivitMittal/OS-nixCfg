// ==UserScript==
// @name           collapse_sideberry
// @version        0.0.1
// @description    dynamically collapses sidebar if the sidebarcommand is sideberry
// @autor          DivitMittal
// ==/UserScript==

const extendSidebarBox = (sidebarBox) => {
  sidebarBox.style.width = "350px";
};

const resetSidebarBox = (sidebarBox) => {
  sidebarBox.style.position = "absolute";
  sidebarBox.style.right = "0px";
  sidebarBox.style.height = "100vh";
  sidebarBox.style.width = "35px";
  sidebarBox.style.zIndex = "5";
  sidebarBox.style.minWidth = "unset";
  sidebarBox.style.transition = "all 0.05s ease-in-out";
};

const handleSidebar = (sidebarBox) => {
  if (!sidebarBox) {
    console.log("Sidebar box not found");
    return;
  }

  resetSidebarBox(sidebarBox);

  // Mouse activation
  sidebarBox.addEventListener("mouseenter", () => extendSidebarBox(sidebarBox));
  sidebarBox.addEventListener("mouseleave", () => resetSidebarBox(sidebarBox));

  // Keyboard activation
  window.addEventListener("keydown", (e) => {
    if (e.key === "Control") {
      setTimeout(() => {
        extendSidebarBox(sidebarBox);
      }, 25);
    }
  });

  window.addEventListener("keyup", (e) => {
    if (e.key === "Control") {
      setTimeout(() => {
        resetSidebarBox(sidebarBox);
      }, 25);
    }
  });
};

// Try to find the sidebar box initially
let sidebarBox = document.querySelector(
  '#main-window:not([extradragspace="true"]) #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:not([hidden])',
);

if (sidebarBox) {
  handleSidebar(sidebarBox);
} else {
  console.log(
    "Sidebar box not found on initial load, setting up MutationObserver",
  );
  // Use MutationObserver to watch for sidebar dynamically added
  const observer = new MutationObserver((mutationsList, observer) => {
    for (let mutation of mutationsList) {
      if (mutation.type === "childList") {
        sidebarBox = document.querySelector(
          '#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]',
        );
        if (sidebarBox) {
          console.log("Sidebar box found by MutationObserver");
          handleSidebar(sidebarBox);
          observer.disconnect(); // Stop observing once the element is found
          break;
        }
      }
    }
  });
  observer.observe(document.body, { childList: true, subtree: true });
}
