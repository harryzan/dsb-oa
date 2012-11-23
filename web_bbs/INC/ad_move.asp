<%sub admove()%>
<script>
var mvtLight="<%=MovePic%>"
var mvtWidth="<%=move_w%>"
var mvtHeight="<%=move_h%>"
var mvtLink="<%=MoveUrl%>"
brOK=navigator.javaEnabled()?true:false
ns4=(document.layers)?true:false
ie4=(document.all)?true:false
if(mvtLight!=""){if(ns4){document.write('<layer id="mvt" width=120 height=60;"><a href="'+mvtLink+'" target=_blank><img src="'+mvtLight+'" onmouseover=stopme("mvt") onmouseout=movechip("mvt") border=0 width="'+mvtWidth+'" height="'+mvtHeight+'"><\/a><\/layer>');}else{document.write('<div id="mvt" style="position:absolute; width:40; height:60; z-index:9; filter: Alpha(Opacity=80)"><a href="'+mvtLink+'" target=_blank><img src="'+mvtLight+'" onmouseover=stopme("mvt") onmouseout=movechip("mvt") border=0 width="'+mvtWidth+'" height="'+mvtHeight+'"><\/a><\/div>');}}
var vmin=2; var vmax=5; var vr=2; var timer1;
function Chip(chipname,width,height){ this.named=chipname; this.vx=vmin+vmax*Math.random(); this.vy=vmin+vmax*Math.random(); this.w=width; this.h=height; this.xx=0; this.yy=0; this.timer1=null; }
function movechip(chipname) {
if(brOK){eval("chip="+chipname); if(ns4){pageX=window.pageXOffset;pageW=window.innerWidth;pageY=window.pageYOffset;pageH=window.innerHeight;}else{pageX=window.document.body.scrollLeft;pageW=window.document.body.offsetWidth-8;pageY=window.document.body.scrollTop;pageH=window.document.body.offsetHeight;}chip.xx=chip.xx+chip.vx;chip.yy=chip.yy+chip.vy;chip.vx+=vr*(Math.random()-0.5);chip.vy+=vr*(Math.random()-0.5);
if(chip.vx>(vmax+vmin))	chip.vx=(vmax+vmin)*2-chip.vx;if(chip.vx<(-vmax-vmin)) chip.vx=(-vmax-vmin)*2-chip.vx;if(chip.vy>(vmax+vmin))	chip.vy=(vmax+vmin)*2-chip.vy;if(chip.vy<(-vmax-vmin)) chip.vy=(-vmax-vmin)*2-chip.vy;if(chip.xx<=pageX){chip.xx=pageX;chip.vx=vmin+vmax*Math.random();}
if(chip.xx>=pageX+pageW-chip.w){chip.xx=pageX+pageW-chip.w;chip.vx=-vmin-vmax*Math.random();}if(chip.yy<=pageY){chip.yy=pageY;chip.vy=vmin+vmax*Math.random();}if(chip.yy>=pageY+pageH-chip.h){chip.yy=pageY+pageH-chip.h;chip.vy=-vmin-vmax*Math.random();}
if(ns4){eval('document.'+chip.named+'.top ='+chip.yy);eval('document.'+chip.named+'.left='+chip.xx);}else{eval('document.all.'+chip.named+'.style.pixelLeft='+chip.xx);eval('document.all.'+chip.named+'.style.pixelTop ='+chip.yy);}chip.timer1=setTimeout("movechip('"+chip.named+"')",100);}}
function stopme(chipname){ if(brOK){ eval("chip="+chipname); if(chip.timer1!=null){clearTimeout(chip.timer1)}}}
var mvt;
function mvt() { mvt=new Chip("mvt",60,80); if(brOK){ movechip("mvt");}}
if(mvtLight!="")window.onload=mvt
</script>
<%end sub%>