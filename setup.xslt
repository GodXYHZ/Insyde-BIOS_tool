<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
<xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
<xsl:output method="xml" encoding="iso-8859-1"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";
  doctype-pubilc="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
-->
<xsl:output method="xml"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes" /><!--<xsl:param name="param1" />-->
<xsl:template match="/Root">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <!-- It may not work immediatly on IE -->
  <meta http-equiv="Pragma" content="no-cache"/>
  <!-- Same as above line -->
  <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate"/>
  <!-- Set web page expiration time is 0, ie is -1 -->
  <meta http-equiv="Expires" content="-1"/>
  <meta http-equiv="X-Content-Type-Options" content="nosniff"/>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  
  <link rel="stylesheet" type="text/css" href="CssStyle/Common.css" />
  <link rel="stylesheet" type="text/css" href="CssStyle/PopupWin.css" />
  <link rel="stylesheet" type="text/css" href="CssStyle/Setup.css" />
  <title>BIOS Settings Migration</title>
</head>

<body>
  <div id="TopFrame">
    <div id="TopFrameCont">
      <span id="TopBoxLeft">
<!-- 
        <div id="InsydeLogo"><span><a href="index.html"><img src="Images/InsydeLogo.png" /></a></span></div>
-->
        <div id="InsydeLogo"><span><img src="Images/InsydeLogo.png" /></span></div>
      </span><!-- TopBoxLeft -->
      <span id="TopBoxRight">
        <div id="AdminBar"></div>
      </span><!-- TopBoxRight -->
      <span class="ClearBoth"></span>
    </div>
  </div><!-- TopFrame -->
  
  <div id="MidFrame">
    <div id="MainFrame">
      <div id="MainFrameTopBorder">
        <span class="MainFrameCorner MainFrameCornerLeft"></span>
        <span class="MainFrameCorner MainFrameCornerRight"></span>
        <span class="ClearBoth"></span>
      </div><!-- MainFrameTopBorder -->
      
      <span id="MenuList">
        <div class="TreeNode" run="run">
          <div class="TreeTitle">BIOS Settings Migration</div>
          <div class="SubMenu" style="">
            <xsl:if test="Formset[@name = 'Main']">
              <span id="MainLink" class="MenuLink MenuLinkField SubTreeNode">Main</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Advanced']">
              <span id="AdvancedLink" class="MenuLink MenuLinkField SubTreeNode">Advanced</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Boot']">
              <span id="BootLink" class="MenuLink MenuLinkField SubTreeNode">Boot</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Power']">
              <span id="PowerLink" class="MenuLink MenuLinkField SubTreeNode">Power</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Server']">
              <span id="ServerLink" class="MenuLink MenuLinkField SubTreeNode">Server</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Security']">
              <span id="SecurityLink" class="MenuLink MenuLinkField SubTreeNode">Security</span>
            </xsl:if>
            <xsl:if test="Formset[@name='Exit']">
              <span id="ExitLink" class="MenuLink MenuLinkField SubTreeNode">Exit</span>
            </xsl:if>
          </div><!-- SubMenu -->
        </div>      
      </span><!-- MenuList -->
      
      <span id="MainContent" class="ContPage" style="display: inline-block;">
          <div id="InnerFrame" class="" style="">
        
            <div id="InfoBody" class="" style="">
              <form id="DataForm" method="post">
              <!--
                <input type="hidden" id="FileGenTime" name="FileGenTime" value="" />
              -->  
                <div id="StdBody">
                
                  <div id="MainInfo" class="FormFrame" style="display: none">
                  
                    <div style="height: 60px;">
                      <div id="Systime" class="">
                        <span class="TimeTitle">System Date</span>
                        <span id="SystemDate" class="TimeContentField">Loading...<img src="Images/loading.gif" height="24" width="24" /></span>
                        <span class="TimeTitle">System Time</span>
                        <span id="SystemTime" class="TimeContentField">Loading...<img src="Images/loading.gif" height="24" width="24" /></span>
                      </div><!-- Systime -->
                      <div id="EditSystime" style="display: none">
                        <span class="TimeTitle">System Date</span>
                        <span class="TimeContentField">
						<!--
                          <input id="Month" name="Month" type="text" size="2" maxlength="2" value="" style="width: 40px" />/
                          <input id="Day" name="Day" type="text" size="2" maxlength="2" value="" style="width: 40px" />/
                          <input id="Year" name="Year" type="text" size="4" maxlength="4" value="" style="width: 80px" />
                        -->
						</span>
                        <span class="TimeTitle">System Time</span>
                        <span class="TimeContentField">
						<!--
                          <input id="Hour" name="Hour" type="text" size="2" maxlength="2" value="" style="width: 40px" />:
                          <input id="Minute" name="Minute" type="text" size="2" maxlength="2" value="" style="width: 40px" />:
                          <input id="Second" name="Second" type="text" size="2" maxlength="2" value="" style="width: 40px" />
                        -->
						</span>
                      </div><!-- EditSystime -->
                    </div>
                    
                    <xsl:for-each select="Formset/Form[@name='Main']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage">
                            <img src="Images/Triangle.png" height="16" />
                          </span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
  -->
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                  </div><!-- End of MainInfo -->
                  
                  <div id="AdvancedInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Advanced']/*">
  <!--
                      <xsl:if test="current()[name()='Ref' and @exp='']">
                      <div class="Row TxtRow">
                        <span class="ToPopupTitle">
                          <xsl:attribute name="fid">
                            <xsl:value-of select="@fid"/>
                          </xsl:attribute>
                          <xsl:value-of select="current()/Pmt"/>
                        </span>
                      </div>
                      </xsl:if>
  -->
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage">
                            <img src="Images/Triangle.png" height="16" />
                          </span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
  -->
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <xsl:value-of select="Help"/>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                  </div><!-- End of AdvancedInfo -->

                  <xsl:if test="Formset[@name='Boot']">
                  <div id="BootInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Boot']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage">
                            <img src="Images/Triangle.png" height="16" />
                          </span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
  -->
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                    <div class="ClearBoth"></div><br />
                  
                    <!-- Boot order -->
                    <div id="BootOrderTable">
                      <div id="BootOrderLoading">Loading Boot Devices ...<img src="Images/loading.gif" height="24" width="24" /></div>
                      <div id="BootOrderContent" style="display: none">
                      <xsl:for-each select="Formset[@name='BootOrder']/Form/*">
                        <xsl:variable name="SelectedFormSet" select="../../@name" />
                        <xsl:variable name="SelectedFormId" select="../@fid" />
                        <span class="BootDeviceRow">
                          <xsl:attribute name="idx">
                            <xsl:value-of select="@order"/>
                          </xsl:attribute>
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="current()"/></span>
                          <span class="ContentField">
                            <input class="BootOrder" type="hidden">
                              <xsl:attribute name="name">BootOrder-<xsl:value-of select="@idx"/></xsl:attribute>
                              <xsl:attribute name="order"><xsl:value-of select="@order"/></xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@order"/></xsl:attribute>
                            </input>
                            <span class="BootOrderUp BootOrderControl"><img src="Images/UpPic.png" height="18" /></span>
                            <span class="BootOrderDown BootOrderControl"><img src="Images/DownPic.png" height="18" /></span>
                            <span class="ClearBoth"></span>
                          </span><!-- ContentField -->
                          <div class="ClearBoth"></div>
                        </span><!-- BootDeviceRow -->
                        <div class="ClearBoth"></div>
                      </xsl:for-each>
                      </div>
                      <br />
                    </div><!-- BootOrderTable -->
                                        
                  </div><!-- End of BootInfo -->
                  </xsl:if>

                  <xsl:if test="Formset[@name='Power']">
                  <div id="PowerInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Power']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <br />
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- <br /> -->

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage">
                            <img src="Images/Triangle.png" height="16" />
                          </span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                  </div><!-- End of PowerInfo -->
                  </xsl:if>

                  <div id="ServerInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Server']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            <div class="ClearBoth"></div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage"><img src="Images/Triangle.png" height="16" /></span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                  </div><!-- End of ServerInfo -->

                  <div id="SecurityInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Security']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>
                        <xsl:when test="current()[name()='Subtitle']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              
                              <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                            </div>
                            </xsl:when>

                            <xsl:when test="position() != 1 and position() != 2">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="Pmt != '' and Pmt != ' '">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                              <span class="ContentField"><xsl:value-of select="Cont"/></span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                            <div class="Row TxtRow">
                              &#160;
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->
                        
                        <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                        <div class="Row TxtRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          
                          <span class="TriangleImage">
                            <img src="Images/Triangle.png" height="16" />
                          </span>
                          <span class="ToPopupTitle">
                            <xsl:attribute name="fid">
                              <xsl:value-of select="@fid"/>
                            </xsl:attribute>
                            <xsl:value-of select="current()/Pmt"/>
                          </span>
                          
                          <!--
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                          </span>
                          -->
                        </div>
                        </xsl:when><!-- Ref -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
  -->
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="type">select</xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
  <!--                  
                    <div class="FormSection" style="">
                      <div class="FormSectionTitle" style="">Change Supervisor Password</div>
                      <div class="FormSectionContent" style="display: none">
                        <span class="PasswordField">Please type in your new password: </span><input type="password" name="SNewPwd" size="16" /><br />
                        <span class="PasswordField">Please confirm your new password: </span><input type="password" name="SConfirmPwd" size="16" />
                        <span class="ClearBoth"></span>
                      </div>
                    </div>
  -->
                    <!-- End of FormSection -->

  <!--                  
                    <div class="FormSection" style="">
                      <div class="FormSectionTitle" style="">Change User Password</div>
                      <div class="FormSectionContent" style="display: none">
                        <span class="PasswordField">Please type in your new password: </span><input type="password" name="UNewPwd" size="16" /><br />
                        <span class="PasswordField">Please confirm your new password: </span><input type="password" name="UConfirmPwd" size="16" />
                        <span class="ClearBoth"></span>
                      </div>
                    </div>
  -->
                    <!-- End of FormSection -->
                  </div><!-- End of SecurityInfo -->

                  <div id="ExitInfo" class="FormFrame" style="display: none">
                    <xsl:for-each select="Formset/Form[@name='Exit']/*">
                      <xsl:variable name="SelectedFormSet" select="../../@name" />
                      <xsl:variable name="SelectedFormId" select="../@fid" />
                      <xsl:choose>

                        <xsl:when test="current()[name()='Txt']">
                          <xsl:choose>
                            <xsl:when test="current()[Pmt='Save Changes and Exit' or Pmt='Exit Saving Changes']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="1" exit="1" >
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="current()[Pmt='Discard Changes and Exit' or Pmt='Exit Discarding Changes']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="2" exit="1">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
<!--                            
                            <xsl:when test="current()[Pmt='Save Changes' or Pmt='Save Change Without Exit']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="3" exit="0">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
