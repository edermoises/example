#!/bin/bash

read -p "Qual diretorio deseja configurar o git da XP? " FOLDER
read -p "Qual branch deseja apontar os repositorios? " BRANCH

baseGitUrl="https://xpinvestimentos.visualstudio.com/ProjetoQuickBull/_git/";
repositories=( "QuickBull" "SDK" "SDK.UI" "Component.Basket" "Component.Book" "Component.BTC" "Component.Chart" "Component.ClientPanel" "Component.DOM" "Component.ForwardTicket" "Component.FullOrderHistory" "Component.LongShort" "Component.MyAccount" "Component.OptionsChain" "Component.OptionsExercise" "Component.OrderHistory" "Component.PersonalPage" "Component.QuoteSummary" "Component.ResetStockPortfolio" "Component.StockPanel" "Component.Ticket" "Component.TimeHistory" "Component.Trades" "Component.TradingVolume" "Component.TurboTicket"  "Component.Monitor" "Core" "Telemetry" "SfDatagrid" "SfListView")

function Clone
{
    echo "$1"
    git clone https://xpinvestimentos.visualstudio.com/ProjetoQuickBull/_git/$1
}

function ExecuteFetchInBranch
{
    EnterRepositoryFolder $1
    echo "Fetch command - $BRANCH - $1"
    git checkout $BRANCH
    git fetch
    git pull
    cd ..
}

function EnterRootFolder
{
    echo "Entrou na pasta $FOLDER"
    cd "$FOLDER"
}

function EnterRepositoryFolder
{
    cd "$1"
}

function CloneRepository
{
    Clone $1
    ExecuteFetchInBranch $1
}

function UpdateRepository
{
    ExecuteFetchInBranch $1
}

function StartConfigGit
{
    EnterRootFolder 
    for repository in "${repositories[@]}"
    do
        if [ -d "$repository" ]; then
            echo "Atualizando branch $repository"
            UpdateRepository $repository
        else
            echo "Clonando repositorio $repository"
            CloneRepository $repository
        fi
    done
}

StartConfigGit