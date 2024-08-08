// ==UserScript==
// @name           collapse_sideberry
// @version        0.0.1
// @description    dynamically collapses sidebar if the sidebarcommand is sideberry
// ==/UserScript==

const extendSidebarBox = (sidebarBox, sidebar) => {
  sidebarBox.style.width = '250px';
  sidebar.style.width = '250px';
};

const resetSidebarBox = (sidebarBox) => {
  sidebarBox.style.position = 'absolute';
  sidebarBox.style.right ='0px';
  sidebarBox.style.width = '30px';
  sidebarBox.style.zIndex = '1';
  sidebarBox.style.minWidth = 'unset';
  sidebarBox.style.transition = 'all 0.2s ease-in-out';
};

const handleSidebar = (sidebarBox) => {
  if (!sidebarBox) {
    console.log("Sidebar box not found");
    return;
  }

  sidebarBox.style.height = '100vh';

  const sidebar = sidebarBox.querySelector('#sidebar');
  if (!sidebar) {
    console.log("Sidebar not found inside the sidebar box");
    return;
  }

  sidebarBox.addEventListener('mouseenter', () => extendSidebarBox(sidebarBox, sidebar));
  sidebarBox.addEventListener('mouseleave', () => resetSidebarBox(sidebarBox));
  sidebarBox.addEventListener('focusin', () => extendSidebarBox(sidebarBox, sidebar));
  sidebarBox.addEventListener('focusout', () => resetSidebarBox(sidebarBox));

  window.addEventListener('keydown', (e) => {
    if (e.key === 'Control') {
      setTimeout(() => {
          extendSidebarBox(sidebarBox, sidebar);
      }, 25);
    }
  });

  window.addEventListener('keyup', (e) => {
    if (e.key === 'Control') {
      setTimeout(() => {
          resetSidebarBox(sidebarBox, sidebar);
      }, 25);
    }
  });
};

// Try to find the sidebar box initially
let sidebarBox = document.querySelector('#main-window:not([extradragspace="true"]) #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:not([hidden])');

if (sidebarBox) {
  handleSidebar(sidebarBox);
} else {
  console.log("Sidebar box not found on initial load, setting up MutationObserver");
  // Use MutationObserver to watch for sidebar dynamically added
  const observer = new MutationObserver((mutationsList, observer) => {
    for (let mutation of mutationsList) {
      if (mutation.type === 'childList') {
        sidebarBox = document.querySelector('#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]');
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
};