-->                            
                            <xsl:when test="current()[Pmt='Discard Changes']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="4" exit="0">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="current()[Pmt='Load Optimal Defaults']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="5" exit="0">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="current()[Pmt='Load Customized Defaults' or Pmt='Load Custom Defaults']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="6" exit="6">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
                            
                            <xsl:when test="current()[Pmt='Save Customized Defaults' or Pmt='Save Custom Defaults']">
                            <div class="Row TxtRow">
                              <xsl:attribute name="exp">
                                <xsl:value-of select="@exp"/>
                              </xsl:attribute>
                              <xsl:attribute name="rid">
                                <xsl:value-of select="@rid"/>
                              </xsl:attribute>
                              <div class="ExitBtn TitleField" funnum="7" exit="0">
                                <span><xsl:value-of select="Pmt"/></span>
                              </div>
                              <span class="HelpField" style="display: none">
                                <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                                <div class="HelpPopMsg">&#160;</div>
                              </span>
                            </div>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:when><!-- Txt -->

                        <xsl:when test="current()[name()='Numeric']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[Pmt='' or Pmt=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>
                          
                          <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                          <span class="ContentField">
                            <input type="text">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                              <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                              <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                              <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                              <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              <xsl:attribute name="maxlength">6</xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                            </input>
                          </span>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Numeric -->

                        <xsl:when test="current()[name()='Oneof']">
                        <div class="Row InputRow">
                          <xsl:attribute name="exp">
                            <xsl:value-of select="@exp"/>
                          </xsl:attribute>
                          <xsl:attribute name="rid">
                            <xsl:value-of select="@rid"/>
                          </xsl:attribute>
                          <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                          <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                          <xsl:if test="current()[@name='' or @name=' ']">
                            <xsl:attribute name="style">display: none</xsl:attribute>
                          </xsl:if>

                          <span class="TitleField OneOfNumericColor">
                            <xsl:value-of select="@name"/>
                          </span>
                          <span class="ContentField">
                            <select>
                              <xsl:attribute name="name">
                                <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                              </xsl:attribute>
                              <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                              <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                              <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
  <!--
                              <xsl:attribute name="disabled">true</xsl:attribute>
  -->
                              <xsl:if test="@cid">
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                              </xsl:if>
                              <xsl:variable name="SelectedVal" select="@crt" />
                              
                              <xsl:for-each select="Option">
                              <option>
                                <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                <xsl:if test="$SelectedVal=@val">
                                  <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </option>
                              </xsl:for-each>
                            </select>
                          </span>
                          <div class="ClearBoth"></div>
                          
                          <span class="HelpField" style="display: none">
                            <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            <div class="HelpPopMsg">&#160;</div>
                          </span>
                        </div><!-- Row -->
                        </xsl:when><!-- Oneof -->
                      </xsl:choose>
                    </xsl:for-each>
                  </div><!-- End of ExitInfo -->
                  
                </div><!-- StdBody -->
                
                <div id="InnerBody" style="display: none">
                  <div class="ControlBar">
                    <span class="InnerTitle SubSecTitle">Loading...</span>
                    <span class="InnerBoddyClose"><img src="Images/Close.png" height="24" /></span>
                    <span class="ClearBoth"></span>
                  </div>
                  <br />
                  <div class="InnerBoddyContent">
                    <xsl:for-each select="Formset/Form[@fid!='0' and @fid!='1']">
                    <div class="FormFrame" style="display: none">
                      <xsl:attribute name="id">form<xsl:value-of select="@fid"/></xsl:attribute>
                      <xsl:if test="current()/Subtitle[position()=1]">
                        <xsl:choose>
                          <xsl:when test="Pmt != '' and Pmt != ' '">
                            <xsl:attribute name="title"><xsl:value-of select="Pmt"/></xsl:attribute>
                          </xsl:when>
                          
                          <xsl:otherwise>
