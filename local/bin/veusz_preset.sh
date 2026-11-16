#!/usr/bin/bash

veusz_conf_path=$HOME/.config/veusz.org/veusz.conf
# Find the line number containing importdialog_prefixcombo_HistoryCombo
line_number=$(grep -n "importdialog_prefixcombo_HistoryCombo=" $veusz_conf_path | cut -d':' -f1)

# Replace the value at that line number
if [ -n "$line_number" ]; then
  sed -i "${line_number}s/importdialog_prefixcombo_HistoryCombo=.*/importdialog_prefixcombo_HistoryCombo=\"[\'\']\"/g" $veusz_conf_path
  # echo "Replaced value at line $line_number"
else
  echo "Pattern not found in file"
fi

# Find the line number containing importdialog_prefixcombo_HistoryCombo
line_number=$(grep -n "importdialog_filenameedit_HistoryCombo=" $veusz_conf_path | cut -d':' -f1)

# Replace the value at that line number
if [ -n "$line_number" ]; then
  sed -i "${line_number}s/importdialog_filenameedit_HistoryCombo=.*/importdialog_filenameedit_HistoryCombo=\"[\'\']\"/g" $veusz_conf_path
  # echo "Replaced value at line $line_number"
else
  echo "Pattern not found in file"
fi
