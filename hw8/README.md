ДЗ 8
<pre>
Размещаем свой RPM в своем репозитории
1) создать свой RPM (можно взять свое приложение, либо собрать к примеру апач с определенными опциями)
2) создать свой репо и разместить там свой RPM
реализовать это все либо в вагранте, либо развернуть у себя через nginx и дать ссылку на репо 
</pre>

Сбилдил nginx с модулем [Audio_track](https://www.nginx.com/resources/wiki/modules/audio_track/)
Конфиг лежит в nginx.spec
Реализовал все через Vagrant.