<!--                              <xsl:attribute name="name"><xsl:value-of select="../@name"/></xsl:attribute>-->
                            <xsl:attribute name="title"></xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                      
                      <xsl:for-each select="current()/*">
                        <xsl:variable name="SelectedFormSet" select="../../@name" />
                        <xsl:variable name="SelectedFormId" select="../@fid" />
                        <xsl:choose>
                          <xsl:when test="current()[name()='Subtitle']">
                            <xsl:choose>
                              <xsl:when test="Pmt != '' and Pmt != ' ' and position() != 1">
                              <div class="Row TxtRow">
                                <xsl:attribute name="exp">
                                  <xsl:value-of select="@exp"/>
                                </xsl:attribute>
                                <xsl:attribute name="rid">
                                  <xsl:value-of select="@rid"/>
                                </xsl:attribute>
                                
                                <div class="OneLineField"><xsl:value-of select="Pmt"/></div>
                              </div>
                              </xsl:when>

                              <xsl:when test="position() != 1 and position() != 2">
                              <div class="Row TxtRow">
                                <xsl:attribute name="exp">
                                  <xsl:value-of select="@exp"/>
                                </xsl:attribute>
                                <xsl:attribute name="rid">
                                  <xsl:value-of select="@rid"/>
                                </xsl:attribute>
                                &#160;
                              </div>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:when>

                          <xsl:when test="current()[name()='Txt']">
                            <xsl:choose>
                              <xsl:when test="Pmt != '' and Pmt != ' '">
                              <div class="Row TxtRow">
                                <xsl:attribute name="exp">
                                  <xsl:value-of select="@exp"/>
                                </xsl:attribute>
                                <xsl:attribute name="rid">
                                  <xsl:value-of select="@rid"/>
                                </xsl:attribute>
                                <span class="TitleField"><xsl:value-of select="Pmt"/></span>
                                <span class="ContentField"><xsl:value-of select="Cont"/></span>
                              </div>
                              </xsl:when>
                              
                              <xsl:when test="(Pmt = '' or Pmt = ' ') and position() != 1">
                              <div class="Row TxtRow">
                                &#160;
                              </div>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:when><!-- Txt -->
                          
                          <xsl:when test="current()[name()='Ref' and Pmt!='' and Pmt!=' ']">
                          <div class="Row TxtRow">
                            <xsl:attribute name="exp">
                              <xsl:value-of select="@exp"/>
                            </xsl:attribute>
                            <xsl:attribute name="rid">
                              <xsl:value-of select="@rid"/>
                            </xsl:attribute>
                            
                            <span class="TriangleImage">
                              <img src="Images/Triangle.png" height="16" />
                            </span>
                            <span class="ToPopupTitle">
                              <xsl:attribute name="fid">
                                <xsl:value-of select="@fid"/>
                              </xsl:attribute>
                              <xsl:value-of select="current()/Pmt"/>
                            </span>
                            
                            <!--
                            <span class="HelpField" style="display: none">
                              <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                            </span>
                            -->
                          </div>
                          </xsl:when><!-- Ref -->

                          <xsl:when test="current()[name()='Numeric']">
                          <div class="Row InputRow">
                            <xsl:attribute name="exp">
                              <xsl:value-of select="@exp"/>
                            </xsl:attribute>
                            <xsl:attribute name="rid">
                              <xsl:value-of select="@rid"/>
                            </xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                            <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                            <xsl:if test="current()[Pmt='' or Pmt=' ']">
                              <xsl:attribute name="style">display: none</xsl:attribute>
                            </xsl:if>
                            
                            <span class="TitleField OneOfNumericColor"><xsl:value-of select="Pmt"/></span>
                            <span class="ContentField">
                              <input type="text">
                                <xsl:attribute name="name">
                                  <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                                </xsl:attribute>
                                <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                                <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                                <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                                <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
                                <xsl:attribute name="min"><xsl:value-of select="@min"/></xsl:attribute>
                                <xsl:attribute name="max"><xsl:value-of select="@max"/></xsl:attribute>
                                <xsl:attribute name="step"><xsl:value-of select="@step"/></xsl:attribute>
                                <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                                <xsl:attribute name="size">8</xsl:attribute>
                                <xsl:attribute name="maxlength">6</xsl:attribute>
