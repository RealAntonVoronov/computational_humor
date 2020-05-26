Run everything with command ./run-everything source_language target_language bpe_size

Results will be formed  .res/ folder

Temporary files are stored in ./tmp folder. But only output of pre last operations are stored. In order to store them all need to change last lines in every command.

Works end-to-end but need to be cautious with languages where nonalphabetic symbols are used, the module 'different-lengths' might work incorrectly with those languages.