<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" indent="yes" />

    <!-- Template for the root element -->
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//tei:title" /></title>
                <style>
                    .persName { color: blue; cursor: pointer; text-decoration: underline; }
                    .tooltip {
                        display: none;
                        position: absolute;
                        background-color: white;
                        border: 1px solid black;
                        padding: 5px;
                        z-index: 1000;
                    }
                </style>
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        document.querySelectorAll('.persName').forEach(function(element) {
                            element.addEventListener('click', function() {
                                let tooltip = document.getElementById('tooltip');
                                tooltip.textContent = 'Character: ' + element.textContent;
                                tooltip.style.display = 'block';
                                tooltip.style.left = (element.getBoundingClientRect().left + window.scrollX) + 'px';
                                tooltip.style.top = (element.getBoundingClientRect().bottom + window.scrollY) + 'px';
                            });
                        });
                        document.addEventListener('click', function(event) {
                            let tooltip = document.getElementById('tooltip');
                            if (!event.target.classList.contains('persName')) {
                                tooltip.style.display = 'none';
                            }
                        });
                    });
                </script>
            </head>
            <body>
                <div id="tooltip" class="tooltip"></div>
                <h1><xsl:value-of select="//tei:title" /></h1>
                <p>Author: <xsl:value-of select="//tei:author" /></p>
                <div>
                    <xsl:apply-templates select="//tei:body" />
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Template for paragraphs -->
    <xsl:template match="tei:p">
        <p><xsl:apply-templates /></p>
    </xsl:template>

    <!-- Template for personal names -->
    <xsl:template match="tei:persName">
        <span class="persName" data-name="{@xml:id}">
            <xsl:apply-templates />
        </span>
    </xsl:template>

</xsl:stylesheet>