<!--
                                <xsl:attribute name="size"><xsl:value-of select="@max"/></xsl:attribute>
                                <xsl:attribute name="maxlength"><xsl:value-of select="@max"/></xsl:attribute>
-->
<!--
                                <xsl:attribute name="disabled">true</xsl:attribute>
-->
                              </input>
                            </span>
                            
                            <span class="HelpField" style="display: none">
                              <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                              <div class="HelpPopMsg">&#160;</div>
                            </span>
                          </div><!-- Row -->
                          </xsl:when><!-- Numeric -->

                          <xsl:when test="current()[name()='Oneof']">
                          <div class="Row InputRow">
                            <xsl:attribute name="exp">
                              <xsl:value-of select="@exp"/>
                            </xsl:attribute>
                            <xsl:attribute name="rid">
                              <xsl:value-of select="@rid"/>
                            </xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="@crt"/></xsl:attribute>
                            <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                            <xsl:if test="current()[@name='' or @name=' ']">
                              <xsl:attribute name="style">display: none</xsl:attribute>
                            </xsl:if>

                            <span class="TitleField OneOfNumericColor">
                              <xsl:value-of select="@name"/>
                            </span>
                            <span class="ContentField">
                              <select>
                                <xsl:attribute name="name">
                                  <xsl:value-of select="@offset"/>-<xsl:value-of select="@width"/>
                                </xsl:attribute>
                                <xsl:attribute name="cwidth"><xsl:value-of select="@width"/></xsl:attribute>
                                <xsl:attribute name="crt"><xsl:value-of select="@crt"/></xsl:attribute>
                                <xsl:attribute name="dft"><xsl:value-of select="@dft"/></xsl:attribute>
