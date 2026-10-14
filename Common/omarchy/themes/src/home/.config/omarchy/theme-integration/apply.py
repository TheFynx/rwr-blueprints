from pathlib import Path
import os,sys,json,base64,subprocess,configparser,shutil
home=Path.home();root=home/'.config/omarchy';current=home/'.local/state/omarchy/current/theme';state_dir=home/'.local/state/omarchy/theme-integration';state_dir.mkdir(parents=True,exist_ok=True)
statefile=state_dir/'state.json'
slug=(sys.argv[1] if len(sys.argv)>1 else (home/'.local/state/omarchy/current/theme.name').read_text().strip())
profiles=json.loads((Path(__file__).parent/'profiles.json').read_text())
active=slug in profiles
def run(*args):
 return subprocess.run(args,text=True,capture_output=True,timeout=15)
def get(key):return run('gsettings','get','org.gnome.desktop.interface',key).stdout.strip()
def setting(key,value):return run('gsettings','set','org.gnome.desktop.interface',key,value)
legacy=home/'.local/state/omarchy/minecraft-integration/state.json'
if not statefile.exists() and legacy.exists():
 statefile.write_bytes(legacy.read_bytes())
state=json.loads(statefile.read_text()) if statefile.exists() else {'active':False}
paths=[home/'.config/gtk-3.0/gtk.css',home/'.config/gtk-4.0/gtk.css',root/'branding/screensaver.txt',home/'.config/qt5ct/qt5ct.conf',home/'.config/qt6ct/qt6ct.conf',home/'.config/xsettingsd/xsettingsd.conf']
shellfile=root/'shell.json';cfg=json.loads(shellfile.read_text());entry=next(x for x in cfg['plugins'] if x.get('id')=='io.github.sirjul1337.lock-explorer')
if active:
 if not state.get('active'):
  state={'active':True,'files':{str(p):base64.b64encode(p.read_bytes()).decode() if p.exists() else None for p in paths},'design':entry.get('design','weather'),'cursor':get('cursor-theme'),'cursor_size':get('cursor-size'),'qt_env':os.environ.get('QT_QPA_PLATFORMTHEME','gtk3')}
 profile=profiles[slug];name=profile['icons']
 for ver in ['3.0','4.0']:
  p=home/f'.config/gtk-{ver}/gtk.css';p.parent.mkdir(parents=True,exist_ok=True)
  old=state['files'][str(p)]
  css=base64.b64decode(old).decode() if old is not None else ''
  p.write_text('/* Shared theme integration; restored on theme switch. */\n@import url("file://'+str(current/'gtk.css')+'");\n'+css)
 if (current/'screensaver.txt').exists():
  shutil.copy2(current/'screensaver.txt',root/'branding/screensaver.txt')
 else:
  original=state['files'][str(root/'branding/screensaver.txt')]
  if original is not None:(root/'branding/screensaver.txt').write_bytes(base64.b64decode(original))
  elif (root/'branding/screensaver.txt').exists():(root/'branding/screensaver.txt').unlink()
 for ver in ['5','6']:
  p=home/f'.config/qt{ver}ct/qt{ver}ct.conf';p.parent.mkdir(parents=True,exist_ok=True)
  conf=configparser.RawConfigParser();conf.optionxform=str
  if p.exists():conf.read(p)
  if not conf.has_section('Appearance'):conf.add_section('Appearance')
  for k,v in {'color_scheme_path':str(current/'qt.colors'),'custom_palette':'true','icon_theme':name,'style':'Fusion'}.items():conf.set('Appearance',k,v)
  if not conf.has_section('Interface'):conf.add_section('Interface')
  conf.set('Interface','stylesheets',str(current/'qt.qss'))
  with p.open('w') as f:conf.write(f,space_around_delimiters=False)
 entry['design']=profile['lock_design']
 shellfile.write_text(json.dumps(cfg,indent=2)+'\n')
 setting('icon-theme',name)
 run('hyprctl','keyword','env','QT_QPA_PLATFORMTHEME,qt5ct')
 run('dbus-update-activation-environment','--systemd','QT_QPA_PLATFORMTHEME=qt5ct')
 # XSettings palette/branding for X11 applications, without replacing user's daemon.
 p=home/'.config/xsettingsd/xsettingsd.conf';p.parent.mkdir(parents=True,exist_ok=True)
 original=state['files'][str(p)];text=base64.b64decode(original).decode() if original else ''
 lines=[l for l in text.splitlines() if not l.startswith('Net/IconThemeName')]
 p.write_text('\n'.join(lines)+f'\nNet/IconThemeName "{name}"\n')
 run('pkill','-HUP','-x','xsettingsd')
 run('omarchy-shell','lock','rescanDesigns')
 statefile.write_text(json.dumps(state,indent=2)+'\n')
 print('Applied shared lock, icons and app styling:',slug)
elif state.get('active'):
 for name,data in state['files'].items():
  p=Path(name)
  if data is None:
   if p.exists():p.unlink()
  else:p.write_bytes(base64.b64decode(data))
 entry['design']=state['design'];shellfile.write_text(json.dumps(cfg,indent=2)+'\n')
 qt=state['qt_env']
 run('hyprctl','keyword','env','QT_QPA_PLATFORMTHEME,'+qt)
 run('dbus-update-activation-environment','--systemd','QT_QPA_PLATFORMTHEME='+qt)
 run('pkill','-HUP','-x','xsettingsd')
 state['active']=False;statefile.write_text(json.dumps(state,indent=2)+'\n')
 print('Restored previous app styling, lock design and screensaver')

if statefile.exists():statefile.chmod(0o600)
