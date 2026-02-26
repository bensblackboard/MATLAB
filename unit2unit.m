function y = unit2unit(value,init_unit,fin_unit)
% unit2unit takes an initial value with units init_unit (string) and
% performs the necessary dimensional analysis to convert it into a new
% value with units fin_unit (string). Value is allowed to be a vector in
% the case that you want to convert all elements of that vector from one
% unit to another.

% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% Created by: Benjamin Van Schaick
% Date Modified: 2/26/2026
% Version: 1.0.1
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% Physical constants defined by SI
h = 6.62607015*10^(-34); % Planck's constant, exactly, in J*s
c = 299792458; % Speed of light, exactly, in m/s

% Parse unit strings for simplicity later
init_unit = unitParse(init_unit);
fin_unit = unitParse(fin_unit);

% Perform the desired transformation
if isequal(init_unit,'Hertz') && isequal(fin_unit,'wavenumber')
    y = (1/(100*c))*value;
elseif isequal(init_unit,'J') && isequal(fin_unit,'wavenumber')
    y = (1/(100*h*c))*value;
elseif isequal(init_unit,'nm') && isequal(fin_unit,'wavenumber')
    y = 10^7./value;
elseif isequal(init_unit,'rad/s') && isequal(fin_unit,'wavenumber')
    y = (1/(200*pi*c))*value;
elseif isequal(init_unit,'wavenumber') && isequal(fin_unit,'Hertz')
    y = 100*c*value;
elseif isequal(init_unit,'wavenumber') && isequal(fin_unit,'J')
    y = 100*h*c*value;
elseif isequal(init_unit,'wavenumber') && isequal(fin_unit,'nm')
    y = 10^7./value;
elseif isequal(init_unit,'wavenumber') && isequal(fin_unit,'rad/s')
    y = 200*pi*c*value;
else
    error(['Unit conversion from ',init_unit,' to ',fin_unit,' is not supported.'])
end

function v = unitParse(u)
    token_warning = 0;
    v = u;
    if isequal(u,'Hertz') || isequal(u,'hertz') || isequal(u,'s^-1') || isequal(u,'s^(-1)') || isequal(u,'s^{-1}')
        if ~isequal(u,'Hertz')
            v = 'Hertz';
            token_warning = 'frequency in Hertz';
        end
    elseif isequal(u,'J') || isequal(u,'Joules') || isequal(u,'joules')
        if ~isequal(u,'J')
            v = 'J';
            token_warning = 'energy in Joules';
        end
    elseif isequal(u,'micron') || isequal(u,'microns') || isequal(u,'um')
        if ~isequal(u,'um')
            v = 'um';
            token_warning = 'wavelength in micrometers';
        end
    elseif isequal(u,'omega') || isequal(u,'rad/s') || isequal(u,'rad/sec')
        if ~isequal(u,'rad/s')
            v = 'rad/s';
            token_warning = 'angular frequency in radians per second';
        end
    elseif isequal(u,'Wavelength') || isequal(u,'wavelength') || isequal(u,'nm')
        if ~isequal(u,'nm')
            v = 'nm';
            token_warning = 'wavelength in nanometers';
        end
    elseif isequal(u,'Wavenumber') || isequal(u,'wavenumber') || isequal(u,'cm^-1') || isequal(u,'cm^(-1)') || isequal(u,'cm^{-1}')
        if ~isequal(u,'wavenumber')
            v = 'wavenumber';
            token_warning = 'wavenumber';
        end
    else
        error('Initial unit not recognized. Verify that your units are supported')
    end
    if ~isequal(token_warning,0)
        warning(['Your unit (',u,') was taken to mean ',token_warning,' and was converted to the system standard.'])
    end
end
end