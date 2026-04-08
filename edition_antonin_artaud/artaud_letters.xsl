<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei" version="2.0">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- Variables globales -->
    <xsl:variable name="project_title">The Mexico Letters of Antonin Artaud</xsl:variable>
    <xsl:variable name="editor" select="'Florent Farfouillon'"/>

    <!-- Paramètre passé par Oxygen : letter_number=1, 2 ou 3 -->
    <xsl:param name="letter_number" select="'1'"/>

    <xsl:variable name="letter1_file">letter_1.html</xsl:variable>
    <xsl:variable name="letter2_file">letter_2.html</xsl:variable>
    <xsl:variable name="letter3_file">letter_3.html</xsl:variable>


    <!-- Template du <head> HTML commun à toutes les pages -->
    <xsl:template name="html_head">
        <xsl:param name="titre"/>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title><xsl:value-of select="$titre"/></title>
            <link rel="stylesheet" href="style.css"/>
        </head>
    </xsl:template>
    <!-- Point d'entrée -->
    <xsl:template match="/">
        <xsl:call-template name="page_lettre"/>
        <!-- Index et accueil générés une seule fois depuis letter_1 -->
        <xsl:if test="$letter_number = '1'">
            <xsl:call-template name="page_personnes"/>
            <xsl:call-template name="page_lieux"/>
            <xsl:call-template name="page_accueil"/>
        </xsl:if>
    </xsl:template>

    <!-- Barre de navigation commune -->
    <xsl:template name="navbar">
        <nav>
            <a href="index.html">Accueil</a>
            <a href="{$letter1_file}">Lettre 1</a>
            <a href="{$letter2_file}">Lettre 2</a>
            <a href="{$letter3_file}">Lettre 3</a>
            <a href="persons.html">Personnes</a>
            <a href="places.html">Lieux</a>
        </nav>
    </xsl:template>

    <!-- Pied de page commun -->
    <xsl:template name="footer">
        <footer>
            <p>
                <xsl:text>Édition scientifique : </xsl:text>
                <xsl:value-of select="$editor"/>
                <xsl:text> — </xsl:text>
                <xsl:value-of select="//publicationStmt/authority"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="//publicationStmt/date/@when"/>
            </p>
        </footer>
    </xsl:template>

    <!-- Page de lettre -->
    <xsl:template name="page_lettre">
        <xsl:result-document href="letter_{$letter_number}.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:call-template name="html_head">
                    <xsl:with-param name="titre" select="concat($project_title, ' — Lettre ', $letter_number)"/>
                </xsl:call-template>
                <body>
                    <xsl:call-template name="navbar"/>
                    <main>
                        <section class="metadonnees">
                            <h2>Lettre <xsl:value-of select="$letter_number"/></h2>
                            <!-- Expéditeur et destinataire -->
                            <xsl:for-each select="//correspDesc/correspAction">
                                <p class="corresp">
                                    <xsl:choose>
                                        <xsl:when test="@type = 'sent'">
                                            <strong>Expéditeur : </strong>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <strong>Destinataire : </strong>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:value-of select="normalize-space(persName/forename)"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="normalize-space(persName/surname)"/>
                                    <xsl:if test="placeName">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="normalize-space(placeName)"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </p>
                            </xsl:for-each>
                        </section>
                        <xsl:apply-templates select="//TEI/text/body"/>
                    </main>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- Page d'accueil -->
    <xsl:template name="page_accueil">
        <xsl:result-document href="index.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:call-template name="html_head">
                    <xsl:with-param name="titre" select="$project_title"/>
                </xsl:call-template>
                <body>
                    <xsl:call-template name="navbar"/>
                    <main>
                        <header class="site-header">
                            <div class="header-text">
                                <p class="header-label">Édition numérique</p>
                                <h1>
                                    <xsl:value-of select="$project_title"/>
                                </h1>
                                <p class="header-subtitle">Correspondance avec Jean Paulhan,
                                    1935–1936</p>
                                <p class="header-desc"> Trois lettres d'Antonin Artaud adressées à
                                    Jean Paulhan, encodées en XML-TEI et éditées dans le cadre du
                                    master Technologies numériques appliquées à l'histoire (ENC –
                                    PSL). </p>
                                <div class="header-nav">
                                    <a href="letter_1.html" class="btn-lettre">Lettre 1</a>
                                    <a href="letter_2.html" class="btn-lettre">Lettre 2</a>
                                    <a href="letter_3.html" class="btn-lettre">Lettre 3</a>
                                </div>
                            </div>
                            <figure class="header-portrait">
                                <img src="Antonin_Artaud_1926.jpg"
                                    alt="Portrait d'Antonin Artaud, 1926"/>
                                <figcaption>Antonin Artaud, 1926</figcaption>
                            </figure>
                        </header>
                        <section class="index-presentation">
                            <div class="index-card">
                                <h2>Corpus</h2>
                                <p>
                                    <xsl:value-of select="count(//listPerson/person)"/>
                                    <xsl:text> personnes référencées, </xsl:text>
                                    <xsl:value-of select="count(//listPlace/place)"/>
                                    <xsl:text> lieux, 3 lettres encodées.</xsl:text>
                                </p>
                                <a href="persons.html">→ Index des personnes</a>
                                <a href="places.html">→ Index des lieux</a>
                            </div>
                            <div class="index-card">
                                <h2>Sources</h2>
                                <p>Textes publiés dans <cite>Œuvres</cite> (Gallimard, 2004).
                                    Originaux conservés à l'IMEC, fonds Paulhan.</p>
                            </div>
                            <div class="index-card">
                                <h2>Édition</h2>
                                <p>Réalisée par <xsl:value-of select="$editor"/>, ENC – PSL,
                                    2025–2026.</p>
                            </div>
                        </section>
                    </main>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- Index des personnes -->
    <xsl:template name="page_personnes">
        <xsl:result-document href="persons.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:call-template name="html_head">
                    <xsl:with-param name="titre">Index des personnes</xsl:with-param>
                </xsl:call-template>
                <body>
                    <xsl:call-template name="navbar"/>
                    <main>
                        <h1>Index des personnes</h1>
                        <p class="index-intro">
                            <xsl:value-of select="count(//listPerson/person)"/>
                            <xsl:text> personnes référencées dans l'édition.</xsl:text>
                        </p>
                        <ul class="index-list">
                            <!-- On itère sur toutes les personnes de la liste d'autorité -->
                            <xsl:for-each select="//listPerson/person">
                                <xsl:sort select="normalize-space(persName/surname)" order="ascending"/>
                                <xsl:variable name="person_id" select="@xml:id"/>
                                
                                <!-- On vérifie si la personne apparaît dans au moins une lettre -->
                                <xsl:variable name="dans_l1" select="document('letter_1.xml')//body//persName[@ref = concat('#', $person_id)]"/>
                                <xsl:variable name="dans_l2" select="document('letter_2.xml')//body//persName[@ref = concat('#', $person_id)]"/>
                                <xsl:variable name="dans_l3" select="document('letter_3.xml')//body//persName[@ref = concat('#', $person_id)]"/>
                                
                                <!-- On n'affiche l'entrée que si la personne est citée dans au moins une lettre pour éviter les noms du header qui ne sont pas à proporement parlé un enrichissement éditiorial-->
                                <xsl:if test="$dans_l1 or $dans_l2 or $dans_l3">
                                    <li id="{$person_id}" class="index-entry">
                                        
                                        <!-- Nom : cas général (surname, forename) ou nom unique (Moctezuma) car il y a eu des problèmes de lecture du nom simple qui apparaissait comme "," -->
                                        <span class="index-name">
                                            <xsl:choose>
                                                <xsl:when test="persName/surname">
                                                    <xsl:value-of select="normalize-space(persName/surname)"/>
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:value-of select="normalize-space(persName/forename)"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="normalize-space(persName)"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        
                                        <!-- Dates de vie si disponibles (pour les noms présents dans les lettres c'est toujours le cas mais on peut partir du principe que cette édition sera enrichie) -->
                                        <xsl:if test="birth/@when or death/@when">
                                            <span class="index-dates">
                                                <xsl:text> (</xsl:text>
                                                <xsl:if test="birth/@when">
                                                    <xsl:value-of select="substring(birth/@when, 1, 4)"/>
                                                </xsl:if>
                                                <xsl:text>–</xsl:text>
                                                <xsl:if test="death/@when">
                                                    <xsl:value-of select="substring(death/@when, 1, 4)"/>
                                                </xsl:if>
                                                <xsl:text>)</xsl:text>
                                            </span>
                                        </xsl:if>
                                        
                                        <!-- Liens vers les lettres où la personne est citée -->
                                        <span class="index-links">
                                            <xsl:if test="$dans_l1">
                                                <a href="letter_1.html" class="letter-link">Lettre 1</a>
                                                <xsl:text> </xsl:text>
                                            </xsl:if>
                                            <xsl:if test="$dans_l2">
                                                <a href="letter_2.html" class="letter-link">Lettre 2</a>
                                                <xsl:text> </xsl:text>
                                            </xsl:if>
                                            <xsl:if test="$dans_l3">
                                                <a href="letter_3.html" class="letter-link">Lettre 3</a>
                                            </xsl:if>
                                        </span>
                                        
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </main>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Index des lieux -->
    <xsl:template name="page_lieux">
        <xsl:result-document href="places.html" method="html" indent="yes">
            <html lang="fr">
                <xsl:call-template name="html_head">
                    <xsl:with-param name="titre">Index des lieux</xsl:with-param>
                </xsl:call-template>
                <body>
                    <xsl:call-template name="navbar"/>
                    <main>
                        <h1>Index des lieux</h1>
                        <p class="index-intro">
                            <xsl:value-of select="count(//listPlace/place)"/>
                            <xsl:text> lieux référencés dans l'édition.</xsl:text>
                        </p>
                        <ul class="index-list">
                            <xsl:for-each select="//listPlace/place">
                                <xsl:sort select="normalize-space(placeName)" order="ascending"/>
                                <xsl:variable name="place_id" select="@xml:id"/>

                                <!-- Même logique que pour les personnes on ne garde que les lieux cités dans le corps des lettres -->
                                <xsl:variable name="dans_l1" select="document('letter_1.xml')//body//placeName[@ref = concat('#', $place_id)]"/>
                                <xsl:variable name="dans_l2" select="document('letter_2.xml')//body//placeName[@ref = concat('#', $place_id)]"/>
                                <xsl:variable name="dans_l3" select="document('letter_3.xml')//body//placeName[@ref = concat('#', $place_id)]"/>

                                <xsl:if test="$dans_l1 or $dans_l2 or $dans_l3">
                                    <li id="{$place_id}" class="index-entry">
                                        <!-- Nom du lieu -->
                                        <span class="index-name">
                                            <xsl:choose>
                                                <xsl:when test="placeName">
                                                    <xsl:value-of select="normalize-space(placeName)"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="normalize-space(country)"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <!-- Liens vers les lettres où le lieu est cité -->
                                        <span class="index-links">
                                            <xsl:if test="$dans_l1">
                                                <a href="letter_1.html" class="letter-link">Lettre 1</a>
                                                <xsl:text> </xsl:text>
                                            </xsl:if>
                                            <xsl:if test="$dans_l2">
                                                <a href="letter_2.html" class="letter-link">Lettre 2</a>
                                                <xsl:text> </xsl:text>
                                            </xsl:if>
                                            <xsl:if test="$dans_l3">
                                                <a href="letter_3.html" class="letter-link">Lettre 3</a>
                                            </xsl:if>
                                        </span>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </main>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- Corps de la lettre -->
    <xsl:template match="body">
        <article class="letter-body">
            <h2 class="letter-heading">Lettre <xsl:value-of select="$letter_number"/></h2>
            <xsl:apply-templates/>
        </article>
    </xsl:template>

    <xsl:template match="div[@type = 'letter']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="ab[@type = 'displayed_text']">
        <blockquote class="displayed-text">
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>

    <xsl:template match="opener">
        <div class="opener">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="salute">
        <p class="salute">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="closer">
        <div class="closer">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="signed">
        <p class="signed">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="closer/location">
        <p class="location">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="note[@type = 'post_scriptum']">
        <p class="post-scriptum">
            <strong>P.S. </strong>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- persName avec @ref : lien vers l'index, italique si historique -->
    <xsl:template match="persName[@ref]">
        <xsl:variable name="person_id" select="replace(@ref, '#', '')"/>
        <xsl:choose>
            <xsl:when test="@type = 'historical'">
                <a href="persons.html#{$person_id}" class="persname historical">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <a href="persons.html#{$person_id}" class="persname">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- persName sans @ref (teiHeader) : texte brut -->
    <xsl:template match="persName[not(@ref)]">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- placeName avec @ref : lien vers l'index -->
    <xsl:template match="placeName[@ref]">
        <xsl:variable name="place_id" select="replace(@ref, '#', '')"/>
        <a href="places.html#{$place_id}" class="placename">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <!-- placeName sans @ref du header : texte brut -->
    <xsl:template match="placeName[not(@ref)]">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Du point de vue éditorial, j'avais d'abord placé les citations entre guillemets mais comme l'auteur dans ses manuscrits met parfois de guillemets et parfois non, ils avaient été encodés directement dans le XML et j'ai préféré ne pas en rajouter automatiquement -->
    <xsl:template match="quote">
        <span class="quote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Titres d'œuvres -->
    <xsl:template match="title">
        <cite class="title">
            <xsl:apply-templates/>
        </cite>
    </xsl:template>

    <!-- Éléments traversés sans balisage supplémentaire -->
    <xsl:template
        match="seg | date | orgName | abbr | expan | rs | term | text//forename | text//surname">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
