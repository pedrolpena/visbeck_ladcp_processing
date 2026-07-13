function img_save(fileName,print_formats,files)
ext=get_print_format_extension(print_formats);
fName=[fileName,'.',ext];
tmpFName=[files.tmp_dir,filesep,fileName,'.','png'];

if ~exist(files.plots_dir,'file')
    mkdir(files.plots_dir);
    
end

plotsFName=[files.plots_dir,filesep,fName];

if ~is_octave && strcmpi(print_formats,'jpg')
    print_formats='jpeg';
end

if strcmpi(ext,'jpg') || strcmpi(ext,'png')
    print_formats=[print_formats,' -r300'];
end

if ~exist(fName,'file') || ~isempty(strfind(fName,'16'))
    warnState = warning('off', 'all');
    eval(['print -dpng -r300 ',tmpFName]);
    if strcmpi(ext,'png')
        copyfile(tmpFName,plotsFName);
    else
        eval(['print -d',print_formats,' ',plotsFName]);
    end
    warning(warnState);
end
