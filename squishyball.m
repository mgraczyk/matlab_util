function [] = squishyball(fs, varargin)
%SQUISHYBALL Use Xiph's Squishyball tool to perform audio comparison testing on
%            the command line. 
%
% Usage: squishyball(fs, audio_samples_1, audio_samples_2, ...);
%   fs is sample rate in hz.
%   audio_samples_i is an NxM matrix of N samples and M channels to be compared.
%
% Requires squishyball, which can be installed from
%   github.com/mgraczyk/squishyball2.

narginchk(2, Inf);

num_audio_files = length(varargin);
audio_dir = fullfile(tempdir, 'matlab_squishyball');
[~, ~, ~] = mkdir(audio_dir);

audio_paths = cell(num_audio_files, 1);
for i = 1:num_audio_files
  input_name = inputname(i + 1);
  [~, random_name] = fileparts(tempname);
  audio_file_name = [random_name '_' input_name '.flac'];
  audio_path = fullfile(audio_dir, audio_file_name);
  audio_paths{i} = audio_path;
  audiowrite(audio_paths{i}, varargin{i}, fs);
end

squisyball_cmd = sprintf(...
    'xterm -e squishyball %s', strjoin(audio_paths, ' '));
[status, output] = system(squisyball_cmd);

if status ~= 0
  error('Squishyball failed with status %d: %s', status, output);
end

delete(audio_paths{:});

end