<!--
                                <xsl:attribute name="disabled">true</xsl:attribute>
-->
                                <xsl:if test="@cid">
                                  <xsl:attribute name="cid"><xsl:value-of select="@cid"/></xsl:attribute>
                                </xsl:if>
                                <xsl:variable name="SelectedVal" select="@crt" />
                                
                                <xsl:for-each select="Option">
                                <option>
                                  <xsl:attribute name="value"><xsl:value-of select="@val"/></xsl:attribute>
                                  <xsl:if test="$SelectedVal=@val">
                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                  </xsl:if>
                                  <xsl:value-of select="."/>
                                </option>
                                </xsl:for-each>
                              </select>
                            </span>
                            <div class="ClearBoth"></div>
                            
                            <span class="HelpField" style="display: none">
                              <div class="HelpContent"><xsl:value-of select="Help"/>&#160;</div>
                              <div class="HelpPopMsg">&#160;</div>
                            </span>
                          </div><!-- Row -->
                          </xsl:when><!-- Oneof -->
                        </xsl:choose>
                      </xsl:for-each>
                    </div>
                    </xsl:for-each>
                  
                  </div><!-- InnerBoddyContent -->
                </div><!-- InnerBody -->
                
              </form><!-- DataForm -->

            </div><!-- InfoBody -->
            
            <div id="HelpBody" class="" style="display: none;">
              &#160;
            </div><!-- End of HelpBody -->
            
            <div class="ClearBoth"></div>

          </div><!-- InnerFrame -->
      </span><!-- MainContent -->
      
      <hr />
      
    </div><!-- MainFrame -->
    
  </div><!-- MidFrame -->

  <div id="Footer">
    <p>Copyright © 2012 Insyde</p>
  </div><!-- Footer -->
  
  <!-- Fixed on the bottom of browser widown not bottom of html -->
  <div id="FixedBottomBar">
    <div style="width: 980px; height: inherit; margin: 0 auto;">
      <span id="FixedBottomInfo">&#160;</span>
      <span id="HelpMsgSwitch">
        <input type="checkbox" />Help Message
      </span>
