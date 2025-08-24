# Lucian-Academy

Automates Lucian Academy with practise bots, submission and assignment handling.  I wrote the algorithms in SWI-Prolog.

See <a href="https://github.com/luciangreen/Text-to-Breasonings">Daily Regimen</a> for scripts to run Lucian Academy and help meditate.

* combophil_alg_log.pl - helps record writing up to a number of algorithms per chapter file
* combophil_alg_log.txt - data file for combophil_alg_log.pl
* la_com_bot_prep.txt - paste file into Terminal each to create, maintain bots
* combophil_grammar_logic_to_alg.pl - used by la_com_bot_prep.txt to create bots
* folders.pl - data file containing Lucian's philosophy files
* grad_student_numbers.txt - data file containing graduated student data
* la_com_marks.pl - helps mark assignments, used by la_com_submit.pl 
* la_com_submit.pl - helps student submit assignments (on web)
* la_com1.pl - submits and manages assignments of practise bots
* luciansphilosophy.txt - File to expand with Algorithm-Writer-with-Lists/grammar_logic_to_alg_random.pl (see <a href="https://github.com/luciangreen/Daily-Regimen">Daily Regimen</a>).
* short_essay_helper3_agps.pl - version of essay helper to write essays, used by la_com1.pl
* student_numbers.txt - data file for student data
* wrap_sources.pl - adds reference data (i.e. Title) to files (named "Department by Lucian Green Title") from sources and places them in sources1, for use by essay helper.
* wrap_sources2.pl - adds reference data (i.e. Title) to files (named "Title") from sources and places them in sources1, for use by essay helper.


# Getting Started

Please read the following instructions on how to install the project on your computer for automating the Lucian Academy.

# Prerequisites

* Use a search engine to find the Homebrew (or other) Terminal install command for your platform and install it, and search for the Terminal command to install swipl using Homebrew and install it or download and install SWI-Prolog for your machine at <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a>.

* You may need to install gawk using Homebrew.

* Install <a href="https://github.com/soimort/translate-shell">Translation Shell</a> on Mac, etc.
Change line in
```
culturaltranslationtool/ctt2.pl
trans_location("../../../gawk/trans").
```
to correct location of <a href="https://github.com/soimort/translate-shell">trans</a>.

# Mac, Linux and Windows (with Linux commands installed): Prepare to run swipl

* In Terminal settings (Mac), make Bash the default shell:

```
/bin/bash
```

* In Terminal, edit the text file `~/.bashrc` using the text editor Nano:

```
nano ~/.bashrc
```

* Add the following to the file `~/.bashrc`:

```
export PATH="$PATH:/opt/homebrew/bin/"
```

* Check if `usr/local/bin` exists

```
ls -ld /usr/local/bin
```

* Create the directory if missing

```
sudo mkdir -p /usr/local/bin
```

* Link to swipl in Terminal

```
sudo ln -s /opt/homebrew/bin/swipl /usr/local/bin/swipl
```

# 1. Install manually

* Download:
* <a href="https://github.com/luciangreen/Lucian-Academy">this repository</a>
* <a href="https://github.com/luciangreen/listprologinterpreter">listprologinterpreter</a>
* <a href="https://github.com/luciangreen/Languages">Languages</a>
* <a href="https://github.com/luciangreen/culturaltranslationtool">Cultural Translation Tool</a>. Requires Translation Shell (you may need to install gawk using Homebrew. Install <a href="https://github.com/soimort/translate-shell">Translation Shell</a> on Mac, etc.
Change line in culturaltranslationtool/ctt2.pl
`trans_location("../../../gawk/trans").` to correct location of <a href="https://github.com/soimort/translate-shell">trans</a>).
* <a href="https://github.com/luciangreen/Algorithm-Writer-with-Lists">Algorithm-Writer-with-Lists</a>
* <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings</a>.  (Caution: Before running texttobr, think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.  Follow instructions in <a href="https://github.com/luciangreen/Text-to-Breasonings/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems).
* <a href="https://github.com/luciangreen/mindreader">mindreader</a>

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
mkdir GitHub
cd GitHub/
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","Lucian-Academy").
../
halt.
```

# Running

* In Shell:
`cd Lucian-Academy`
`swipl`

# combophil_alg_log

* Helps write algorithms for philosophies, keeping a tally of the number of algorithms written per file, where the algorithm stops asking for algorithms for files where the tally is equal to a set number, e.g. 4.

* To run:
```
['combophil_alg_log.pl'].
combophil_alg_log.
```

```
?- combophil_alg_log.
["Fundamentals of Meditation and Meditation Indicators","FUNDAMENTALS OF MEDITATION by Lucian Green Hours Prayer 1 of 4.txt",0,algorithms,"8.    I prepared to endorse Nietzsche’s brilliance.  I did this by writing Alexius Meinong’s probable comments on the Medicine blog.  First, I called it Anarchy 3.  Second, I liked brilliance.  Third, I liked Nietzsche’s brilliance.  In this way, I prepared to endorse Nietzsche’s brilliance by writing Alexius Meinong’s probable comments on the Medicine blog."]

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

* Make sure Text-to-Breasonings/brdict1.txt has breasonings from the folders (see <a href="https://github.com/luciangreen/Text-to-Breasonings">instructions to run Text-to-Breasonings</a>).

* Paste the contents of `la_com_bot_prep.txt` into Terminal when in the Lucian-Academy folder.



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
See the first image asking for name, student number, course, essay topic and file contents from <a href="https://github.com/luciangreen/Essay-Helper">short_essay_helper.pl</a>, the second image notifying that "Lucian, you have earned the mark, 66 for the topic Computational English Argument in the course Computational English on 15/2/2021 at 23:18.", the third image asking for name and student number to generate a student number and the fourth image notifying that "The email address "lg@me.com" for "Lucian" has the student number "1".".

<img width="453" alt="Screen Shot 2021-02-15 at 10 43 56 pm" src="https://user-images.githubusercontent.com/15845542/107942470-67839980-6fdf-11eb-84ee-7a503cf05dff.png">

<img width="958" alt="Screen Shot 2021-02-15 at 11 18 59 pm" src="https://user-images.githubusercontent.com/15845542/107945913-6739cd00-6fe4-11eb-8401-eba065fd4e9a.png">

<img width="444" alt="Screen Shot 2021-02-15 at 10 43 49 pm" src="https://user-images.githubusercontent.com/15845542/107942479-6b172080-6fdf-11eb-9c21-124fc0d6a27f.png">

<img width="525" alt="Screen Shot 2021-02-15 at 11 19 29 pm" src="https://user-images.githubusercontent.com/15845542/107945904-643edc80-6fe4-11eb-92ee-89b3af57e6b8.png">

* This web site uses a different student data file from `la_com1.pl`.


# la_com1

* Generates and records completion of practise essays.  A coin is tossed for a new student to come, and for each old student to complete an assignment.  There IS breasoning involved, so please see <a href="https://github.com/luciangreen/Text-to-Breasonings/blob/master/Instructions_for_Using_texttobr(2).pl.txt">text to breasonings safety tips</a>.

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

# Extra Books

* <a href="https://lucianspedagogy.blogspot.com/2020/03/notebook-25-page-images.html">Notebook 25</a>

# Versioning

We will use SemVer for versioning.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
