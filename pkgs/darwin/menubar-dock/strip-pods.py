#!/usr/bin/env python3
"""Strip the CocoaPods integration from joaquinpiedracueva/menubar-dock.

The upstream xcodeproj was authored for Xcode IDE only and references pod
integration (manifest check build phases, baseConfigurationReference xcconfig
files, Pods_*.framework link refs) that require `pod install` to satisfy. The
Podfile declares zero pods, so the integration is dead weight — strip it.

Also injects SUPPORTED_PLATFORMS = macosx; into every buildSettings block
(scheme validation in Xcode 26+ requires it) and replaces the broken shared
scheme with one that targets the MenuBarDock target by name.
"""
import os
import re
import sys


def patch_pbxproj(path):
    with open(path) as f:
        s = f.read()

    # Drop `[CP] Check Pods Manifest.lock` build phases (with their trailing
    # comma) — these script phases need Pods/Manifest.lock, which only exists
    # after `pod install`.
    s = re.sub(
        r"\s*[A-F0-9]{24} /\* \[CP\] Check Pods Manifest\.lock \*/,\n",
        "",
        s,
    )

    # Drop the orphaned PBXShellScriptBuildPhase blocks for those phases.
    s = re.sub(
        r"\s*[A-F0-9]{24} /\* \[CP\] Check Pods Manifest\.lock \*/ = \{\n.*?^\t\t\};",
        "",
        s,
        flags=re.DOTALL | re.MULTILINE,
    )

    # Drop `baseConfigurationReference = ...Pods-*.xcconfig;` lines — they
    # point at xcconfig files that don't exist without `pod install`.
    s = re.sub(
        r"\s*baseConfigurationReference = [A-F0-9]{24} /\* Pods-[^ ]+\.xcconfig \*/;\n",
        "\n",
        s,
    )

    # Drop PBXBuildFile entries for Pods_* framework references (the wrappers
    # that pull the framework into a target's Frameworks build phase).
    s = re.sub(
        r"\s*[A-F0-9]{24} /\* Pods_[A-Za-z]+\.framework in Frameworks \*/ = \{isa = PBXBuildFile; fileRef = [A-F0-9]{24} /\* Pods_[A-Za-z]+\.framework \*/; \};",
        "",
        s,
    )

    # Drop PBXFileReference entries for Pods_* frameworks (the framework file
    # refs themselves).
    s = re.sub(
        r"\s*[A-F0-9]{24} /\* Pods_[A-Za-z]+\.framework \*/ = \{isa = PBXFileReference; explicitFileType = wrapper\.framework; includeInIndex = 0; path = Pods_[A-Za-z]+\.framework; sourceTree = BUILT_PRODUCTS_DIR; \};",
        "",
        s,
    )

    # Drop Pods_*.framework references inside PBXFrameworksBuildPhase and
    # PBXGroup children lists (the bare UUID references).
    s = re.sub(
        r"\s*[A-F0-9]{24} /\* Pods_[A-Za-z]+\.framework(?: in Frameworks)? \*/,",
        "",
        s,
    )

    # Inject SUPPORTED_PLATFORMS = macosx; into every buildSettings block.
    def patch_settings_block(match):
        block = match.group(0)
        if "SUPPORTED_PLATFORMS" in block:
            return block
        return block.replace(
            "buildSettings = {",
            "buildSettings = {\n\t\t\t\tSUPPORTED_PLATFORMS = macosx;",
            1,
        )

    s = re.sub(r"buildSettings = \{[^}]*\};", patch_settings_block, s, flags=re.DOTALL)

    with open(path, "w") as f:
        f.write(s)


SCHEME_XML = """<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "2620"
   version = "1.3">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "38412EFB222B3E2F00D3FA0C"
               BuildableName = "MenuBarDock.app"
               BlueprintName = "MenuBarDock"
               ReferencedContainer = "container:MenuBarDock.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
</Scheme>
"""


def write_scheme(xcodeproj_dir):
    # The shared scheme (`Menu Bar Dock.xcscheme`) references "Menu Bar Dock"
    # / "Menu Bar Dock.xcodeproj" — names that don't match the actual target
    # (`MenuBarDock`) or project (`MenuBarDock.xcodeproj`). Xcode 26 rejects
    # this as "scheme not configured for the build action". Replace it with
    # a working scheme that targets `MenuBarDock`.
    scheme_dir = os.path.join(xcodeproj_dir, "xcshareddata", "xcschemes")
    os.makedirs(scheme_dir, exist_ok=True)
    scheme_path = os.path.join(scheme_dir, "MenuBarDock.xcscheme")
    with open(scheme_path, "w") as f:
        f.write(SCHEME_XML)


if __name__ == "__main__":
    xcodeproj_dir = sys.argv[1]
    patch_pbxproj(os.path.join(xcodeproj_dir, "project.pbxproj"))
    write_scheme(xcodeproj_dir)
