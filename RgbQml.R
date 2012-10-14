RgbQml<-function(aa,flnm="NMDSTest.qml",labels=rownames(aa),attribute="cveecon4"){

# The input to the function should be a three column dataframe. By default rownmames are
# used as labels. You may use another vector of the same length. WARNING There is no
# error checking at all built into this function. Shorter vetors will get recycled and 
# produce the wrong results.
  
# MAKE SURE THAT YOU NAME THE ATTRIBUTE IN YOUR VECTOR LAYER THAT YOU WISH TO COLOUR
  
# To use the function you will probably have to check carefully that the header and
# footer information coincides with the QML style sheet that you are using
# There is no guarantee that it will give the results you want without tweaking
  
# A useful trick to is to open your style sheet in a text editor and then run a 
# find and replace on all commas. Replace them by an escaped comma /". You
#can then paste all the test into R and modify it as you need.
  
header<-"<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version=\"1.8.0-Lisboa\" minimumScale=\"0\" maximumScale=\"1e+08\" minLabelScale=\"0\" maxLabelScale=\"1e+08\" hasScaleBasedVisibilityFlag=\"0\" scaleBasedLabelVisibilityFlag=\"0\">
  <transparencyLevelInt>255</transparencyLevelInt>
  <classificationattribute>cveecon4</classificationattribute>
  <uniquevalue>
    <classificationfield>"

# So now add in the name of the attribute that is used for the classification field.
cat(header,attribute,"</classificationfield>",file=flnm,sep="")

#Below is the first part of the block that defines a style for each level.

fpart<-"  <label></label>
      <pointsymbol>hard:circle</pointsymbol>
      <pointsize>2</pointsize>
      <pointsizeunits>pixels</pointsizeunits>
      <rotationclassificationfieldname></rotationclassificationfieldname>
      <scaleclassificationfieldname></scaleclassificationfieldname>
      <symbolfieldname></symbolfieldname>
      <outlinecolor red=\"0\" blue=\"0\" green=\"0\"/>
      <outlinestyle>SolidLine</outlinestyle>
      <outlinewidth>0.26</outlinewidth>
      <fillcolor "

#And the next part
npart<-"/>
      <fillpattern>SolidPattern</fillpattern>
      <texturepath null=\"1\"></texturepath>
    </symbol>
"

#Now loop through the labels and glue it all in place

for (i in 1:length(labels)){
  level<-labels[i]  
  red<-round(aa[i,1]*255,0)
  blue<-round(aa[i,2]*255,0)
  green<-round(aa[i,3]*255,0)
  
  
  cat("
    <symbol>
      <lowervalue>",level,"</lowervalue>
      <uppervalue>",level,"</uppervalue>)",
    file=flnm,append=TRUE,sep="")
  
  cat(fpart,
      "red=\"",red,"\" blue=\"",blue,"\" green=\"",green,"\"",
      npart,
      file=flnm,append=TRUE,sep="")
}

#Finally add the footer

footer<-"</uniquevalue>
  <customproperties/>
<displayfield>gid</displayfield>
<label>0</label>
<labelattributes>
<label fieldname=\"\" text=\"Label\"/>
    <family fieldname=\"\" name=\"Ubuntu\"/>
    <size fieldname=\"\" units=\"pt\" value=\"12\"/>
    <bold fieldname=\"\" on=\"0\"/>
    <italic fieldname=\"\" on=\"0\"/>
    <underline fieldname=\"\" on=\"0\"/>
    <strikeout fieldname=\"\" on=\"0\"/>
    <color fieldname=\"\" red=\"0\" blue=\"0\" green=\"0\"/>
    <x fieldname=\"\"/>
    <y fieldname=\"\"/>
    <offset x=\"0\" y=\"0\" units=\"pt\" yfieldname=\"\" xfieldname=\"\"/>
    <angle fieldname=\"\" value=\"0\" auto=\"0\"/>
    <alignment fieldname=\"\" value=\"center\"/>
    <buffercolor fieldname=\"\" red=\"255\" blue=\"255\" green=\"255\"/>
    <buffersize fieldname=\"\" units=\"pt\" value=\"1\"/>
    <bufferenabled fieldname=\"\" on=\"\"/>
    <multilineenabled fieldname=\"\" on=\"\"/>
    <selectedonly on=\"\"/>
  </labelattributes>
<editform></editform>
<editforminit></editforminit>
<annotationform></annotationform>
<attributeactions/>
</qgis>"

cat(footer,file=flnm,append=TRUE)
}
