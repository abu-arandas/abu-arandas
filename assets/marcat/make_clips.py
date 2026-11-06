import re,subprocess,sys
SRT='/mnt/project-files/tutorial-video/marcat-tutorial-en.srt'
MP4='/mnt/project-files/tutorial-video/marcat-tutorial-en.mp4'
def t(s):
    h,m,r=s.split(':'); sec,ms=r.split(','); return int(h)*3600+int(m)*60+int(sec)+int(ms)/1000
def f(x):
    x=max(0,x); h=int(x//3600); m=int(x%3600//60); s=int(x%60); ms=int(round((x-int(x))*1000)); 
    if ms==1000: ms=999
    return f"{h:02}:{m:02}:{s:02},{ms:03}"
cues=[]
for b in open(SRT,encoding='utf-8').read().strip().split('\n\n'):
    l=b.strip().split('\n'); a,c=l[1].split(' --> '); cues.append((t(a),t(c),'\n'.join(l[2:])))
def clip(name,start,end,crf):
    out=[]; 
    for a,c,txt in cues:
        if c>start and a<end: out.append((max(a,start)-start,min(c,end)-start,txt))
    srt=f'/tmp/claude-0/-home-user/c5d6ba7c-c3b3-57ff-8ee8-a4fab52e5f22/scratchpad/{name}.srt'
    open(srt,'w').write('\n\n'.join(f"{i+1}\n{f(a)} --> {f(c)}\n{x}" for i,(a,c,x) in enumerate(out))+'\n')
    style="FontName=DejaVu Sans,FontSize=14,PrimaryColour=&H00FFFFFF,OutlineColour=&H80000000,BorderStyle=3,Outline=4,Shadow=0,MarginV=22"
    vf=f"scale=1280:720,subtitles={srt}:force_style='{style}'"
    fade_out=end-start-0.6
    cmd=['ffmpeg','-y','-loglevel','error','-ss',str(start),'-to',str(end),'-i',MP4,'-vf',vf+f",fade=t=in:st=0:d=0.4,fade=t=out:st={fade_out}:d=0.6",
         '-af',f"afade=t=in:st=0:d=0.3,afade=t=out:st={fade_out}:d=0.6",'-c:v','libx264','-preset','slow','-crf',str(crf),'-pix_fmt','yuv420p',
         '-c:a','aac','-b:a','96k','-movflags','+faststart',name+'.mp4']
    subprocess.run(cmd,check=True)
clips={'clip-intro':(0.0,24.6,26),'clip-shop-checkout':(56.3,108.8,26),'clip-back-office':(135.2,190.0,26),'clip-till':(255.6,314.7,26),'clip-arabic-dark':(314.7,330.6,26),'marcat-tutorial-720p':(0.0,334.0,33)}
for n in sys.argv[1:]: clip(n,*clips[n])
