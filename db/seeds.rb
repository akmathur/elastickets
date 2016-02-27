# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

projects = Project.create([
                           {name: 'Turbo sheet',
                             description: "Spreadsheet program to maintain your data"},
                           {name: 'Power write',
                             description: "Text editor for the snappy fingered"},
                           {name: 'Super backup',
                             description: "Smart backup program"},
                           {name: 'Shiny tunes',
                             description: "Play some shoothing music to calm your nerves"}
                          ])

Ticket.create([
               {project: projects.first,
                 title: "cannot bold the header line in the spreadsheet",
                 description: "trying to bold the header line from top menu or contextual menu has no effect"},
               {project: projects.first,
                 title: "opening the spreadsheet is slow",
                 description: "opening a spreadsheet with more than 1 sheet, takes several minutes"},
               {project: projects[1],
                 title: "unformatting does not work",
                 description: "if I change the font on selected text, then try to undo it back to the original font, it does not work"},
               {project: projects[3],
                 title: "sorting the songs by artist does not work",
                 description: "when I try to sort songs by artist, it does not show my favourite artists at the top"}
              ])
