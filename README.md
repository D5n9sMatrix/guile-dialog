<!DOCTYPE html>
<!-- saved from url=(0071)https://www.gnu.org/software/emacs/manual/html_node/elisp/Comments.html -->
<html><!-- Created by GNU Texinfo 7.0.3, https://www.gnu.org/software/texinfo/ --><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Comments (GNU Emacs Lisp Reference Manual)</title>

<meta name="description" content="Comments (GNU Emacs Lisp Reference Manual)">
<meta name="keywords" content="Comments (GNU Emacs Lisp Reference Manual)">
<meta name="resource-type" content="document">
<meta name="distribution" content="global">
<meta name="Generator" content="makeinfo">
<meta name="viewport" content="width=device-width,initial-scale=1">

<link rev="made" href="mailto:bug-gnu-emacs@gnu.org">
<link rel="icon" type="image/png" href="https://www.gnu.org/graphics/gnu-head-mini.png">
<meta name="ICBM" content="42.256233,-71.006581">
<meta name="DC.title" content="gnu.org">
<style type="text/css">
@import url('/software/emacs/manual.css');
</style>
</head>

<body lang="en">
<div class="section-level-extent" id="Comments">
<div class="nav-panel">
<p>
Next: <a href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Programming-Types.html" accesskey="n" rel="next">Programming Types</a>, Previous: <a href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Special-Read-Syntax.html" accesskey="p" rel="prev">Special Read Syntax</a>, Up: <a href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Lisp-Data-Types.html" accesskey="u" rel="up">Lisp Data Types</a> &nbsp; [<a href="https://www.gnu.org/software/emacs/manual/html_node/elisp/index.html#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Index.html" title="Index" rel="index">Index</a>]</p>
</div>
<hr>
<h3 class="section" id="Comments-1">2.3 Comments</h3>
<a class="index-entry-id" id="index-comments"></a>
<a class="index-entry-id" id="index-_003b-for-commenting"></a>

<p>A <em class="dfn">comment</em> is text that is written in a program only for the
sake of humans that read the program, and that has no effect on the
meaning of the program.  In Lisp, an unescaped semicolon (‘<samp class="samp">;</samp>’)
starts a comment if it is not within a string or character constant.
The comment continues to the end of line.  The Lisp reader discards
comments; they do not become part of the Lisp objects which represent
the program within the Lisp system.
</p>
<p>The ‘<samp class="samp">#@<var class="var">count</var></samp>’ construct, which skips the next <var class="var">count</var>
characters, is useful for program-generated comments containing binary
data.  The Emacs Lisp byte compiler uses this in its output files
(see <a class="pxref" href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Byte-Compilation.html">Byte Compilation</a>).  It isn’t meant for source files, however.
</p>
<p>See <a class="xref" href="https://www.gnu.org/software/emacs/manual/html_node/elisp/Comment-Tips.html">Tips on Writing Comments</a>, for conventions for formatting comments.
</p>
</div>





</body></html>