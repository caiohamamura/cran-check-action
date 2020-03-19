# Install R
echo "\e[1mInstalling R and dependencies"
apt-get update

# Build and check
echo "\e[33m\e[1mInstalling dependencies"
Rscript -e 'install.packages(c("remotes"));if (!all(c("remotes") %in% installed.packages())) { q(status = 1, save = "no")}'
Rscript -e 'deps <- remotes::dev_package_deps(dependencies = NA);remotes::install_deps(dependencies = TRUE);if (!all(deps$package %in% installed.packages())) { message("missing: ", paste(setdiff(deps$package, installed.packages()), collapse=", ")); q(status = 1, save = "no")}'
# Check if description file exi
if [ -f DESCRIPTION ]; then
    echo "\e[33m\e[1mStart package build."
    R CMD build ./
    
    echo "\e[33m\e[1mGet package name and version from description file."
    package=$(grep -Po 'Package:(.*)' DESCRIPTION)
    version=$(grep -Po 'Version:(.*)' DESCRIPTION)
    package=${package##Package: }
    version=${version##Version: }

    echo "\e[33m\e[1mStart package check and test for ${package}_${version}"
    if [ -f "${package}_${version}.tar.gz" ]; then
        R CMD check ./"${package}_${version}.tar.gz" --as-cran
    else 
        echo "\e[31m\e[1mPackage did not build properly, no package to test."
        # exit 1 
    fi
else 
    echo "\e[31m\e[1mDESCRIPTION file does not exist."
    exit 1
fi
