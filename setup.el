(defvar site-head
  "<link rel='stylesheet' href='/css/style.css' type='text/css' />
  <script src='http://code.jquery.com/jquery-latest.min.js'></script>

  <link rel='stylesheet'
        href='http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/default.min.css'>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js'></script>
  <script>
   $(document).ready(function() {
       $('pre.src').each(function(i, block) {
  	 hljs.highlightBlock(block);
       });
   });
  </script>"
  )

(defvar site-preamble
  "<div id='header'>
     <h1>
       <a href='/'>λ =&gt;&gt; 函舍空间</a>
     </h1>
   </div>"
  )

(defvar site-postamble
  "<div id='footer'>&copy;Copyright by <a href='https://github.com/tennix'>Tennix</a> 2018 | Powered by <a href='https://orgmode.org'>Emacs Orgmode</a></div>"
  )

(setq org-image-actual-width '(300))
(setq org-html-htmlize-output-type nil)

(defun my-org-publish-org-sitemap-format (entry style project)
  "Custom sitemap entry formatting: add date."
  (cond ((not (directory-name-p entry))
         (format "[[file:%s][%s: %s]]"
                 entry
                 (format-time-string "%Y-%m-%d"
                                     (org-publish-find-date entry project))
                 (org-publish-find-title entry project)))
        ((eq style 'tree)
         ;; Return only last subdir.
         (file-name-nondirectory (directory-file-name entry)))
        (t entry)))

(setq org-publish-project-alist
      `(("org"
	 :base-directory "~/tennix-notes/"
	 :base-extension "org"
	 :publishing-directory "~/tennix.github.io/"
	 :publishing-function org-html-publish-to-html
	 :exclude "drafts\\|private\\|todo\\|README" ;; ignore drafts, private, todo
	 :headline-levels 3
	 :makeindex nil
	 :with-tags t
	 :recursive t
	 :auto-sitemap t
	 :sitemap-filename "index.html"
	 :sitemap-title "Tennix's Notes & Thoughts Space"
	 :sitemap-sort-files anti-chronologically
	 :sitemap-format-entry my-org-publish-org-sitemap-format
	 :section-numbers t
	 :with-toc t
	 :htmlized-source nil
	 :html-preamble ,site-preamble
	 :html-postamble ,site-postamble
	 :html-head ,site-head
	 )

	("images"
	 :base-directory "~/tennix-notes/images/"
	 :base-extension "jpg\\|gif\\|png"
	 :publishing-directory "~/tennix.github.io/images/"
	 :publishing-function org-publish-attachment)

	("css"
	 :base-directory "~/tennix-notes/css/"
	 :base-extension "css"
	 :publishing-directory "~/tennix.github.io/css/"
	 :publishing-function org-publish-attachment)

	("code"
	 :base-directory "~/tennix-notes/code/"
	 :base-extension "el\\|py\\|rs\\|c\\|conf"
	 :publishing-directory "~/tennix.github.io/code/"
	 :publishing-function org-publish-attachment)

	("notes" :components ("org" "images" "css" "code"))))


;; Ref: http://jerrypeng.me/2013/10/remove-org-html-useless-spaces/
(defadvice org-html-paragraph (before org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let* ((origin-contents (ad-get-arg 1))
         (fix-regexp "[[:multibyte:]]")
         (fixed-contents
          (replace-regexp-in-string
           (concat
            "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
    (ad-set-arg 1 fixed-contents)))