<!--      <button type="button">Enable Help Message</button>
      <span id="HelpMsgSwitch">Enable Help Message</span>-->
      <span class="ClearBoth"></span>
    </div>
  </div><!-- FixedBottomBar -->

  <!-- Pop-up window ver1.1 -->
  <div id="PopupWin" style="display: none;">
    <div id="PopupBG">&#160;</div>
    <div id="PopupMain">
      <div id="PopupTitle">&#160;</div>
      <div id="LoadingImg" style="display: none;">
        <img src="Images/loading.gif" height="30" width="30" />
      </div>
      <div id="ProgressBar" style="display: none;">
        <table border="0" cellpadding="0" cellspacing="2" style="width:100%">
          <tbody>
            <tr>
              <td id="tdPopupProgress1">&#160; &#160;</td>
              <td id="tdPopupProgress2">&#160; &#160;</td>
              <td id="tdPopupProgress3">&#160; &#160;</td>
              <td id="tdPopupProgress4">&#160; &#160;</td>
              <td id="tdPopupProgress5">&#160; &#160;</td>
              <td id="tdPopupProgress6">&#160; &#160;</td>
              <td id="tdPopupProgress7">&#160; &#160;</td>
              <td id="tdPopupProgress8">&#160; &#160;</td>
              <td id="tdPopupProgress9">&#160; &#160;</td>
              <td id="tdPopupProgress10">&#160; &#160;</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div id="PopupCont">&#160;</div>
      <div id="PopupCtrl" style="display: none;">
        <button type="button" name="ok" style="display: none;">OK</button>
        <button type="button" name="yes" style="display: none;">Yes</button>
        <button type="button" name="no" style="display: none;">No</button>
        <button type="button" name="stop" style="display: none;">Stop</button>
      </div>
    </div><!-- PopupMain -->
  </div><!-- PopupWin -->
    
  <div id="InsertedJsCbArea" style="display: none">&#160;</div>
  <!-- Those scripts must at bottom of html on IE and Chrome, when this is xslt file -->
<!--  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>-->
<!--  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>-->
  <script type="text/javascript" src="Scripts/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="Scripts/jquery.hoverIntent.js"></script>-
  <script type="text/javascript" src="Scripts/common.js"></script>
  <script type="text/javascript" src="Scripts/formparser.js"></script>
  <script type="text/javascript" src="Scripts/popupwin.js"></script>
  <script type="text/javascript" src="Scripts/cookie.js"></script>
<!--
  <script type="text/javascript" src="Scripts/fwupload.js"></script>
  <script type="text/javascript" src="Scripts/ipparser.js"></script>
-->
  <script type="text/javascript" src="Scripts/setup.js"></script>
  <script type="text/javascript">
  window.onload = function() {
    InitTab ();
    AsyncInitialization ();
    InitFunctionBinding ();
    ClosePopup ();
  }
  </script>
  <noscript>
    Your browser does not support javascript!
  </noscript>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
