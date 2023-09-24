#!/bin/sh
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo Cannot decompress $0; exit 1
fi; exit $res
BZh91AY&SYH��� �_�}����?�������@ �   @  �lm2�ɻۼ������xI!T���'��d�G�<���6��zFOB����4�Q�@�Hd Q���i43H22h� �"$4�M$�)�C�(?J�ꍢ4�d=A��� $R�i  4�44  h     4HF���������2P	�bd �24414�	P`��/>G=�����ҾJ��c��K$�P���l�ud�C�tN�nrfp��5�:����.H>��iѥ$$fV4�pY��!�k��k�}���Џ	�q���<�^x��^O7'�p�q�%�+K�C��1�q9ȕ��=�B��M���ϡn�*je�ɽ�ؙ���k[�o7�\�X:�H�ؓ�qT>ì�)f�����¼GZ�;-���Ud+F=���)'<wh���Z��iӲF\ӉWux[�梹J ������Þ'*\�`^��e��Q��c1���e��B[y"F�N��N���O���
-�7_�2礰{Y=Tc��]L��p'MN���썡ǯ)�ީ��o��1�����40�=:�k���������L�R)���Z^tM(���n'D�T�«��ā�O�@�f����i�0��9��׋��h�4���NR8C�%T>�܌�0>�rEһ�a���3�s�H&L�0�1�b���Z;jwq�+K�(��Tj��l,��s,��f��n8�����ٞ�����g�p�N�)?K�J*9��7�"&2+�|�3��7�s>�p}���{�2kq�g���S�	� ��Oޑ��םb�U��Xu M�T4��(��r�������k�9�{�����:�eG�;]����M�l�x8`�d8
<d6�ٯ4̼i�1Gs]p��*3�1��{�^�ר�ٹ�LI����2%N��%p(-��Uy��W�!gi��R-bh��łL0�#D&�M��@�fB���6+�H�cm&�Ȅ�+���W(oa<�%��u񿈾��}8=H�>GxS�B�t�-��HL�aEW�C����^�K�.Z�|�%9�˄!Y�޴�nyb~�U���H뒜��]��¬�����R��NbO�C�:�������%I��HF��S$f�=V��YU�g��A2S�0qޘ�-�٬<*��!q0��+64��^���ۭ�c���<��棞"mA��e�-��sNpA�k{tYC��J��x*H����R4�dߜg!"]-b�VJ3ɢ�L�=�w���i�p���)�]����j�j=�b��bR��$v�j�2��#g�.8\	I8<�r>�]�R��)(�R+E~2l���Е��K!3�Z��ؼ"�b�o�p&!$�n�eח���-�'� #>�Uлd�T�&�>K����t��rňb�X+λY�-���N�D�#+nZ�g.�ay$��+*�v�X�A�����_΄�������ĒzbУ�.�p� ���