%http://theoval.sys.uea.ac.uk/~nlct/latex/thesis/node7.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}

\newlength{\drop}% for my convenience

%% select a (FontSite) font by its font family ID
\newcommand*{\FSfont}[1]{\fontencoding{T1}\fontfamily{#1}\selectfont}
%% if you don’t have the FontSite fonts either \renewcommand*{\FSfont}[1]{}
%% or use your own choice of family.
%% select a (TeX Font) font by its font family ID

%%%% Additional font series macros
\makeatletter
%%%% light series
%% e.g., kernel doc, section s: line 12 or thereabouts
\DeclareRobustCommand\ltseries
{\not@math@alphabet\ltseries\relax
\fontseries\ltdefault\selectfont}
%% e.g., kernel doc, section t: line 32 or thereabouts
\newcommand{\ltdefault}{l}
%% e.g., kernel doc, section v: line 19 or thereabouts
\DeclareTextFontCommand{\textlt}{\ltseries}

%Next you need to specify what to do with any options passed to this class file. Since we don't need to define any new options for this example, we can simply pass all options on to the report class file:

%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
%Once all options have been declared, they need to be processed:

\ProcessOptions

%Now the report class needs to be loaded:

\LoadClass[a4paper,oneside]{memoir}

% Alter some LaTeX defaults for better treatment of figures:
    % See p.105 of "TeX Unbound" for suggested values.
    % See pp. 199-200 of Lamport's "LaTeX" book for details.
    %   General parameters, for ALL pages:
    \renewcommand{\topfraction}{1.0}	% max fraction of floats at top
    \renewcommand{\bottomfraction}{1.0}	% max fraction of floats at bottom
    %   Parameters for TEXT pages (not float pages):
    \setcounter{topnumber}{2}
    \setcounter{bottomnumber}{2}
    \setcounter{totalnumber}{4}     % 2 may work better
    \setcounter{dbltopnumber}{2}    % for 2-column pages
    \renewcommand{\dbltopfraction}{0.9}	% fit big float above 2-col. text
    \renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
    %   Parameters for FLOAT pages (not text pages):
    \renewcommand{\floatpagefraction}{0.7}	% require fuller float pages
	% N.B.: floatpagefraction MUST be less than topfraction !!
    \renewcommand{\dblfloatpagefraction}{0.7}	% require fuller float pages

	% remember to use [htp] or [htpb] for placement



%and the very last line of your file should have the command
%or you can load the geometry package, in which case the following line should go after \LoadClass{report}4.2:
%\RequirePackage[a4paper]{geometry}

%If you need to set additional page layout parameters such as the margin widths, then it is better to use the geometry package. For example, to set the paper size to A4 with 1 inch margins do:
%\RequirePackage[a4paper,margin=1in]{geometry}
 \def\@seccntformat#1{%
       \protect\makebox[0pt][r]{%
              \csname  the#1\endcsname\quad}}
\renewcommand{\afterpartskip}{\vfil}
%\newcommand{\part}[1]{%
%% THIS IS A VERY SIMPLIFIED VERSION
%\cleardoublepage
%% start a new recto page
%\thispagestyle{part}
%% set the page style
%\beforepartskip
%% space before Name and Number
%\printpartname\partnamenum\printpartnum
%\midpartskip
%% space after Name and Number
%\printparttitle{#1}
%% print the title
%\partpageend}
%% finish off
%\newcommand{\partpageend}{% THIS IS SIMPLIFIED
%\afterpartskip
%% ifblankpage then blank next page and restore twocolumn if necessary
%}
%\def\mypart#1#2{% 
%\par\newpage\clearpage % Page break 
%\vspace*{5cm} % Vertical shift 
%\refstepcounter{part}% Next part 
%{\centering \textbf{\Huge Part \thepart}\par}% 
%\vspace{1cm}% Vertical shift 
%{\centering \textbf{\Huge #1}\par}% 
%\vspace{2cm}% Vertical shift 
%% Some text 
%#2 \vfill\pagebreak % Fill the end of page and page break
% }
%\def\mypart#1#2{%
%  \par\break % Page break
%  \vskip .3\vsize % Vertical shift
%  \refstepcounter{part}% Next part
%  {\centering\Large Part \thepart.\par}% 
%  \vskip .1\vsize % Vertical shift 
%  % Some text
%  #2
%  \vfill\break % Fill the end of page and page break
%}

%
\renewcommand{\partnamefont}{\normalfont\huge\sffamily\scshape}
\renewcommand{\partnumfont}{\normalfont\huge\sffamily\scshape}
\renewcommand{\parttitlefont}{\normalfont\Huge\scshape} %\raggedright
\nopartblankpage

\makechapterstyle{ell_tom}{%
  \chapterstyle{default}
  \renewcommand*{\chapnumfont}{\normalfont\HUGE\sffamily}
  \renewcommand*{\chaptitlefont}{\normalfont\huge\scshape}
  \settowidth{\chapindent}{\chapnumfont 111}
  \renewcommand*{\chapterheadstart}{}
  \renewcommand*{\printchaptername}{}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{%
\begingroup
    \vspace*{\beforechapskip}%
    \begin{adjustwidth}{}{-\chapindent}%
    \hrulefill
    \smash{\rule{0.4pt}{15mm}}
    \end{adjustwidth}\endgroup
%
    \begin{adjustwidth}{}{-\chapindent}
    \hfill
    \raisebox{10mm}[0pt][0pt]{\chapnumfont \thechapter}%
                              \hspace*{1em}
    \end{adjustwidth}\vspace*{-3.0\onelineskip}}
  \renewcommand*{\printchaptertitle}[1]{%
    \vskip\onelineskip
    \raggedleft {\chaptitlefont ##1}\par\nobreak}}

\chapterstyle{ell_tom}
%\renewcommand{\@makechapterhead}[1]{%
%  \vspace*{50\p@}%
%  {\parindent \z@ \raggedright \normalfont
%    \vspace{5pt}%   % add vertical space
%    \begin{center}                              
%     \ifnum \c@secnumdepth >\m@ne
%       \huge\scshape  \thechapter % Chapter number  \@chapapp\space \thechapter  
%       \par\nobreak
%       \vskip 20\p@
%       \hrule                                        % horizontal line
%       \vskip 20\p@
%     \fi
%     \interlinepenalty\@M
     
%     \huge \scshape #1\par                         % chapter title
%    \end{center}
%    \vspace{5pt}%                                 % add vertical space
%    \nobreak
%    \vskip 40\p@
%  }}

%\renewcommand{\@makeschapterhead}[1]{%
%  \vspace*{50\p@}%
%  {\parindent \z@ \raggedright
%    \normalfont
%    \vspace{5pt}%                                 % add vertical space
%    \interlinepenalty\@M
%    \begin{center}
%     \huge \scshape #1\par                         % chapter title
%    \end{center}
%    \vspace{5pt}%                                 % add vertical space
%    \nobreak
%    \vskip 40\p@
%  }}


% \renewcommand{\@makessectionhead}[1]{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright \normalfont
%     \vspace{5pt}%   % add vertical space
%     \begin{center}                              
%      \ifnum \c@secnumdepth >\m@ne
%        \huge\scshape  \thechapter % Chapter number  \@chapapp\space \thechapter  
%        \par\nobreak
%        \vskip 20\p@
%        \hrule                                        % horizontal line
%        \vskip 20\p@
%      \fi
%      \interlinepenalty\@M
     
%      \huge \scshape #1\par                         % chapter title
%     \end{center}
%     \vspace{5pt}%                                 % add vertical space
%     \nobreak
%     \vskip 40\p@
%   }}
\pagestyle{plain}

%\setcounter{secnumdepth}{2}% alternative A
\setsecnumdepth{subsubsection}% alternative B
\setsecheadstyle{\raggedright\Large\scshape}
\setsubsecheadstyle{\large \scshape}
\setsubsubsecheadstyle{\normalsize \itshape}

\setbeforesubsecskip{-\onelineskip}
\setaftersubsecskip{\onelineskip}

%\setssubecheadstyle{\raggedright\large\scshape}
%\renewcommand{\section}{\@startsection
%{section}%                   % the name
%{1}%                         % the level
%{0mm}%                       % the indent
%{-\baselineskip}%            % the before skip
%{0.5\baselineskip}%          % the after skip
%{  % \centering
%\Large \scshape }  % the section 
%} % the style



% \renewcommand{\subsection}{\@startsection
% {subsection}%                   % the name
% {2}%                         % the level
% {0mm}%                       % the indent
% {-\baselineskip}%            % the before skip
% {0.5\baselineskip}%          % the after skip
% { \large \scshape }  % the section 
% } % the style

% \renewcommand{\subsubsection}{\@startsection
% {subsubsection}%                   % the name
% {3}%                         % the level
% {0mm}%                       % the indent
% {-\baselineskip}%            % the before skip
% {0.5\baselineskip}%          % the after skip
% {\normalsize \itshape  }  % the section 
% } % the style



% \renewcommand{\@makessectionhead}[1]{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright
%     \normalfont
%     \vspace{5pt}%                                 % add vertical space
%     \interlinepenalty\@M
%     \begin{center}
%      \huge \scshape #1\par                         % chapter title
%     \end{center}
%     \vspace{5pt}%                                 % add vertical space
%     \nobreak
%     \vskip 40\p@
%   }}

%\captiontitlefont{\small\sffamily}
%\let\caption\legend
\endinput



