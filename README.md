# Lucian-Academy

Automates Lucian Academy with practise bots, submission and assignment handling.  I wrote the algorithms in SWI-Prolog

* combophil_alg_log.pl - helps record writing up to a number of algorithms per chapter file
* combophil_alg_log.txt - data file for combophil_alg_log.pl
* combophil_grammar_logic_to_alg-vps.txt - paste file into Terminal each to create, maintain bots
* combophil_grammar_logic_to_alg.pl - used by combophil_grammar_logic_to_alg-vps.txt to create bots
* folders.pl - data file containing Lucian's philosophy files
* grad_student_numbers.txt - data file containing graduated student data
* la_com_marks.pl - helps mark assignments, used by la_com_submit.pl 
* la_com_submit.pl - helps student submit assignments (on web)
* la_com1.pl - submits and manages assignments of practise bots
* luciansphilosophy.txt - most of Lucian's philosophy in one file
* short_essay_helper3_agps.pl - version of essay helper to write essays, used by la_com1.pl
* student_numbers.txt - data file for student data
* wrap_sources.pl - adds reference data (i.e. Title) to files (named "Department by Lucian Green Title") from sources and places them in sources1, for use by essay helper.
* wrap_sources2.pl - adds reference data (i.e. Title) to files (named "Title") from sources and places them in sources1, for use by essay helper.


# Getting Started

Please read the following instructions on how to install the project on your computer for automating the Lucian Academy.

# Prerequisites

* <a href="https://github.com/luciangreen/listprologinterpreter">listprologinterpreter</a>
* <a href="https://github.com/luciangreen/Languages">Languages</a>
* <a href="https://github.com/luciangreen/culturaltranslationtool">Cultural Translation Tool</a>. Requires Translation Shell (you may need to install gawk using Homebrew. Install <a href="https://github.com/soimort/translate-shell">Translation Shell</a> on Mac, etc.
Change line in culturaltranslationtool/ctt.pl
`concat_list(["../../../trans ",FromLang,":",ToLang," '",Input1,"'"],F),` to correct location of <a href="https://github.com/soimort/translate-shell">trans</a>).
* <a href="https://github.com/luciangreen/Algorithm-Writer-with-Lists">Algorithm-Writer-with-Lists</a>
* <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings</a>.  (Caution: Before running texttobr, think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.  Follow instructions in <a href="https://github.com/luciangreen/Text-to-Breasonings/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems).
* <a href="https://github.com/luciangreen/mindreader">mindreader</a>


# Installation from List Prolog Package Manager (LPPM)

* Optionally, you can install from LPPM by installing <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine, downloading the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>,
```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
```
loading LPPM with `['lppm'].` then installing the package by running `lppm_install("luciangreen","Lucian-Academy").`.

# Installing

* Please download and install SWI-Prolog for your machine at https://www.swi-prolog.org/build/.


# combophil_alg_log

* Helps Lucian write algorithms for philosophies, keeping a tally of the number of algorithms written per file.

* To run:
```
['combophil_alg_log.pl'].
combophil_alg_log.
```

```
?- combophil_alg_log.                                                           ["Fundamentals of Meditation and Meditation Indicators","FUNDAMENTALS OF MEDITATION by Lucian Green Hours Prayer 1 of 4.txt",0,algorithms,"8.    I prepared to endorse Nietzsche’s brilliance.  I did this by writing Alexius Meinong’s probable comments on the Medicine blog.  First, I called it Anarchy 3.  Second, I liked brilliance.  Third, I liked Nietzsche’s brilliance.  In this way, I prepared to endorse Nietzsche’s brilliance by writing Alexius Meinong’s probable comments on the Medicine blog."]

Algorithm? (y/n): 
|: y
["Computational English","COMPUTATIONAL ENGLISH by Lucian Green Computational English Argument 1 of 4.txt",0,algorithms,"8.    I prepared to calculate the used space in the house in the short story.  I did this by calculating the space complexity in Computational English.  First, I counted the number of characters of space that the short story’s world was in length.  Second, I skipped counting the number of characters of space that the short story’s world, where this space was revisited, in length.  Third, I summed only the cumulative number of characters of space that the short story’s world was in length.  In this way, I prepared to calculate the used space in the house in the short story by calculating the space complexity in Computational English."]

Algorithm? (y/n): 
|: n
true.
```

In the above, only the first paragraph's tally is increased, after entering y and n exits the program.  To skip a paragraph and try a new paragraph, re-run the algorithm.


# combophil_grammar_logic_to_alg-vps

* Run daily to maintain bots.

* Make sure Text-to-Breasonings/brdict1.txt has breasonings from luciansphilosophy.txt (see <a href="https://github.com/luciangreen/Text-to-Breasonings">instructions to run Text-to-Breasonings</a>).

* Paste the contents of `combophil_grammar_logic_to_alg-vps.txt` into Terminal when in the Lucian-Academy folder.



# la_com_submit

* Helps student submit assignments (on the web).

* To run:
```
['la_com_submit.pl'].
la_com_start_server(8000).
```

* Go to:
```
http://localhost:8000/
http://localhost:8000/generate_student_number
```
See the first image asking for name, student number, course, essay topic and file contents from <a href="https://github.com/luciangreen/Essay-Helper">short_essay_helper.pl</a> and the second image asking for name and student number to generate a student number.
<img width="453" alt="Screen Shot 2021-02-15 at 10 43 56 pm" src="https://user-images.githubusercontent.com/15845542/107942470-67839980-6fdf-11eb-84ee-7a503cf05dff.png">
<img width="444" alt="Screen Shot 2021-02-15 at 10 43 49 pm" src="https://user-images.githubusercontent.com/15845542/107942479-6b172080-6fdf-11eb-9c21-124fc0d6a27f.png">


* This web site uses a different student data file from `la_com1.pl`.


# la_com1

* Generates and records completion of practise essays.  A coin is tossed for a new student to come, and for each old student to complete an assignment.  There is no breasoning involved.

* The number of possible students to choose from, 1000, may be edited in:
```
new_student_number(N) :-
	random(X),N is ceiling(1000*X),!.
```

in `la_com1.pl`.

To run:
```
['la_com1.pl'].
la_com1.
```


# wrap_sources and wrap_sources2

* `wrap_sources.pl` adds reference data (i.e. Title) to files (named "Department by Lucian Green Title") from sources and places them in sources1, for use by essay helper.

* `wrap_sources2.pl` adds reference data (i.e. Title) to files (named "Title") from sources and places them in sources1, for use by essay helper.

* To run:
```
['wrap_sources.pl']
wrap_sources.
```
or
```
['wrap_sources2.pl']
wrap_sources.
```

# Versioning

We will use SemVer for versioning.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
